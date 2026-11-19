-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T09:01:03Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")

local StatusBadgeShape = require(Foundation.Enums.StatusBadgeShape)

local StatusBadgeSize = require(Foundation.Enums.StatusBadgeSize)

local StatusBadgeVariant = require(Foundation.Enums.StatusBadgeVariant)

local _Types = require(Foundation.Components.Types)

local composeStyleVariant = require(Foundation.Utility.composeStyleVariant)

local _Tokens = require(Foundation.Providers.Style.Tokens)

local VariantsContext = require(Foundation.Providers.Style.VariantsContext)

function variantsFactory(arg1)
    return {
        common = {
            container = { tag = "row align-x-center align-y-center auto-xy" },
            statusLight = {
                tag = "row align-x-center align-y-center auto-x size-0-300 padding-x-xxsmall"
            },
            content = { tag = "row align-y-center auto-x size-0-full" },
            dot = { tag = "radius-circle" },
            text = {
                style = arg1.Color.Content.Emphasis,
                tag = "auto-xy text-align-x-left text-truncate-split padding-right-xxsmall"
            }
        },
        variants = {
            [StatusBadgeVariant.Standard] = {
                dot = { tag = "bg-system-neutral" }
            },
            [StatusBadgeVariant.Emphasis] = {
                dot = { tag = "bg-system-emphasis" }
            },
            [StatusBadgeVariant.Success] = {
                dot = { tag = "bg-system-success" }
            },
            [StatusBadgeVariant.Warning] = {
                dot = { tag = "bg-system-warning" }
            },
            [StatusBadgeVariant.Alert] = {
                dot = { tag = "bg-system-alert" }
            }
        },
        shapes = {
            [StatusBadgeShape.Utility] = {},
            [StatusBadgeShape.Box] = {
                container = { tag = "radius-small bg-shift-200" }
            }
        },
        sizes = {
            [StatusBadgeSize.XSmall] = {
                container = { tag = "size-0-400" },
                content = { tag = "gap-xxsmall" },
                dot = { tag = "size-150" },
                text = { tag = "text-caption-small" }
            },
            [StatusBadgeSize.Small] = {
                container = { tag = "size-0-600" },
                content = {
                    gap = arg1.Size.Size_150
                },
                dot = { tag = "size-200" },
                text = { tag = "text-caption-medium" }
            }
        },
        boxSizes = {
            [StatusBadgeSize.XSmall] = {
                container = { tag = "padding-x-xsmall" }
            },
            [StatusBadgeSize.Small] = {
                container = { tag = "padding-x-small" }
            }
        }
    }
end

return function(arg1, arg2, box, arg3)
    local var1 = VariantsContext.useVariants("StatusBadge", variantsFactory, arg1)

    return composeStyleVariant(
        var1.common,
        var1.variants[arg2],
        var1.shapes[box],
        var1.sizes[arg3],
        if box == StatusBadgeShape.Box then var1.boxSizes[arg3] else nil
    )
end
