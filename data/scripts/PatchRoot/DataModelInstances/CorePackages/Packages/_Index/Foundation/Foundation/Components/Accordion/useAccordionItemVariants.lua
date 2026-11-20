-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T03:50:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")

local InputSize = require(Foundation.Enums.InputSize)

local VariantsContext = require(Foundation.Providers.Style.VariantsContext)
local composeStyleVariant = require(Foundation.Utility.composeStyleVariant)

local _Tokens = require(Foundation.Providers.Style.Tokens)
local _Types = require(Foundation.Components.Types)

local StateLayerAffordance = require(Foundation.Enums.StateLayerAffordance)

local IconSize = require(Foundation.Enums.IconSize)

local function func1(arg1)
    return {
        common = {
            container = {
                tag = "col flex-y-between align-x-center size-full-0 auto-y",
                stateLayer = {
                    affordance = StateLayerAffordance.None
                }
            },
            header = { tag = "row flex-x-between align-y-center" },
            content = { tag = "size-full-0 auto-y padding-top-xsmall" },
            icon = {
                style = arg1.Color.Content.Emphasis
            },
            text = { tag = "auto-y text-align-x-left text-truncate-end content-emphasis" },
            textContainer = { tag = "col grow auto-y" },
            description = { tag = "size-full-0 auto-y text-align-x-left text-truncate-end" }
        },
        sizes = {
            [InputSize.XSmall] = {
                container = { tag = "radius-small" },
                header = { tag = "gap-small size-full-600" },
                content = { tag = "padding-bottom-small" },
                icon = {
                    size = IconSize.XSmall
                },
                text = { tag = "text-title-small" },
                description = { tag = "text-body-small" }
            },
            [InputSize.Small] = {
                container = { tag = "radius-medium" },
                header = { tag = "gap-small size-full-800" },
                content = { tag = "padding-bottom-large" },
                icon = {
                    size = IconSize.Small
                },
                text = { tag = "text-title-small" },
                description = { tag = "text-body-small" }
            },
            [InputSize.Medium] = {
                container = { tag = "radius-medium" },
                header = { tag = "gap-small size-full-1000" },
                content = { tag = "padding-bottom-xlarge" },
                icon = {
                    size = IconSize.Medium
                },
                text = { tag = "text-title-medium" },
                description = { tag = "text-body-medium" }
            },
            [InputSize.Large] = {
                container = { tag = "radius-medium" },
                header = { tag = "gap-small size-full-1200" },
                content = { tag = "padding-bottom-xlarge" },
                icon = {
                    size = IconSize.Large
                },
                text = { tag = "text-title-large" },
                description = { tag = "text-body-medium" }
            }
        },
        isContained = {
            [true] = {
                header = { tag = "padding-x-medium" },
                content = { tag = "padding-x-medium" }
            }
        }
    }
end

return function(arg1, arg2, bool1: boolean)
    local var1 = VariantsContext.useVariants("AccordionItem", func1, arg1)
    return composeStyleVariant(var1.common, var1.sizes[arg2], var1.isContained[bool1])
end
