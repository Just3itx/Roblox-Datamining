-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T05:50:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local Flags = require(Foundation.Utility.Flags)
local StatusIndicator = require(Foundation.Components.StatusIndicator)
local StatusIndicatorSize = require(Foundation.Enums.StatusIndicatorSize)
local StatusIndicatorVariant = require(Foundation.Enums.StatusIndicatorVariant)
local _Types = require(Foundation.Components.Types)
local View = require(Foundation.Components.View)
local getStatusIndicatorSize = require(Foundation.Components.StatusIndicator.getStatusIndicatorSize)
local useTokens = require(Foundation.Providers.Style.useTokens)

local vector2 = Vector2.new(0.8885729807284855, 0.1853398044750813)

return React.memo(function(tbl1) -- name: TileIconIndicator
    local var1 = useTokens()
    local indicator = tbl1.indicator
    local bool1 = indicator.value ~= nil
    local size = if bool1 then if tbl1.isCompact then StatusIndicatorSize.Medium else StatusIndicatorSize.Large else StatusIndicatorSize.Small
    local var3 = if bool1 and not Flags.FoundationStatusIndicatorDesignUpdate then StatusIndicatorSize.Medium else size
    local statusIndicatorSize = getStatusIndicatorSize(var1, var3, bool1)
    local mask = indicator.mask or var1.Color.Surface.Surface_0
    local testId = `{tbl1.testId}--status-indicator`

    local createElement = React.createElement
    local var5 = View
    local tbl2 = {
        tag = "auto-x",
        Size = UDim2.fromOffset(0, statusIndicatorSize),
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(vector2.X, statusIndicatorSize / 2, vector2.Y, 0),
        ZIndex = 3
    }
    local tbl3 = { Indicator = 0 }
    local element

    if indicator.value ~= nil then
        element = React.createElement(StatusIndicator, {
            value = indicator.value,
            max = indicator.max,
            variant = indicator.variant or StatusIndicatorVariant.Emphasis,
            size = size,
            mask = mask,
            testId = testId
        })
    else
        element = React.createElement(
            StatusIndicator,
            {
                variant = indicator.variant or StatusIndicatorVariant.Emphasis,
                size = size,
                mask = mask,
                testId = testId
            }
        )
    end

    tbl3.Indicator = element
    return createElement(var5, tbl2, tbl3)
end)
