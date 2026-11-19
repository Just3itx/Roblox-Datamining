-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T08:10:53Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")

local _Types = require(Foundation.Components.Types)

local InputSize = require(Foundation.Enums.InputSize)

local composeStyleVariant = require(Foundation.Utility.composeStyleVariant)

local _Tokens = require(Foundation.Providers.Style.Tokens)

local VariantsContext = require(Foundation.Providers.Style.VariantsContext)

local function variantsFactory(arg1)
    local thickness = math.ceil(arg1.Stroke.Standard)
    return {
        common = {
            container = {
                tag = "row align-x-left align-y-top auto-xy",
                padding = UDim.new(0, thickness)
            },
            input = {
                stroke = { thickness = thickness }
            }
        },
        sizes = {
            [InputSize.XSmall] = {
                container = { tag = "gap-medium" }
            },
            [InputSize.Small] = {
                container = { tag = "gap-medium" }
            },
            [InputSize.Medium] = {
                container = { tag = "gap-medium" }
            },
            [InputSize.Large] = {
                container = { tag = "gap-medium" }
            }
        },
        labelPosition = {
            [Enum.HorizontalAlignment.Left] = {
                container = { tag = "flex-x-between size-full-0" }
            },
            [Enum.HorizontalAlignment.Right] = {
                container = { tag = "" }
            }
        }
    }
end

return function(arg1, arg2, arg3)
    local var1 = VariantsContext.useVariants("InternalInput", variantsFactory, arg1)
    return composeStyleVariant(var1.common, var1.sizes[arg2], var1.labelPosition[arg3])
end
