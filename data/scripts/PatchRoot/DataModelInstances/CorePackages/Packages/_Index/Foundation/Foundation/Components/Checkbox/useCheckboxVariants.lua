-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T07:30:57Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")

local _Types = require(Foundation.Components.Types)

local _InternalInput = require(Foundation.Components.InternalInput)

local InputSize = require(Foundation.Enums.InputSize)

local _ControlState = require(Foundation.Enums.ControlState)

local composeStyleVariant = require(Foundation.Utility.composeStyleVariant)

local _Tokens = require(Foundation.Providers.Style.Tokens)

local VariantsContext = require(Foundation.Providers.Style.VariantsContext)

local function variantsFactory(arg1)
    return {
        common = {
            input = {
                tag = "radius-small",
                colors = {
                    checkedStyle = arg1.Color.ActionSubEmphasis.Background
                },
                cursorRadius = UDim.new(0, arg1.Radius.Small)
            },
            checkmark = {
                tag = "position-center-center anchor-center-center content-action-sub-emphasis"
            }
        },
        sizes = {
            [InputSize.XSmall] = {
                input = {
                    size = UDim2.fromOffset(arg1.Size.Size_400, arg1.Size.Size_400)
                },
                checkmark = { tag = "size-400" }
            },
            [InputSize.Small] = {
                input = {
                    size = UDim2.fromOffset(arg1.Size.Size_500, arg1.Size.Size_500)
                },
                checkmark = { tag = "size-500" }
            },
            [InputSize.Medium] = {
                input = {
                    size = UDim2.fromOffset(arg1.Size.Size_600, arg1.Size.Size_600)
                },
                checkmark = { tag = "size-600" }
            },
            [InputSize.Large] = {
                input = {
                    size = UDim2.fromOffset(arg1.Size.Size_600, arg1.Size.Size_600)
                },
                checkmark = { tag = "size-600" }
            }
        }
    }
end

return function(arg1, arg2)
    local var1 = VariantsContext.useVariants("Checkbox", variantsFactory, arg1)
    return composeStyleVariant(var1.common, var1.sizes[arg2])
end
