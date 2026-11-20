-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T05:50:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local _BuilderIcons = require(FoundationParent.BuilderIcons)
local _ControlState = require(Foundation.Enums.ControlState)
local Icon = require(Foundation.Components.Icon)
local TileIconIndicator = require(script.Parent.TileIconIndicator)
local View = require(Foundation.Components.View)
local blendColors = require(Foundation.Utility.blendColors)
local getStateLayerStyle = require(Foundation.Components.Interactable.getStateLayerStyle)
local useTokens = require(Foundation.Providers.Style.useTokens)

return React.memo(function(tbl1) -- name: TileIconMedia
    local var1 = useTokens()
    local size600 = var1.Size.Size_600
    local size1000 = var1.Size.Size_1000

    local size1200 = var1.Size.Size_1200

    local var2, var3 = React.useBinding(0)
    local isCompact, var5 = React.useState(false)
    local onAbsoluteSizeChanged = React.useCallback(function(arg1)
        var3(arg1.AbsoluteSize.X)
        var5(arg1.AbsoluteSize.X <= size1200)
    end, { size1200 })

    return React.createElement(View, {
        tag = "size-full-full radius-circle",
        backgroundStyle = if tbl1.controlState then tbl1.controlState:map(function(arg1)
            return blendColors(var1.Color.Shift.Shift_200, getStateLayerStyle(var1, nil, arg1))
        end) else var1.Color.Shift.Shift_200,
        onAbsoluteSizeChanged = onAbsoluteSizeChanged,
        testId = `{tbl1.testId}--circle`
    }, {
        Icon = React.createElement(Icon, {
            name = tbl1.icon,
            variant = tbl1.iconVariant,
            size = var2:map(function(num1: number): number
                return math.clamp(math.round(num1 * 0.4), size600, size1000)
            end),
            style = var1.Color.Content.Emphasis,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale(0.5, 0.5),
            testId = `{tbl1.testId}--icon`
        }),
        Indicator = if tbl1.indicator then React.createElement(TileIconIndicator, { indicator = tbl1.indicator, isCompact = isCompact, testId = tbl1.testId }) else nil
    })
end)
