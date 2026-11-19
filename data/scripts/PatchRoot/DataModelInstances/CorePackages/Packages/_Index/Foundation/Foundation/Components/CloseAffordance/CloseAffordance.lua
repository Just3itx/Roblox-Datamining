-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T07:31:16Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local BuilderIcons = require(FoundationParent.BuilderIcons)
local Icon = require(Foundation.Components.Icon)
local React = require(FoundationParent.React)

local InputSize = require(Foundation.Enums.InputSize)

local IconVariant = BuilderIcons.IconVariant

local _IconSize = require(Foundation.Enums.IconSize)

local CloseAffordanceVariant = require(Foundation.Enums.CloseAffordanceVariant)

local _Radius = require(Foundation.Enums.Radius)

local useTokens = require(Foundation.Providers.Style.useTokens)
local usePresentationContext = require(Foundation.Providers.Style.PresentationContext).usePresentationContext
local withCommonProps = require(Foundation.Utility.withCommonProps)
local withDefaults = require(Foundation.Utility.withDefaults)

local Constants = require(Foundation.Constants)

local _Types = require(Foundation.Components.Types)
local View = require(Foundation.Components.View)

local useCloseAffordanceVariants = require(script.Parent.useCloseAffordanceVariants)

local tbl1 = {
    isDisabled = false,
    size = InputSize.Medium,
    variant = CloseAffordanceVariant.OverMedia,
    isCircular = false,
    hasPadding = true,
    testId = "--foundation-close-affordance"
}

return React.memo(React.forwardRef(function(arg1, ref) -- name: CloseAffordance
    local var1 = withDefaults(arg1, tbl1)
    local var2 = useTokens()
    local var3 = usePresentationContext()

    local var4 = useCloseAffordanceVariants(var2, var1.size, var1.variant, var3.colorNamespace, var1.hasPadding, var1.isCircular)

    local uDim = UDim.new(0, var4.container.radius)

    local cursor = React.useMemo(function()
        return {
            radius = uDim,
            offset = var2.Size.Size_150,
            borderWidth = var2.Stroke.Thicker
        }
    end, { var2, uDim })

    return React.createElement(
        View,
        withCommonProps(var1, {
            Size = var4.container.size,
            onActivated = var1.onActivated,
            selection = {
                Selectable = not var1.isDisabled and var1.Selectable,
                NextSelectionUp = var1.NextSelectionUp,
                NextSelectionDown = var1.NextSelectionDown,
                NextSelectionLeft = var1.NextSelectionLeft,
                NextSelectionRight = var1.NextSelectionRight
            },
            isDisabled = var1.isDisabled,
            padding = var4.container.padding,
            cornerRadius = uDim,
            stateLayer = var4.container.stateLayer,
            cursor = cursor,
            tag = var4.container.tag,
            GroupTransparency = if var1.isDisabled then Constants.DISABLED_TRANSPARENCY else nil,
            ref = ref
        }),
        {
            Icon = React.createElement(
                Icon,
                {
                    name = BuilderIcons.Icon.X,
                    variant = IconVariant.Regular,
                    size = var4.content.iconSize,
                    style = var4.content.style
                }
            )
        }
    )
end))
