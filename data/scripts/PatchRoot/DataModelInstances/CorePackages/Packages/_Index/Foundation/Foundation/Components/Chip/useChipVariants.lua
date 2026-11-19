-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T07:31:06Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")

local ChipSize = require(Foundation.Enums.ChipSize)

local ChipVariant = require(Foundation.Enums.ChipVariant)

local composeStyleVariant = require(Foundation.Utility.composeStyleVariant)

local _Tokens = require(Foundation.Providers.Style.Tokens)

local VariantsContext = require(Foundation.Providers.Style.VariantsContext)

local function variantsFactory(arg1)
    local textSpacing = {
        [ChipSize.Small] = UDim.new(0, arg1.Padding.Small),
        [ChipSize.Medium] = UDim.new(0, arg1.Padding.Medium),
        [ChipSize.Large] = UDim.new(0, arg1.Padding.Large)
    }

    return {
        common = {
            chip = { tag = "row align-x-center align-y-center auto-x radius-circle clip" },
            text = { tag = "shrink size-0-full auto-x text-truncate-end" }
        },
        sizes = {
            [ChipSize.Small] = {
                chip = { tag = "size-0-600" },
                text = { tag = "text-label-small" }
            },
            [ChipSize.Medium] = {
                chip = { tag = "size-0-800" },
                text = { tag = "text-label-medium" }
            },
            [ChipSize.Large] = {
                chip = { tag = "size-0-1000" },
                text = { tag = "text-label-medium" }
            }
        },
        types = {
            [ChipVariant.Utility] = {
                [true] = {
                    chip = {
                        backgroundStyle = arg1.Inverse.Surface.Surface_0
                    },
                    text = {
                        contentStyle = arg1.Inverse.Content.Emphasis
                    }
                },
                [false] = {
                    chip = {
                        backgroundStyle = arg1.Color.ActionUtility.Background
                    },
                    text = {
                        contentStyle = arg1.Color.ActionUtility.Foreground
                    }
                }
            },
            [ChipVariant.Standard] = {
                [true] = {
                    chip = {
                        backgroundStyle = arg1.Inverse.Surface.Surface_0
                    },
                    text = {
                        contentStyle = arg1.Inverse.Content.Emphasis
                    }
                },
                [false] = {
                    chip = {
                        backgroundStyle = arg1.Color.ActionStandard.Background
                    },
                    text = {
                        contentStyle = arg1.Color.ActionStandard.Foreground
                    }
                }
            }
        },
        textSpacing = textSpacing
    }
end

return function(arg1, arg2, arg3, bool1: boolean, bool2: boolean, bool3: boolean)
    local var1 = VariantsContext.useVariants("Chip", variantsFactory, arg1)
    return composeStyleVariant(var1.common, var1.sizes[arg2], var1.types[arg3][bool1], {
        text = {
            padding = {
                left = if bool2 then nil else var1.textSpacing[arg2],
                right = if bool3 then nil else var1.textSpacing[arg2]
            }
        }
    })
end
