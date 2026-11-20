-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T04:01:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")

local InputSize = require(Foundation.Enums.InputSize)

local VariantsContext = require(Foundation.Providers.Style.VariantsContext)
local composeStyleVariant = require(Foundation.Utility.composeStyleVariant)

local _Tokens = require(Foundation.Providers.Style.Tokens)
local _Types = require(Foundation.Components.Types)

local IconSize = require(Foundation.Enums.IconSize)

local function variantsMap(arg1)
    return {
        common = {
            container = { tag = "" },
            icon = {
                tag = "radius-small content-emphasis",
                style = arg1.Color.Content.Emphasis
            },
            text = { tag = "fill auto-xy text-align-x-left text-truncate-end content-emphasis" },
            title = { tag = "fill auto-xy text-align-x-left text-truncate-end content-default" },
            check = {
                tag = "content-emphasis",
                style = arg1.Color.Content.Emphasis
            },
            slotAlign = { tag = "align-x-center align-y-center" },
            submenuContent = { tag = "stroke-standard stroke-default radius-medium" }
        },
        sizes = {
            [InputSize.XSmall] = {
                container = {
                    tag = "size-full-600 radius-small",
                    paddingLeftWithCheck = 0,
                    paddingLeftWithoutCheck = arg1.Padding.Small,
                    paddingRight = arg1.Padding.Small
                },
                wrapper = {
                    gap = arg1.Size.Size_150
                },
                icon = {
                    tag = "size-400",
                    size = IconSize.XSmall
                },
                text = { tag = "text-body-small" },
                title = {
                    tag = "text-caption-small",
                    checkColumnWidth = arg1.Size.Size_500
                },
                check = {
                    tag = "size-500-400",
                    size = arg1.Size.Size_400
                },
                chevron = {
                    size = IconSize.Small
                },
                groupPadding = {
                    size = arg1.Padding.XSmall
                }
            },
            [InputSize.Small] = {
                container = {
                    tag = "size-full-800 radius-small",
                    paddingLeftWithCheck = 0,
                    paddingLeftWithoutCheck = arg1.Padding.Small,
                    paddingRight = arg1.Padding.Small
                },
                wrapper = {
                    gap = arg1.Size.Size_150
                },
                icon = {
                    tag = "size-500",
                    size = IconSize.Small
                },
                text = { tag = "text-body-small" },
                title = {
                    tag = "text-caption-small",
                    checkColumnWidth = arg1.Size.Size_600
                },
                check = {
                    tag = "size-600-400",
                    size = arg1.Size.Size_400
                },
                chevron = {
                    size = IconSize.Small
                },
                groupPadding = {
                    size = arg1.Padding.Small
                }
            },
            [InputSize.Medium] = {
                container = {
                    tag = "size-full-1000 radius-medium",
                    paddingLeftWithCheck = 0,
                    paddingLeftWithoutCheck = arg1.Size.Size_250,
                    paddingRight = arg1.Size.Size_250
                },
                wrapper = {
                    gap = arg1.Size.Size_150
                },
                icon = {
                    tag = "size-500",
                    size = IconSize.Medium
                },
                text = { tag = "text-body-medium" },
                title = {
                    tag = "text-caption-medium",
                    checkColumnWidth = arg1.Size.Size_700
                },
                check = {
                    tag = "size-700-500",
                    size = arg1.Size.Size_500
                },
                chevron = {
                    size = IconSize.Medium
                },
                groupPadding = {
                    size = arg1.Padding.Small
                }
            },
            [InputSize.Large] = {
                container = {
                    tag = "size-full-1200 radius-medium",
                    paddingLeftWithCheck = 0,
                    paddingLeftWithoutCheck = arg1.Size.Size_350,
                    paddingRight = arg1.Size.Size_350
                },
                wrapper = {
                    gap = arg1.Padding.Small
                },
                icon = {
                    tag = "size-600",
                    size = IconSize.Large
                },
                text = { tag = "text-body-large" },
                title = {
                    tag = "text-caption-large",
                    checkColumnWidth = arg1.Size.Size_800
                },
                check = {
                    tag = "size-800-600",
                    size = arg1.Size.Size_600
                },
                chevron = {
                    size = IconSize.Large
                },
                groupPadding = {
                    size = arg1.Padding.Small
                }
            }
        },
        isScrollable = {
            [false] = {
                submenuContent = { tag = "col auto-xy" }
            },
            [true] = {
                submenuContent = { tag = "" }
            }
        },
        defaultSize = {
            container = { tag = "auto-x" }
        }
    }
end
return function(arg1, arg2, bool1: boolean)
    local var1 = VariantsContext.useVariants("BaseMenuItem", variantsMap, arg1)

    return composeStyleVariant(var1.common, var1.sizes[arg2], var1.defaultSize, var1.isScrollable[bool1])
end
