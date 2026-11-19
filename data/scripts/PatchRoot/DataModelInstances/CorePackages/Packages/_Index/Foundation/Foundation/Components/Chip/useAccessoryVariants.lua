-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T07:31:05Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")

local ChipSize = require(Foundation.Enums.ChipSize)

local composeStyleVariant = require(Foundation.Utility.composeStyleVariant)

local _Tokens = require(Foundation.Providers.Style.Tokens)

local VariantsContext = require(Foundation.Providers.Style.VariantsContext)

local function variantsFactory(arg1)
    local accessorySize = {
        Default = {
            [ChipSize.Small] = UDim2.fromOffset(arg1.Size.Size_300, arg1.Size.Size_300),
            [ChipSize.Medium] = UDim2.fromOffset(arg1.Size.Size_400, arg1.Size.Size_400),
            [ChipSize.Large] = UDim2.fromOffset(arg1.Size.Size_500, arg1.Size.Size_500)
        },
        Circular = {
            [ChipSize.Small] = UDim2.fromOffset(arg1.Size.Size_400, arg1.Size.Size_400),
            [ChipSize.Medium] = UDim2.fromOffset(arg1.Size.Size_500, arg1.Size.Size_500),
            [ChipSize.Large] = UDim2.fromOffset(arg1.Size.Size_600, arg1.Size.Size_600)
        }
    }

    local accessorySpacing = {
        Circular = {
            [ChipSize.Small] = UDim.new(0, arg1.Size.Size_150),
            [ChipSize.Medium] = UDim.new(0, arg1.Size.Size_200),
            [ChipSize.Large] = UDim.new(0, arg1.Size.Size_250)
        },
        Default = {
            [ChipSize.Small] = UDim.new(0, arg1.Padding.Small),
            [ChipSize.Medium] = UDim.new(0, arg1.Padding.Medium),
            [ChipSize.Large] = UDim.new(0, arg1.Padding.Medium)
        }
    }

    local iconOnlySpacing = {
        Default = {
            [ChipSize.Small] = UDim.new(0, arg1.Size.Size_150),
            [ChipSize.Medium] = UDim.new(0, arg1.Size.Size_200),
            [ChipSize.Large] = UDim.new(0, arg1.Size.Size_250)
        },
        Circular = {
            [ChipSize.Small] = UDim.new(0, arg1.Padding.XSmall),
            [ChipSize.Medium] = UDim.new(0, arg1.Size.Size_150),
            [ChipSize.Large] = UDim.new(0, arg1.Padding.Small)
        }
    }

    return {
        textSpacing = {
            Leading = {
                [ChipSize.Small] = UDim.new(0, arg1.Padding.XSmall),
                [ChipSize.Medium] = UDim.new(0, arg1.Size.Size_150),
                [ChipSize.Large] = UDim.new(0, arg1.Padding.Small)
            },
            Trailing = {
                [ChipSize.Small] = UDim.new(0, arg1.Size.Size_150),
                [ChipSize.Medium] = UDim.new(0, arg1.Padding.Small),
                [ChipSize.Large] = UDim.new(0, arg1.Size.Size_250)
            }
        },
        accessorySpacing = accessorySpacing,
        accessorySize = accessorySize,
        iconOnlySpacing = iconOnlySpacing
    }
end

return function(arg1, arg2, bool1: boolean, bool2: boolean, bool3: boolean?)
    local var1 = VariantsContext.useVariants("ChipAccessory", variantsFactory, arg1)

    local str1 = if bool2 then "Circular" else "Default"
    local str2 = if bool1 then "Leading" else "Trailing"

    return composeStyleVariant({
        accessory = {
            Size = var1.accessorySize[str1][arg2],
            padding = bool3 and {
                left = var1.iconOnlySpacing[str1][arg2],
                right = var1.iconOnlySpacing[str1][arg2]
            }
                or bool1 and {
                    left = var1.accessorySpacing[str1][arg2],
                    right = var1.textSpacing[str2][arg2]
                }
                or {
                    left = var1.textSpacing[str2][arg2],
                    right = var1.accessorySpacing[str1][arg2]
                }
        }
    })
end
