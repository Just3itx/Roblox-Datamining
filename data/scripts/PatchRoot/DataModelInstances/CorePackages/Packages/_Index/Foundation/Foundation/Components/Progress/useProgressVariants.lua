-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T08:40:54Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")

local ProgressSize = require(Foundation.Enums.ProgressSize)

local composeStyleVariant = require(Foundation.Utility.composeStyleVariant)

local _Tokens = require(Foundation.Providers.Style.Tokens)

local VariantsContext = require(Foundation.Providers.Style.VariantsContext)

local function variantsFactory(arg1)
    return {
        sizes = {
            [ProgressSize.Small] = {
                bar = {
                    height = arg1.Size.Size_50
                },
                circle = {
                    size = arg1.Size.Size_400
                }
            },
            [ProgressSize.Medium] = {
                bar = {
                    height = arg1.Size.Size_100
                },
                circle = {
                    size = arg1.Size.Size_800
                }
            },
            [ProgressSize.Large] = {
                bar = {
                    height = arg1.Size.Size_150
                },
                circle = {
                    size = arg1.Size.Size_1300,
                    labelFont = arg1.Typography.LabelMedium
                }
            }
        }
    }
end

return function(arg1, arg2)
    local var1 = VariantsContext.useVariants("Progress", variantsFactory, arg1)
    return composeStyleVariant(var1.sizes[arg2])
end
