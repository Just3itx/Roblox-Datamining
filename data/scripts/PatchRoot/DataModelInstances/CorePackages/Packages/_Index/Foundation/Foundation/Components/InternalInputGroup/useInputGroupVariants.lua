-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T04:51:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")

local InputSize = require(Foundation.Enums.InputSize)

local composeStyleVariant = require(Foundation.Utility.composeStyleVariant)

local _Tokens = require(Foundation.Providers.Style.Tokens)

local VariantsContext = require(Foundation.Providers.Style.VariantsContext)

local _Types = require(Foundation.Components.Types)

local function variantsFactory(_)
    return {
        common = {
            container = { tag = "col auto-xy" },
            children = { tag = "col auto-xy" },
            legend = { tag = "auto-xy text-wrap text-align-x-left content-emphasis" }
        },
        sizes = {
            [InputSize.XSmall] = {
                container = { tag = "gap-medium" },
                children = { tag = "gap-small" },
                legend = { tag = "text-title-small" }
            },
            [InputSize.Small] = {
                container = { tag = "gap-large" },
                children = { tag = "gap-medium" },
                legend = { tag = "text-title-small" }
            },
            [InputSize.Medium] = {
                container = { tag = "gap-large" },
                children = { tag = "gap-medium" },
                legend = { tag = "text-title-medium" }
            }
        }
    }
end

local function useInputGroupVariants(arg1, arg2)
    local var1 = VariantsContext.useVariants("InputGroup", variantsFactory, arg1)
    return composeStyleVariant(var1.common, var1.sizes[arg2])
end

return useInputGroupVariants
