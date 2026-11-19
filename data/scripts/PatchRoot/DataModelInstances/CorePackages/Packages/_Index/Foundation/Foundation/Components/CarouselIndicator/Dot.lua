-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T07:30:52Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local _Otter = require(FoundationParent.Otter)
local React = require(FoundationParent.React)
local ReactOtter = require(FoundationParent.ReactOtter)

local StateLayerMode = require(Foundation.Enums.StateLayerMode)
local _Types = require(Foundation.Components.Types)
local View = require(Foundation.Components.View)
local useTokens = require(Foundation.Providers.Style.useTokens)

return React.memo(React.forwardRef(function(arg1, ref) -- name: Dot
    local var1 = useTokens()
    local contrast = var1.Color.System.Contrast
    local var2 = if arg1.isActive then contrast.Transparency or 0 else 0.78
    local uDim = UDim.new(0, var1.Radius.Circle)

    local scale, var4 = ReactOtter.useAnimatedBinding(arg1.scale)
    local var5, var6 = ReactOtter.useAnimatedBinding(var2)

    React.useEffect(function()
        var4(ReactOtter.ease(arg1.scale, arg1.scaleEaseConfig))
    end, { arg1.scale, arg1.scaleEaseConfig })

    local selection = React.useMemo(function()
        return {
            Selectable = arg1.Selectable,
            NextSelectionUp = arg1.NextSelectionUp,
            NextSelectionDown = arg1.NextSelectionDown,
            NextSelectionLeft = arg1.NextSelectionLeft,
            NextSelectionRight = arg1.NextSelectionRight
        }
    end, {
        arg1.Selectable,
        arg1.NextSelectionUp,
        arg1.NextSelectionDown,
        arg1.NextSelectionLeft,
        arg1.NextSelectionRight
    })

    local var8 = React.useCallback(function()
        if arg1.onActivated ~= nil and not arg1.isActive then
            arg1.onActivated(arg1.page)
        end
    end, { arg1.isActive, arg1.onActivated, arg1.page })

    local stateLayer = React.useMemo(function()
        return {
            mode = if arg1.isActive then StateLayerMode.Inverse else StateLayerMode.Default
        }
    end, { arg1.isActive })

    React.useEffect(function()
        var6(ReactOtter.ease(var2, arg1.colorEaseConfig))
    end, { var2, arg1.colorEaseConfig })

    local createElement = React.createElement
    local var10 = View

    local tbl1 = {
        LayoutOrder = arg1.LayoutOrder,
        Size = UDim2.fromOffset(arg1.maxSize, arg1.maxSize),
        backgroundStyle = var5:map(function(transparency)
            return {
                Color3 = contrast.Color3,
                Transparency = transparency
            }
        end),
        cornerRadius = uDim,
        onActivated = 0,
        selection = 0,
        stateLayer = 0,
        ref = 0,
        testId = 0,
        scale = 0
    }

    if not arg1.onActivated then
        var8 = nil
    end

    tbl1.onActivated = var8
    tbl1.selection = selection
    tbl1.stateLayer = stateLayer
    tbl1.ref = ref
    tbl1.testId = arg1.testId
    tbl1.scale = scale
    return createElement(var10, tbl1)
end))
