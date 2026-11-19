-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T08:31:01Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")

local InputLabelSize = require(Foundation.Enums.InputLabelSize)

local OptionSelectorGroupSize = require(Foundation.Enums.OptionSelectorGroupSize)

local Orientation = require(Foundation.Enums.Orientation)

local composeStyleVariant = require(Foundation.Utility.composeStyleVariant)

local _Tokens = require(Foundation.Providers.Style.Tokens)

local _Types = require(Foundation.Components.Types)

local VariantsContext = require(Foundation.Providers.Style.VariantsContext)

local function variantsFactory(_)
    return {
        common = {
            container = { tag = "col gap-small size-full-0 auto-y" },
            list = { tag = "gap-medium size-full-0 auto-y" }
        },
        sizes = {
            [OptionSelectorGroupSize.XSmall] = {
                legend = {
                    size = InputLabelSize.Small
                }
            },
            [OptionSelectorGroupSize.Small] = {
                legend = {
                    size = InputLabelSize.Small
                }
            },
            [OptionSelectorGroupSize.Medium] = {
                legend = {
                    size = InputLabelSize.Medium
                }
            }
        },
        orientations = {
            [Orientation.Vertical] = {
                list = {
                    tag = { col = true }
                }
            },
            [Orientation.Horizontal] = {
                list = {
                    tag = { row = true }
                }
            }
        }
    }
end

return function(arg1, arg2, arg3)
    local var1 = VariantsContext.useVariants("OptionSelectorGroup", variantsFactory, arg1)
    return (composeStyleVariant(var1.common, var1.sizes[arg2], var1.orientations[arg3]))
end
