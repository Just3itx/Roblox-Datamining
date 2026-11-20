-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T04:40:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")

local InputSize = require(Foundation.Enums.InputSize)

local _ButtonVariant = require(Foundation.Enums.ButtonVariant)

local ColorNamespace = require(Foundation.Enums.ColorNamespace)

local _Types = require(Foundation.Components.Types)

local VariantsContext = require(Foundation.Providers.Style.VariantsContext)
local composeStyleVariant = require(Foundation.Utility.composeStyleVariant)

local _Tokens = require(Foundation.Providers.Style.Tokens)

local getSharedVariants = require(Foundation.Components.Button.getSharedVariants)

local function func1(arg1)
    local sharedVariants = getSharedVariants(arg1)
    return {
        common = {},
        sizes = {
            [InputSize.XSmall] = {
                container = {
                    radius = sharedVariants.sizes[InputSize.XSmall].container.radius,
                    size = UDim2.fromOffset(
                        sharedVariants.sizes[InputSize.XSmall].container.height,
                        sharedVariants.sizes[InputSize.XSmall].container.height
                    ),
                    padding = UDim.new(0, arg1.Size.Size_150)
                }
            },
            [InputSize.Small] = {
                container = {
                    radius = sharedVariants.sizes[InputSize.Small].container.radius,
                    size = UDim2.fromOffset(
                        sharedVariants.sizes[InputSize.Small].container.height,
                        sharedVariants.sizes[InputSize.Small].container.height
                    ),
                    padding = UDim.new(0, arg1.Size.Size_200)
                }
            },
            [InputSize.Medium] = {
                container = {
                    radius = sharedVariants.sizes[InputSize.Medium].container.radius,
                    size = UDim2.fromOffset(
                        sharedVariants.sizes[InputSize.Medium].container.height,
                        sharedVariants.sizes[InputSize.Medium].container.height
                    ),
                    padding = UDim.new(0, arg1.Size.Size_250)
                }
            },
            [InputSize.Large] = {
                container = {
                    radius = sharedVariants.sizes[InputSize.Large].container.radius,
                    size = UDim2.fromOffset(
                        sharedVariants.sizes[InputSize.Large].container.height,
                        sharedVariants.sizes[InputSize.Large].container.height
                    ),
                    padding = UDim.new(0, arg1.Size.Size_300)
                }
            }
        },
        types = sharedVariants.types
    }
end
return function(arg1, arg2, arg3, arg4)
    local var1 = VariantsContext.useVariants("IconButton", func1, arg1)
    return composeStyleVariant(var1.common, var1.sizes[arg2], var1.types[arg3][arg4 or ColorNamespace.Color])
end
