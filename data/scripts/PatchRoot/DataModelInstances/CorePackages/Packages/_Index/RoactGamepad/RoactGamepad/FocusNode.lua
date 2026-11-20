-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:10:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local Cryo = require(scriptParentParent.Cryo)

local FocusControllerInternalApi = require(script.Parent.FocusControllerInternalApi)
local inputBindingsEqual = require(script.Parent.inputBindingsEqual)
local debugPrint = require(script.Parent.debugPrint)
local Config = require(script.Parent.Config)

local module = {}
module.__index = module

function module.new(arg1, ref)
    local focusController = nil
    if arg1.parentFocusNode ~= nil then
        focusController = arg1.parentFocusNode.focusController
    elseif arg1.focusController ~= nil then
        focusController = arg1.focusController
    else
        error("Cannot create node without focus manager")
    end

    local self = setmetatable({ focusController = focusController, ref = ref, lastFocused = nil }, module)

    self:updateNavProps(arg1)

    return self
end

function module:__getFocusControllerInternal()
    return self.focusController[FocusControllerInternalApi]
end

function module:__findDefaultChildNode()
    local huge = math.huge
    local var1 = nil

    local children = self:__getFocusControllerInternal():getChildren(self)
    local value = self.ref:getValue()

    for k, child in pairs(children) do
        local value2 = k:getValue()

        while value2 ~= value and value2 ~= nil do
            if value2:isA("GuiObject") then
                local layoutOrder = value2.LayoutOrder

                if layoutOrder ~= 0 then
                    if layoutOrder < huge then
                        var1 = child
                        huge = layoutOrder
                    end

                    break
                end
            end

            value2 = value2.Parent
        end
    end

    if var1 ~= nil then
        return var1
    end

    for k, child in pairs(children) do
        if k:getValue() ~= nil then
            return child
        end
    end

    return nil
end

function module:updateNavProps(arg1)
    local restorePreviousChildFocus = not (arg1.restorePreviousChildFocus == nil) and arg1.restorePreviousChildFocus
    local inputBindings = self.inputBindings

    self.defaultChildRef = arg1.defaultChild
    self.restorePreviousChildFocus = restorePreviousChildFocus
    self.inputBindings = arg1.inputBindings or {}

    local var1 = self:__getFocusControllerInternal()
    if var1:isNodeFocused(self) and not inputBindingsEqual(inputBindings, self.inputBindings) then
        var1:updateInputBindings()
    end
end

function module:focus()
    if not Config.Enabled then
        return
    end

    local var1 = self:__getFocusControllerInternal()
    if not var1:isInitialized() then
        return
    end

    var1:setInProgressFocus(self)
    local children = var1:getChildren(self)
    if Cryo.isEmpty(children) then
        var1:setSelection(self.ref:getValue())
        return
    end
    local now = os.clock()
    local bool1 = not (self.defaultChildRef == nil or var1.allNodes[self.defaultChildRef] == nil)
        and self.defaultChildRef:getValue() ~= nil
    local bool2 = self.timeout == nil or now < self.timeout

    if self.restorePreviousChildFocus and self.lastFocused ~= nil and self.lastFocused:getValue() then
        debugPrint("[FOCUS] Restore previous focus:", self.lastFocused)
        var1:moveFocusTo(self.lastFocused)
        return
    end
    if self.defaultChildRef and (bool2 or bool1) then
        if bool1 then
            debugPrint("[FOCUS] Found valid default child", self.defaultChildRef, "for", self.ref)
            self.timeout = nil
            var1:moveFocusTo(self.defaultChildRef)
            return
        end

        if self.timeout == nil then
            debugPrint("[FOCUS] Default child specified is not valid. Wait for it to be assigned...")
            self.timeout = now + 0.5
        end
        task.delay(0, function()
            if var1:isInProgressFocus(self) then
                self:focus()
            end
        end)
    else
        if self.timeout ~= nil then
            debugPrint("[FOCUS] Timeout for default child of", self.ref)
            self.timeout = nil
        end
        local var2 = self:__findDefaultChildNode()
        if var2 ~= nil then
            debugPrint("[FOCUS] No default, use fallback logic to focus", var2.ref)
            var2:focus()
            return
        end

        var1:setFocusedLeaf(self)
        var1:setInProgressFocus(nil)
    end
end

function module:attachToTree(parent, callback)
    local var1 = self:__getFocusControllerInternal()
    var1:registerNode(parent, self.ref, self)

    self.parent = parent
    self.disconnectSelectionListener = var1:subscribeToSelectionChange(function()
        local var2 = var1:isNodeFocused(self)
        callback(var2)

        if self.parent ~= nil and var2 then
            self.parent.lastFocused = self.ref
        end

        local children = var1:getChildren(self)
        if not Cryo.isEmpty(children) and var2 and var1:getSelection() == self.ref:getValue() then
            self:focus()
        end
    end)
end

function module:detachFromTree()
    self:__getFocusControllerInternal():deregisterNode(self.parent, self.ref)

    if self.disconnectSelectionListener ~= nil then
        self.disconnectSelectionListener()
        self.disconnectSelectionListener = nil
    end
end

return module
