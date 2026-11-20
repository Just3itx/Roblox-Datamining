-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T05:01:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")

local IconSize = require(Foundation.Enums.IconSize)

local InputSize = require(Foundation.Enums.InputSize)

local composeStyleVariant = require(Foundation.Utility.composeStyleVariant)

local _Tokens = require(Foundation.Providers.Style.Tokens)

local VariantsContext = require(Foundation.Providers.Style.VariantsContext)

local function variantsFactory(_)
    return {
        common = {
            title = { tag = "auto-xy text-wrap text-align-x-left content-emphasis" },
            metadata = { tag = "auto-xy text-align-x-left text-truncate-split" },
            description = { tag = "auto-xy text-wrap text-align-x-left" }
        },
        sizes = {
            [InputSize.XSmall] = {
                title = { tag = "text-title-small" },
                metadata = { tag = "text-body-small" },
                description = { tag = "text-body-small" },
                icon = {
                    size = IconSize.XSmall
                }
            },
            [InputSize.Small] = {
                title = { tag = "text-title-medium" },
                metadata = { tag = "text-body-small" },
                description = { tag = "text-body-small" },
                icon = {
                    size = IconSize.Small
                }
            },
            [InputSize.Medium] = {
                title = { tag = "text-title-medium" },
                metadata = { tag = "text-body-medium" },
                description = { tag = "text-body-medium" },
                icon = {
                    size = IconSize.Medium
                }
            },
            [InputSize.Large] = {
                title = { tag = "text-title-large" },
                metadata = { tag = "text-body-medium" },
                description = { tag = "text-body-medium" },
                icon = {
                    size = IconSize.Large
                }
            }
        }
    }
end

return function(arg1, arg2)
    local var1 = VariantsContext.useVariants("ListItem", variantsFactory, arg1)

    return composeStyleVariant(var1.common, var1.sizes[arg2])
end
