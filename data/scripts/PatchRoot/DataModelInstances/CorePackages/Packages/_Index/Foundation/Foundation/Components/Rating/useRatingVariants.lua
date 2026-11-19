-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T08:41:07Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")

local IconSize = require(Foundation.Enums.IconSize)

local ChipSize = require(Foundation.Enums.ChipSize)

local _Types = require(Foundation.Components.Types)

local composeStyleVariant = require(Foundation.Utility.composeStyleVariant)

local _Tokens = require(Foundation.Providers.Style.Tokens)

local VariantsContext = require(Foundation.Providers.Style.VariantsContext)

local function variantsFactory(arg1)
    return {
        common = {
            container = {
                tag = "row align-y-center auto-xy radius-circle clip",
                backgroundStyle = arg1.Color.ActionStandard.Background
            },
            thumbUpSegment = {
                tag = "row align-x-center align-y-center shrink-1 auto-x radius-circle"
            },
            thumbDownSegment = { tag = "row align-x-center align-y-center auto-x radius-circle" },
            text = {
                contentStyle = arg1.Color.ActionStandard.Foreground
            }
        },
        sizes = {
            [ChipSize.Small] = {
                thumbSegment = { tag = "size-0-600" },
                dividerContainer = { tag = "align-y-center size-0-600 auto-x padding-y-xsmall" },
                thumbUpIcon = { tag = "auto-xy padding-left-small padding-right-xsmall" },
                thumbDownIcon = { tag = "auto-xy padding-left-small padding-right-medium" },
                text = {
                    tag = "shrink size-0-full auto-x text-label-small text-truncate-end padding-right-small"
                },
                iconSize = IconSize.XSmall
            },
            [ChipSize.Medium] = {
                thumbSegment = { tag = "size-0-800" },
                dividerContainer = { tag = "align-y-center size-0-800 auto-x padding-y-small" },
                thumbUpIcon = { tag = "auto-xy padding-left-medium padding-right-xsmall" },
                thumbDownIcon = { tag = "auto-xy padding-left-medium padding-right-medium" },
                text = {
                    tag = "shrink size-0-full auto-x text-label-medium text-truncate-end padding-right-medium"
                },
                iconSize = IconSize.Small
            },
            [ChipSize.Large] = {
                thumbSegment = { tag = "size-0-1000" },
                dividerContainer = { tag = "align-y-center size-0-1000 auto-x padding-y-small" },
                thumbUpIcon = { tag = "auto-xy padding-left-medium padding-right-small" },
                thumbDownIcon = { tag = "auto-xy padding-left-medium padding-right-medium" },
                text = {
                    tag = "shrink size-0-full auto-x text-label-medium text-truncate-end padding-right-large"
                },
                iconSize = IconSize.Medium
            }
        }
    }
end

return function(arg1, arg2)
    local var1 = VariantsContext.useVariants("Rating", variantsFactory, arg1)

    local var2 = var1.sizes[arg2]

    local var3 = composeStyleVariant(
        var1.common,
        {
            thumbUpSegment = var2.thumbSegment,
            thumbDownSegment = var2.thumbSegment,
            text = var2.text
        }
    )
    return {
        container = var3.container,
        thumbUpSegment = var3.thumbUpSegment,
        thumbDownSegment = var3.thumbDownSegment,
        dividerContainer = var2.dividerContainer,
        thumbUpIcon = var2.thumbUpIcon,
        thumbDownIcon = var2.thumbDownIcon,
        text = {
            tag = var3.text.tag,
            contentStyle = var3.text.contentStyle
        },
        iconSize = var2.iconSize
    }
end
