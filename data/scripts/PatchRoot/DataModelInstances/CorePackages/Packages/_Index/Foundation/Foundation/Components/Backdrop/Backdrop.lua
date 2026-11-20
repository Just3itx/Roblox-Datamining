-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T03:51:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent
local Dash = require(FoundationParent.Dash)
local React = require(FoundationParent.React)

local Constants = require(Foundation.Constants)
local StateLayerAffordance = require(Foundation.Enums.StateLayerAffordance)
local _Types = require(Foundation.Components.Types)
local View = require(Foundation.Components.View)
local mapBindable = require(Foundation.Utility.mapBindable)
local useTokens = require(Foundation.Providers.Style.useTokens)
local withCommonProps = require(Foundation.Utility.withCommonProps)
local withDefaults = require(Foundation.Utility.withDefaults)

local tbl1 = {
    transparency = 0,
    Size = UDim2.fromScale(2, 2),
    testId = "--foundation-backdrop"
}

return React.memo(React.forwardRef(function(arg1, ref) -- name: Backdrop
    local var1 = withDefaults(arg1, tbl1)
    local var2 = useTokens()
    return React.createElement(
        View,
        withCommonProps(var1, {
            Size = var1.Size,
            backgroundStyle = mapBindable(var1.transparency, function(num1: number)
                return {
                    Color3 = var2.Color.Common.Backdrop.Color3,
                    Transparency = math.lerp(var2.Color.Common.Backdrop.Transparency, 1, num1)
                }
            end),
            onActivated = var1.onActivated or Dash.noop,
            selection = Constants.MODAL.DISABLE_SELECTION,
            stateLayer = {
                affordance = StateLayerAffordance.None
            },
            tag = {
                ["position-center-center"] = var1.Position == nil,
                ["anchor-center-center"] = var1.AnchorPoint == nil
            },
            ref = ref
        })
    )
end))
