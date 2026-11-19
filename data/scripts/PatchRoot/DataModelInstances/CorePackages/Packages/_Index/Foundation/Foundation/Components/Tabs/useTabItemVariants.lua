-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T09:01:24Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")

local composeStyleVariant = require(Foundation.Utility.composeStyleVariant)

local _Tokens = require(Foundation.Providers.Style.Tokens)

local VariantsContext = require(Foundation.Providers.Style.VariantsContext)

local InputSize = require(Foundation.Enums.InputSize)

local IconSize = require(Foundation.Enums.IconSize)

local function variantsFactory(_)
    local sizes = {
        [InputSize.XSmall] = {
            text = { tag = "size-0-400 text-label-small" },
            content = { tag = "padding-y-small" },
            icon = {
                size = IconSize.XSmall
            }
        },
        [InputSize.Small] = {
            text = { tag = "size-0-600 text-label-medium" },
            content = { tag = "padding-y-small" },
            icon = {
                size = IconSize.Medium
            }
        },
        [InputSize.Medium] = {
            text = { tag = "size-0-600 text-label-medium" },
            content = { tag = "padding-y-medium" },
            icon = {
                size = IconSize.Medium
            }
        },
        [InputSize.Large] = {
            text = { tag = "size-0-600 text-label-medium" },
            content = { tag = "padding-y-xlarge" },
            icon = {
                size = IconSize.Medium
            }
        }
    }
    local paddings = {
        [InputSize.XSmall] = {
            content = { tag = "padding-x-xsmall" }
        },
        [InputSize.Small] = {
            content = { tag = "padding-x-small" }
        },
        [InputSize.Medium] = {
            content = { tag = "padding-x-medium" }
        },
        [InputSize.Large] = {
            content = { tag = "padding-x-large" }
        }
    }
    return {
        common = {
            text = { tag = "auto-x" },
            content = { tag = "row align-x-center align-y-center gap-small" }
        },
        sizes = sizes,
        isFill = {
            [false] = {
                container = { tag = "auto-xy" },
                content = { tag = "size-0-0 auto-xy" }
            },
            [true] = {
                container = { tag = "grow auto-xy" },
                content = {
                    tag = "auto-y",
                    Size = UDim2.fromScale(1, 0)
                }
            }
        },
        paddings = paddings
    }
end
return function(arg1, arg2, bool1: boolean)
    local var1 = VariantsContext.useVariants("Tab", variantsFactory, arg1)

    return composeStyleVariant(var1.common, var1.sizes[arg2], var1.isFill[bool1], var1.paddings[arg2])
end
