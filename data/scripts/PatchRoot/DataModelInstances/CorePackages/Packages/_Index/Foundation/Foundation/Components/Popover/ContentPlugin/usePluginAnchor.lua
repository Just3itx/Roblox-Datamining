-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T05:20:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)
local ReactRoblox = require(FoundationParent.ReactRoblox)

local OverlayContext = require(Foundation.Providers.Overlay.OverlayContext)
local _StudioUri = require(Foundation.Utility.Plugin.StudioUri)
local _Types = require(Foundation.Components.Types)
local View = require(Foundation.Components.View)
local useUniqueWidget = require(Foundation.Providers.StudioWidgets.useUniqueWidget)

local function usePluginAnchor(current, uri)
    local var1 = React.useContext(OverlayContext)
    local isVirtual = not (current == nil) and typeof(current) ~= "Instance"
    local var2 = React.useRef(nil)
    if not isVirtual and typeof(current) == "Instance" then
        var2.current = current
    end

    local var3, var4 = React.useState(nil)
    local var5 = React.useRef(nil)
    var5.current = var3

    local ref = React.useCallback(function(arg2)
        var4(arg2)
    end, { var4 })

    local var7 = useUniqueWidget
    local tbl1 = { forwardRef = 0 }
    if isVirtual then
        var2 = var5
    end

    tbl1.forwardRef = var2
    local var8 = var7(tbl1)

    local var9, var10 = React.useState(Vector2.zero)
    local var11, var12 = React.useState(Vector2.one)
    local var13, var14 = React.useState(Vector2.zero)

    React.useLayoutEffect(function()
        if not isVirtual or current == nil then
            return
        end

        local var15 = current
        local function updateFromAnchor() -- Luacid: Inlined by compiler; 1 call site recovered
            var10(var15.AbsolutePosition)
            var12(var15.AbsoluteSize)
        end

        updateFromAnchor()
        local connection = var15:GetPropertyChangedSignal("AbsolutePosition"):Connect(updateFromAnchor)
        local connection2 = var15:GetPropertyChangedSignal("AbsoluteSize"):Connect(updateFromAnchor)

        return function()
            connection:Disconnect()
            connection2:Disconnect()
        end
    end, { current, isVirtual })

    React.useLayoutEffect(function()
        if isVirtual then
            var1.requestOverlay()
        end
    end, { var1.requestOverlay, isVirtual })

    React.useLayoutEffect(function()
        if not isVirtual then
            return
        end

        local instance = var1.instance
        if instance == nil or not instance:IsA("GuiObject") then
            var14(Vector2.zero)
            return
        end

        local function updateOffset() -- Luacid: Inlined by compiler; 1 call site recovered
            var14(instance.AbsolutePosition)
        end

        updateOffset()
        local connection = instance:GetPropertyChangedSignal("AbsolutePosition"):Connect(updateOffset)
        return function()
            connection:Disconnect()
        end
    end, { var1.instance, isVirtual })

    local bool2 = not (current == nil) and (not isVirtual or var1.instance ~= nil)
    local portal

    if isVirtual and var1.instance then
        local element = React.createElement(View, {
            Position = UDim2.fromOffset(var9.X - var13.X, var9.Y - var13.Y),
            Size = UDim2.fromOffset(var11.X, var11.Y),
            Visible = true,
            ref = ref
        })

        portal = ReactRoblox.createPortal(element, var1.instance)
    else
        portal = nil
    end

    return {
        uri = if uri == nil then var8.uri else uri,
        element = portal,
        isVirtual = isVirtual,
        isReady = uri ~= nil or bool2
    }
end

return usePluginAnchor
