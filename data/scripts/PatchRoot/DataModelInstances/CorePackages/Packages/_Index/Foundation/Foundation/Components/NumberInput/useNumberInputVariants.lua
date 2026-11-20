-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T05:11:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")

local _NumberInputControlsVariant = require(Foundation.Enums.NumberInputControlsVariant)

local InputSize = require(Foundation.Enums.InputSize)

local IconSize = require(Foundation.Enums.IconSize)

local composeStyleVariant = require(Foundation.Utility.composeStyleVariant)

local _Tokens = require(Foundation.Providers.Style.Tokens)

local VariantsContext = require(Foundation.Providers.Style.VariantsContext)

local function variantsFactory(arg1)
    return {
        common = {
            controls = { tag = "row align-y-center bg-action-standard" }
        },
        sizes = {
            [InputSize.XSmall] = {
                controls = {
                    width = arg1.Size.Size_1200,
                    buttonSize = arg1.Size.Size_600,
                    iconSize = IconSize.XSmall,
                    tag = "radius-small",
                    radius = arg1.Radius.Small
                }
            },
            [InputSize.Small] = {
                controls = {
                    width = arg1.Size.Size_1600,
                    buttonSize = arg1.Size.Size_800,
                    iconSize = IconSize.Small,
                    tag = "radius-medium",
                    radius = arg1.Radius.Medium
                }
            },
            [InputSize.Medium] = {
                controls = {
                    width = arg1.Size.Size_2000,
                    buttonSize = arg1.Size.Size_1000,
                    iconSize = IconSize.Medium,
                    tag = "radius-medium",
                    radius = arg1.Radius.Medium
                }
            },
            [InputSize.Large] = {
                controls = {
                    width = arg1.Size.Size_2400,
                    buttonSize = arg1.Size.Size_1200,
                    iconSize = IconSize.Large,
                    tag = "radius-medium",
                    radius = arg1.Radius.Medium
                }
            }
        }
    }
end

return function(arg1, arg2)
    local var1 = VariantsContext.useVariants("NumberInput", variantsFactory, arg1)
    return composeStyleVariant(var1.common, var1.sizes[arg2])
end
