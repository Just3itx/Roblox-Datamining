-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T04:30:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local DividerVariant = require(Foundation.Enums.DividerVariant)
local Orientation = require(Foundation.Enums.Orientation)
local _Types = require(Foundation.Components.Types)
local View = require(Foundation.Components.View)
local useDividerVariants = require(script.Parent.useDividerVariants)
local useTokens = require(Foundation.Providers.Style.useTokens)
local withCommonProps = require(Foundation.Utility.withCommonProps)
local withDefaults = require(Foundation.Utility.withDefaults)

local tbl1 = {
    variant = DividerVariant.Default,
    orientation = Orientation.Horizontal,
    testId = "--foundation-divider"
}

return React.memo(React.forwardRef(function(arg1, ref) -- name: Divider
    local var1 = withDefaults(arg1, tbl1)
    local var2 = useTokens()
    local var3 = useDividerVariants(var2, var1.variant, var1.orientation)
    local bool1 = var1.variant == DividerVariant.Heavy and var1.orientation ~= Orientation.Vertical
    return React.createElement(View, withCommonProps(var1, { tag = var3.container.tag, ref = ref }), {
        DividerStroke = React.createElement(View, { Size = var3.stroke.Size, backgroundStyle = var3.stroke.backgroundStyle }),
        DividerLine = if bool1 then React.createElement(
            View,
            {
                tag = var3.line.tag,
                Position = var3.line.position,
                backgroundStyle = var3.line.backgroundStyle
            }
        ) else nil
    })
end))
