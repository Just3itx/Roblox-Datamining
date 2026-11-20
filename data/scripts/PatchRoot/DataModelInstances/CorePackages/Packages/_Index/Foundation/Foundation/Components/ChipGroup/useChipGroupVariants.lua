-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T04:10:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")

local ChipSize = require(Foundation.Enums.ChipSize)

local ChipGroupVariant = require(Foundation.Enums.ChipGroupVariant)

local _Tokens = require(Foundation.Providers.Style.Tokens)

local VariantsContext = require(Foundation.Providers.Style.VariantsContext)

local function variantsFactory(arg1)
    return {
        scrimWidth = {
            [ChipSize.Small] = arg1.Size.Size_600,
            [ChipSize.Medium] = arg1.Size.Size_800
        },
        gap = {
            [ChipSize.Small] = arg1.Padding.XSmall,
            [ChipSize.Medium] = arg1.Padding.Small
        },
        variants = {
            [ChipGroupVariant.Row] = { isWrapped = false, hasScrim = true },
            [ChipGroupVariant.Wrap] = { isWrapped = true, hasScrim = false }
        }
    }
end
return function(arg1, arg2, arg3)
    local var1 = VariantsContext.useVariants("ChipGroup", variantsFactory, arg1)
    local variant = var1.variants[arg2]
    return {
        isWrapped = variant.isWrapped,
        hasScrim = variant.hasScrim,
        scrimWidth = var1.scrimWidth[arg3],
        gap = var1.gap[arg3]
    }
end
