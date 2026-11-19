-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T09:01:34Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local BuilderIcons = require(FoundationParent.BuilderIcons)

local _Types = require(Foundation.Components.Types)

local InputSize = require(Foundation.Enums.InputSize)

local InputVariant = require(Foundation.Enums.InputVariant)

local IconSize = require(Foundation.Enums.IconSize)

local _Radius = require(Foundation.Enums.Radius)

local Flags = require(Foundation.Utility.Flags)
local composeStyleVariant = require(Foundation.Utility.composeStyleVariant)
local getInputVariantsFactory = require(Foundation.Components.InputField.getInputVariantsFactory)

local _Tokens = require(Foundation.Providers.Style.Tokens)

local VariantsContext = require(Foundation.Providers.Style.VariantsContext)

local function computeProps(tbl1)
    return {
        container = {
            minHeight = tbl1.minContainerHeight,
            horizontalPadding = UDim.new(0, tbl1.horizontalPadding),
            radius = tbl1.radius,
            tag = tbl1.containerTag
        },
        textBox = {
            fontStyle = tbl1.typography
        },
        icon = {
            size = tbl1.iconSize
        },
        clearButton = {
            icon = tbl1.clearButtonIcon,
            padding = tbl1.clearButtonPadding
        }
    }
end

local function variantsFactory(arg1)
    return {
        common = {
            container = {
                fgStyle = if Flags.FoundationFixColorOnScrubbableNumberInput then arg1.Color.Shift.Shift_200 else nil,
                strokeStyle = arg1.Color.Stroke.Emphasis,
                strokeThickness = arg1.Stroke.Standard,
                tag = "row"
            },
            textBox = {
                tag = "text-align-x-left text-align-y-center clip content-emphasis gui-object-defaults"
            },
            icon = {
                style = arg1.Color.Content.Muted
            },
            clearButton = { tag = "auto-xy" }
        },
        sizes = {
            [InputSize.XSmall] = computeProps({
                radius = arg1.Radius.Small,
                containerTag = "size-full-600 gap-small",
                horizontalPadding = arg1.Padding.XSmall,
                typography = arg1.Typography.BodySmall,
                iconSize = IconSize.XSmall,
                minContainerHeight = arg1.Size.Size_600,
                clearButtonIcon = BuilderIcons.Icon.XSmall,
                clearButtonPadding = arg1.Padding.XSmall
            }),
            [InputSize.Small] = computeProps({
                radius = arg1.Radius.Medium,
                containerTag = "size-full-800 gap-medium",
                horizontalPadding = arg1.Padding.Small,
                typography = arg1.Typography.BodyMedium,
                iconSize = IconSize.XSmall,
                minContainerHeight = arg1.Size.Size_800,
                clearButtonIcon = BuilderIcons.Icon.XSmall,
                clearButtonPadding = arg1.Size.Size_150
            }),
            [InputSize.Medium] = computeProps({
                radius = arg1.Radius.Medium,
                containerTag = "size-full-1000 gap-large",
                horizontalPadding = arg1.Padding.Medium,
                typography = arg1.Typography.BodyMedium,
                iconSize = IconSize.Small,
                minContainerHeight = arg1.Size.Size_1000,
                clearButtonIcon = BuilderIcons.Icon.X,
                clearButtonPadding = arg1.Padding.Small
            }),
            [InputSize.Large] = computeProps({
                radius = arg1.Radius.Medium,
                containerTag = "size-full-1200 gap-large",
                horizontalPadding = arg1.Padding.Medium,
                typography = arg1.Typography.BodyLarge,
                iconSize = IconSize.Small,
                minContainerHeight = arg1.Size.Size_1200,
                clearButtonIcon = BuilderIcons.Icon.X,
                clearButtonPadding = arg1.Padding.Small
            })
        }
    }
end

return function(arg1, arg2, utility, arg3, bool1: boolean?, bool2: boolean?)
    local var1 = VariantsContext.useVariants("TextInput", variantsFactory, arg1)
    local var2 = VariantsContext.useVariants("InputField", getInputVariantsFactory, arg1)

    local variant = var2.variants[utility or InputVariant.Standard]

    return composeStyleVariant(
        var1.common,
        var2.sizes[arg2],
        var1.sizes[arg2],
        utility == InputVariant.Utility and {} or variant,
        if arg3 then var2.radius[arg3] else var2.defaultRadius[arg2],
        bool1 == nil and {} or var2.focusedState[bool1],
        bool2 == nil and {} or var2.errorState[bool2],
        utility ~= InputVariant.Utility and {} or variant
    )
end
