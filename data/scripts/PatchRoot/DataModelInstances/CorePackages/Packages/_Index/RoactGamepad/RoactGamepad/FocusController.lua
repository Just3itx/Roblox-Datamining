-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:10:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local Cryo = require(scriptParentParent.Cryo)

local Input = require(script.Parent.Input)
local createSignal = require(script.Parent.createSignal)
local debugPrint = require(script.Parent.debugPrint)

local FocusControllerInternalApi = require(script.Parent.FocusControllerInternalApi)

local module = {}
module.__index = module

function module.new()
    return (setmetatable({
        selectionChangedSignal = createSignal(),
        boundInputsChangedSignal = createSignal(),
        focusNodeTree = {},
        allNodes = {},
        rootRef = nil,
        engineInterface = nil,
        captureFocusOnInitialize = false,
        moveFocusToOnInitialize = nil,
        inputDisconnectors = {},
        boundInputs = {},
        focusedLeaf = nil,
        inProgressFocus = nil
    }, module))
end

function module:isInitialized(): boolean
    return self.engineInterface ~= nil
end

function module:moveFocusTo(moveFocusToOnInitialize)
    if self.engineInterface == nil then
        self.moveFocusToOnInitialize = moveFocusToOnInitialize
        return
    end

    debugPrint("[FOCUS] Move focus to", moveFocusToOnInitialize)
    local var1 = self.allNodes[moveFocusToOnInitialize]

    if var1 ~= nil and not self:isNodeFocused(var1) then
        var1:focus()
    end
    self:debugPrintTree()
end

function module:moveFocusToNeighbor(arg1)
    if self.engineInterface == nil then
        error("FocusController is not connected to a component hierarchy!", 2)
    end

    if self.focusedLeaf == nil then
        return
    end

    debugPrint("[FOCUS] Move focus to", arg1, "from", self.focusedLeaf.ref)
    local value = self.focusedLeaf.ref:getValue()
    if value ~= nil and value[arg1] ~= nil then
        self:setSelection(value[arg1])
    end
end

function module:getSelection()
    return self.engineInterface.getSelection()
end

function module:setSelection(arg1)
    self.engineInterface.setSelection(arg1)
end

function module:registerNode(arg1, rootRef, arg2)
    if arg1 ~= nil then
        debugPrint("[TREE ] Registering child node", rootRef)

        local var1 = self.focusNodeTree[arg1] or {}
        var1[rootRef] = arg2
        self.focusNodeTree[arg1] = var1
        self.allNodes[rootRef] = arg2

        self:descendantAddedRefocus()
        return
    end
    debugPrint("[TREE ] Registering root node", rootRef)
    self.rootRef = rootRef
    self.allNodes[rootRef] = arg2

    if self.captureFocusOnRootRegistered then
        self.captureFocusOnRootRegistered = false
        self:captureFocus()
    end
end

function module:deregisterNode(arg1, arg2)
    if arg1 == nil then
        debugPrint("[TREE ] Deregistering root node", arg2)
        self.allNodes[arg2] = nil

        return
    end

    debugPrint("[TREE ] Deregistering child node", arg2)
    self.focusNodeTree[arg1][arg2] = nil
    self.allNodes[arg2] = nil

    self:descendantRemovedRefocus()
end

function module:needsDescendantRemovedRefocus()
    if self.focusedLeaf ~= nil then
        return self.focusedLeaf.ref:getValue() == nil
    end
end

function module:descendantRemovedRefocus()
    if not self:needsDescendantRemovedRefocus() then
        return
    end

    debugPrint("[FOCUS] Focused node was removed; refocusing from nearest existing ancestor")

    local parent = self.focusedLeaf.parent
    while parent ~= nil and self.allNodes[parent.ref] == nil do
        parent = parent.parent
    end

    if parent ~= nil then
        parent:focus()
    end
end

function module:needsDescendantAddedRefocus()
    if self.focusedLeaf == nil then
        return nil
    end

    return not Cryo.isEmpty(self:getChildren(self.focusedLeaf))
end

function module:descendantAddedRefocus()
    if self:needsDescendantAddedRefocus() then
        debugPrint("[FOCUS] Currently-focused node is no longer a leaf; refocusing", self.focusedLeaf.ref)
        self.focusedLeaf:focus()
    end
end

function module:getChildren(arg1)
    return self.focusNodeTree[arg1] or {}
end

function module:isNodeFocused(focusedLeaf)
    if self.focusedLeaf == nil then
        return false
    end

    if self.focusedLeaf == focusedLeaf then
        return true
    end

    local parent = self.focusedLeaf.parent
    while parent ~= nil do
        if parent == focusedLeaf then
            return true
        end

        parent = parent.parent
    end

    return false
end

function module:setFocusedLeaf(focusedLeaf)
    self.focusedLeaf = focusedLeaf
end

function module:setInProgressFocus(inProgressFocus)
    self.inProgressFocus = inProgressFocus
end

function module:isInProgressFocus(inProgressFocus): boolean
    return self.inProgressFocus == inProgressFocus
