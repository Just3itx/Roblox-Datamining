-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T04:01:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")

local InputSize = require(Foundation.Enums.InputSize)

local _ButtonVariant = require(Foundation.Enums.ButtonVariant)

local ColorNamespace = require(Foundation.Enums.ColorNamespace)

local _Types = require(Foundation.Components.Types)

local VariantsContext = require(Foundation.Providers.Style.VariantsContext)
local composeStyleVariant = require(Foundation.Utility.composeStyleVariant)

local getSharedVariants = require(script.Parent.getSharedVariants)

local _Tokens = require(Foundation.Providers.Style.Tokens)

local function func1(arg1)
    local sharedVariants = getSharedVariants(arg1)

    return {
        common = {
            container = { tag = "row align-x-center align-y-center clip" },
            text = { tag = "shrink size-0-full auto-x text-truncate-end" }
        },
        sizes = {
            [InputSize.XSmall] = {
                container = {
                    tag = "gap-xsmall padding-small",
                    radius = sharedVariants.sizes[InputSize.XSmall].container.radius,
                    height = sharedVariants.sizes[InputSize.XSmall].container.height
                },
                icon = {
                    size = UDim2.fromOffset(arg1.Size.Size_300, arg1.Size.Size_300)
                },
                text = { tag = "text-label-small" }
            },
            [InputSize.Small] = {
                container = {
                    tag = "gap-xsmall padding-small",
                    radius = sharedVariants.sizes[InputSize.Small].container.radius,
                    height = sharedVariants.sizes[InputSize.Small].container.height
                },
                icon = {
                    size = UDim2.fromOffset(arg1.Size.Size_400, arg1.Size.Size_400)
                },
                text = { tag = "text-label-small" }
            },
            [InputSize.Medium] = {
                container = {
                    tag = "gap-small padding-medium",
                    radius = sharedVariants.sizes[InputSize.Medium].container.radius,
                    height = sharedVariants.sizes[InputSize.Medium].container.height
                },
                icon = {
                    size = UDim2.fromOffset(arg1.Size.Size_500, arg1.Size.Size_500)
                },
                text = { tag = "text-label-medium" }
            },
            [InputSize.Large] = {
                container = {
                    tag = "gap-small padding-medium",
                    radius = sharedVariants.sizes[InputSize.Large].container.radius,
                    height = sharedVariants.sizes[InputSize.Large].container.height
                },
                icon = {
                    size = UDim2.fromOffset(arg1.Size.Size_600, arg1.Size.Size_600)
                },
                text = { tag = "text-label-large" }
            }
        },
        types = sharedVariants.types
    }
end
return function(arg1, arg2, arg3, arg4)
    local var1 = VariantsContext.useVariants("Button", func1, arg1)
    return composeStyleVariant(var1.common, var1.sizes[arg2], var1.types[arg3][arg4 or ColorNamespace.Color])
end
