-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T05:01:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")

local InputSize = require(Foundation.Enums.InputSize)

local LinkVariant = require(Foundation.Enums.LinkVariant)

local TextOverflow = require(Foundation.Enums.TextOverflow)

local _Types = require(Foundation.Components.Types)

local composeStyleVariant = require(Foundation.Utility.composeStyleVariant)

local VariantsContext = require(Foundation.Providers.Style.VariantsContext)

local _Tokens = require(Foundation.Providers.Style.Tokens)

local function variantsFactory(arg1)
    return {
        common = {
            container = { tag = "row align-y-center" }
        },
        variants = {
            [LinkVariant.Standard] = {
                content = {
                    style = arg1.Color.Content.Emphasis
                }
            },
            [LinkVariant.Inverse] = {
                content = {
                    style = arg1.Inverse.Content.Default
                }
            }
        },
        sizes = {
            [InputSize.XSmall] = {
                text = { tag = "text-body-small" }
            },
            [InputSize.Small] = {
                text = { tag = "text-body-small" }
            },
            [InputSize.Medium] = {
                text = { tag = "text-body-medium" }
            },
            [InputSize.Large] = {
                text = { tag = "text-body-large" }
            }
        },
        textOverflows = {
            [TextOverflow.None] = {
                container = { tag = "auto-xy" },
                text = { tag = "auto-xy" }
            },
            [TextOverflow.Wrap] = {
                container = { tag = "size-full-0 auto-y" },
                text = { tag = "size-full-0 auto-y text-wrap text-align-x-left" }
            },
            [TextOverflow.Truncate] = {
                container = { tag = "size-full-0 auto-y" },
                text = { tag = "size-full-0 auto-y text-align-x-left text-truncate-end" }
            },
            [TextOverflow.TruncateSplit] = {
                container = { tag = "size-full-0 auto-y" },
                text = { tag = "size-full-0 auto-y text-align-x-left text-truncate-split" }
            }
        }
    }
end

return function(arg1, arg2, arg3, arg4)
    local var1 = VariantsContext.useVariants("Link", variantsFactory, arg1)
    return composeStyleVariant(var1.common, var1.variants[arg3], var1.sizes[arg2], var1.textOverflows[arg4])
end
