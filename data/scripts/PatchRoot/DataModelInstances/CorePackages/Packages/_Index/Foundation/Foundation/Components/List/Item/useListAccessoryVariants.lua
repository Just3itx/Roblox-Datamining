-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T05:01:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")

local AccessoryType = require(Foundation.Enums.AccessoryType)

local InputSize = require(Foundation.Enums.InputSize)

local composeStyleVariant = require(Foundation.Utility.composeStyleVariant)

local _Tokens = require(Foundation.Providers.Style.Tokens)

local VariantsContext = require(Foundation.Providers.Style.VariantsContext)

local function variantsFactory(arg1)
    return {
        accessorySize = {
            [AccessoryType.Icon] = {
                [InputSize.XSmall] = arg1.Size.Size_400,
                [InputSize.Small] = arg1.Size.Size_500,
                [InputSize.Medium] = arg1.Size.Size_600,
                [InputSize.Large] = arg1.Size.Size_600
            },
            [AccessoryType.Media] = {
                [InputSize.XSmall] = arg1.Size.Size_600,
                [InputSize.Small] = arg1.Size.Size_800,
                [InputSize.Medium] = arg1.Size.Size_1000,
                [InputSize.Large] = arg1.Size.Size_1400
            },
            [AccessoryType.Avatar] = {
                [InputSize.XSmall] = arg1.Size.Size_600,
                [InputSize.Small] = arg1.Size.Size_800,
                [InputSize.Medium] = arg1.Size.Size_1000,
                [InputSize.Large] = arg1.Size.Size_1400
            }
        },
        containerSize = {
            [InputSize.XSmall] = arg1.Size.Size_600,
            [InputSize.Small] = arg1.Size.Size_800,
            [InputSize.Medium] = arg1.Size.Size_1000,
            [InputSize.Large] = arg1.Size.Size_1400
        },
        cornerRadius = {
            [InputSize.XSmall] = arg1.Radius.Small,
            [InputSize.Small] = arg1.Radius.Medium,
            [InputSize.Medium] = arg1.Radius.Medium,
            [InputSize.Large] = arg1.Radius.Medium
        }
    }
end
return function(arg1, arg2, arg3)
    local var1 = VariantsContext.useVariants("ListAccessory", variantsFactory, arg1)

    return composeStyleVariant({
        accessory = {
            Size = UDim2.fromOffset(var1.accessorySize[arg3][arg2], var1.accessorySize[arg3][arg2]),
            cornerRadius = UDim.new(0, var1.cornerRadius[arg2])
        },
        container = {
            Size = UDim2.fromOffset(var1.containerSize[arg2], var1.containerSize[arg2])
        }
    })
end
