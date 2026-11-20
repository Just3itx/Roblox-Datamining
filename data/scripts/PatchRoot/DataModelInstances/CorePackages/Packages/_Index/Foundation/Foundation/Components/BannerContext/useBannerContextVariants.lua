-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T04:00:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")

local BannerContextPresentation = require(Foundation.Enums.BannerContextPresentation)
local BannerContextVariant = require(Foundation.Enums.BannerContextVariant)
local IconSize = require(Foundation.Enums.IconSize)
local InputSize = require(Foundation.Enums.InputSize)
local _InternalNotice = require(Foundation.Components.InternalNotice)
local _Types = require(Foundation.Components.Types)

local composeStyleVariant = require(Foundation.Utility.composeStyleVariant)

local _Tokens = require(Foundation.Providers.Style.Tokens)
local VariantsContext = require(Foundation.Providers.Style.VariantsContext)

local function firstLineTextPadding(arg1, fontSize: number) -- Luacid: Inlined by compiler; 2 call sites recovered
    return {
        top = UDim.new(0, math.round((arg1.Size.Size_600 - fontSize) / 2))
    }
end

local function affixedContentPadding(arg1, offset: number)
    return {
        top = UDim.new(0, offset),
        right = UDim.new(0, arg1.Margin.Medium),
        bottom = UDim.new(0, offset),
        left = UDim.new(0, arg1.Margin.Medium)
    }
end

local function variantsFactory(arg1)
    local padding = firstLineTextPadding(arg1, arg1.Typography.BodySmall.FontSize)
    local tbl1 = firstLineTextPadding(arg1, arg1.Typography.BodyMedium.FontSize)

    return {
        common = {
            content = { gap = "gap-large" },
            stack = { gap = "gap-xxsmall" },
            icon = {
                style = arg1.Color.Content.Emphasis
            },
            message = { tag = "content-emphasis" },
            link = { tag = "content-emphasis" }
        },
        presentations = {
            [BannerContextPresentation.Inline] = {
                container = { tag = "radius-medium" },
                content = { tag = "padding-medium" },
                leading = { gap = "gap-small" },
                icon = {
                    size = IconSize.Small
                },
                message = { tag = "text-body-small", padding = padding },
                link = {
                    tag = "text-body-small",
                    padding = padding,
                    size = InputSize.Small
                }
            },
            [BannerContextPresentation.Affixed] = {
                leading = { gap = "gap-medium" },
                icon = {
                    size = IconSize.Medium
                },
                message = { tag = "text-body-medium", padding = tbl1 },
                link = {
                    tag = "text-body-medium",
                    padding = tbl1,
                    size = InputSize.Medium
                }
            }
        },
        variants = {
            [BannerContextVariant.Standard] = {},
            [BannerContextVariant.Emphasis] = {
                container = { tag = "bg-shift-200" }
            }
        },
        presentationVariants = {
            [BannerContextPresentation.Inline] = {
                [BannerContextVariant.Standard] = {
                    container = { tag = "stroke-standard stroke-default" }
                },
                [BannerContextVariant.Emphasis] = {}
            },
            [BannerContextPresentation.Affixed] = {
                [BannerContextVariant.Standard] = {
                    content = {
                        padding = affixedContentPadding(arg1, arg1.Padding.Large - arg1.Stroke.Standard)
                    },
                    border = {
                        Size = UDim2.new(1, 0, 0, arg1.Stroke.Standard),
                        backgroundStyle = arg1.Color.Stroke.Default
                    }
                },
                [BannerContextVariant.Emphasis] = {
                    content = {
                        padding = affixedContentPadding(arg1, arg1.Padding.Large)
                    }
                }
            }
        }
    }
end

local function useBannerContextVariants(arg1, arg2, arg3)
    local var1 = VariantsContext.useVariants("BannerContext", variantsFactory, arg1)
    return composeStyleVariant(var1.common, var1.presentations[arg2], var1.variants[arg3], var1.presentationVariants[arg2][arg3])
end

return useBannerContextVariants