end

function module:debugPrintTree()
    if not debugPrint.isEnabled then
        return
    end

    local function recursePrintTree(arg1, arg2)
        local str1 = tostring(arg1.ref)
        if self:isNodeFocused(arg1) then
            str1 ..= "*"
        end

        debugPrint(arg2, str1)

        local children = self:getChildren(arg1)
        for _, child in pairs(children) do
            recursePrintTree(child, arg2 .. "  ")
        end
    end

    debugPrint("Focus Node Tree:")
    recursePrintTree(self.allNodes[self.rootRef], "  ")
end

function module:updateInputBindings()
    local focusedLeaf = self.focusedLeaf
    local tbl1 = ({})

    while focusedLeaf ~= nil do
        for _, inputBinding in pairs(focusedLeaf.inputBindings) do
            local uniqueKey = Input.getUniqueKey(inputBinding)
            if tbl1[uniqueKey] == nil then
                debugPrint("[INPUT] Bind input", uniqueKey)
                tbl1[uniqueKey] = inputBinding
            end
        end

        focusedLeaf = focusedLeaf.parent
    end

    for _, inputDisconnector in pairs(self.inputDisconnectors) do
        inputDisconnector()
    end

    self.inputDisconnectors = {}
    self.boundInputs = {}
    for k, value in pairs(tbl1) do
        self.inputDisconnectors[k] = Input.connectToEvent(value, self.engineInterface)
        if value.keyCode then
            self.boundInputs[value.keyCode] = value.meta or {}
        end
    end
    self.boundInputsChangedSignal:fire(self.boundInputs)
end

function module:initialize(engineInterface)
    if self.engineInterface ~= nil then
        error("FocusController cannot be initialized more than once; make sure you are not passing it to multiple components")
    end

    self.engineInterface = engineInterface

    self.guiServiceConnection = engineInterface.subscribeToSelectionChanged(function()
        if self.rootRef == nil then
            return
        end

        local bool1 = self.focusedLeaf ~= nil

        self.focusedLeaf = nil
        local selection = engineInterface.getSelection()
        local value = self.rootRef:getValue()

        if selection ~= nil and (value == selection or selection:IsDescendantOf(value)) then
            debugPrint("[EVENT] Selection changed to", selection, "in focus hierarchy beginning at", value)

            for k, focusedLeaf in pairs(self.allNodes) do
                if selection == k:getValue() then
                    self.focusedLeaf = focusedLeaf
                    break
                end
            end
        end

        if self.focusedLeaf ~= nil or bool1 then
            self.selectionChangedSignal:fire()

            self:updateInputBindings()
        end
    end)

    if self.captureFocusOnInitialize then
        self:captureFocus()
    end

    if self.moveFocusToOnInitialize then
        self:moveFocusTo(self.moveFocusToOnInitialize)
    end
end

function module:captureFocus()
    if self.engineInterface == nil then
        self.captureFocusOnInitialize = true
    elseif self.rootRef == nil then
        self.captureFocusOnRootRegistered = true
    else
        self.allNodes[self.rootRef]:focus()
        self:debugPrintTree()
    end
end

function module:releaseFocus()
    if self.engineInterface ~= nil then
        self.engineInterface.setSelection(nil)
    end
    self.captureFocusOnInitialize = false
    self.captureFocusOnRootRegistered = false
end

function module:teardown()
    if self.guiServiceConnection ~= nil then
        self.guiServiceConnection:Disconnect()
    end

    for _, inputDisconnector in pairs(self.inputDisconnectors) do
        inputDisconnector()
    end

    self.rootRef = nil
    self.engineInterface = nil
    self.captureFocusOnInitialize = false
    self.captureFocusOnRootRegistered = false
    self.focusedLeaf = nil
end

function module:subscribeToSelectionChange(arg1)
    debugPrint("[TREE ] New subscription to selection change event")
    return self.selectionChangedSignal:subscribe(arg1)
end

function module.createPublicApiWrapper()
    local module2 = module.new()

    return {
        [FocusControllerInternalApi] = module2,
        moveFocusTo = function(...)
            module2:moveFocusTo(...)
        end,
        moveFocusLeft = function()
            module2:moveFocusToNeighbor("NextSelectionLeft")
        end,
        moveFocusRight = function()
            module2:moveFocusToNeighbor("NextSelectionRight")
        end,
        moveFocusUp = function()
            module2:moveFocusToNeighbor("NextSelectionUp")
        end,
        moveFocusDown = function()
            module2:moveFocusToNeighbor("NextSelectionDown")
        end,
        captureFocus = function()
            module2:captureFocus()
        end,
        releaseFocus = function()
            module2:releaseFocus()
        end,
        getCurrentFocus = function()
            local focusedLeaf = module2.focusedLeaf
            return focusedLeaf and focusedLeaf.ref or nil
        end,
        getBoundInputs = function()
            return module2.boundInputs
        end,
        subscribeToBoundInputsChanged = function(arg1)
            return module2.boundInputsChangedSignal:subscribe(arg1)
        end
    }
end

return module
