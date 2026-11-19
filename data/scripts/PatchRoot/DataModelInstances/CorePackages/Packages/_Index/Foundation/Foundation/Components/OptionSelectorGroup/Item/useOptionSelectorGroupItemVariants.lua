-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T08:30:56Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")

local IconSize = require(Foundation.Enums.IconSize)

local _InputSize = require(Foundation.Enums.InputSize)

local OptionSelectorGroupSize = require(Foundation.Enums.OptionSelectorGroupSize)

local FillBehavior = require(Foundation.Enums.FillBehavior)

local Orientation = require(Foundation.Enums.Orientation)

local composeStyleVariant = require(Foundation.Utility.composeStyleVariant)

local _Tokens = require(Foundation.Providers.Style.Tokens)

local _Types = require(Foundation.Components.Types)

local VariantsContext = require(Foundation.Providers.Style.VariantsContext)

local function groupSizeVariantsFactory(arg1)
    local common = {
        container = { tag = "col align-x-left align-y-center gap-xsmall" },
        content = arg1.Color.Content.Emphasis,
        supportingContent = arg1.Color.Content.Default,
        label = { tag = "content-emphasis" },
        metadata = { tag = "content-default" },
        description = { tag = "content-default" }
    }

    local tbl2 = {
        container = {
            tag = "padding-xlarge radius-medium",
            radius = arg1.Radius.Medium
        },
        icon = {
            size = IconSize.Medium,
            extent = arg1.Size.Size_500
        },
        label = { tag = "text-title-medium" },
        metadata = { tag = "text-caption-medium" },
        description = { tag = "text-body-medium" }
    }

    local tbl3 = {
        container = {
            tag = "padding-large radius-medium",
            radius = arg1.Radius.Medium
        },
        icon = {
            size = IconSize.Small,
            extent = arg1.Size.Size_400
        },
        label = { tag = "text-title-small" },
        metadata = { tag = "text-caption-small" },
        description = { tag = "text-body-small" }
    }

    local tbl4 = {
        container = {
            tag = "padding-medium radius-small",
            radius = arg1.Radius.Small
        },
        icon = {
            size = IconSize.XSmall,
            extent = arg1.Size.Size_300
        },
        label = { tag = "text-title-small" },
        metadata = { tag = "text-caption-small" },
        description = { tag = "text-body-small" }
    }

    local sizes = {
        [OptionSelectorGroupSize.XSmall] = tbl4,
        [OptionSelectorGroupSize.Small] = tbl3,
        [OptionSelectorGroupSize.Medium] = tbl2
    }

    local tbl6 = {
        label = { tag = "size-full-0 auto-y" },
        metadata = { tag = "size-full-0 auto-y" },
        description = { tag = "size-full-0 auto-y" }
    }
    return {
        common = common,
        sizes = sizes,
        layouts = {
            Inline = composeStyleVariant({
                container = { tag = "size-full-0 auto-y" },
                itemInner = { tag = "row align-y-center gap-small size-full-0 auto-y" },
                textContainer = { tag = "col fill gap-xsmall size-full-0 auto-y" }
            }, tbl6),
            StackedFill = composeStyleVariant({
                container = { tag = "fill auto-y" },
                itemInner = { tag = "col gap-small size-full-0 auto-y" },
                textContainer = { tag = "col gap-xsmall size-full-0 auto-y" }
            }, tbl6),
            StackedFit = composeStyleVariant(
                {
                    container = { tag = "auto-xy" },
                    itemInner = { tag = "col gap-small auto-xy" },
                    textContainer = { tag = "col gap-xsmall auto-xy" }
                },
                {
                    label = { tag = "auto-xy" },
                    metadata = { tag = "auto-xy" },
                    description = { tag = "auto-xy" }
                }
            )
        },
        selection = {
            [false] = {
                container = {
                    stroke = arg1.Color.Stroke.Emphasis
                }
            },
            [true] = {
                container = {
                    stroke = arg1.Color.System.Contrast
                }
            }
        }
    }
end

local function variantsFactory(arg1)
    return {
        groupSize = groupSizeVariantsFactory(arg1)
    }
end

return function(arg1, arg2, arg3, fit, bool1: boolean?)
    local groupSize = VariantsContext.useVariants("OptionSelectorGroupItem", variantsFactory, arg1).groupSize
    local bool2 = arg3 == Orientation.Vertical and fit == FillBehavior.Fit
    local var1 = if arg3 == Orientation.Horizontal then groupSize.layouts.Inline elseif bool2 then groupSize.layouts.StackedFit else groupSize.layouts.StackedFill
    return (composeStyleVariant(groupSize.common, groupSize.sizes[arg2], var1, groupSize.selection[bool1 == true]))
end
