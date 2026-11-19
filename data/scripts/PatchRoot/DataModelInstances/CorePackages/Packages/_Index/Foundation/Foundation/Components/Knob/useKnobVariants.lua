-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T08:20:40Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")

local InputSize = require(Foundation.Enums.InputSize)

local composeStyleVariant = require(Foundation.Utility.composeStyleVariant)

local _Types = require(Foundation.Components.Types)

local _Tokens = require(Foundation.Providers.Style.Tokens)

local VariantsContext = require(Foundation.Providers.Style.VariantsContext)
local getKnobSize = require(script.Parent.getKnobSize)

local IconSize = require(Foundation.Enums.IconSize)

local function computeProps(tbl1) -- Luacid: Inlined by compiler; 4 call sites recovered
    return {
        knob = {
            size = tbl1.size,
            iconSize = tbl1.iconSize
        }
    }
end

local function variantsFactory(arg1)
    return {
        common = {
            knob = {
                tag = "align-x-center align-y-center position-center-center anchor-center-center auto-xy radius-circle"
            }
        },
        sizes = {
            [InputSize.XSmall] = computeProps({ iconSize = IconSize.XSmall, size = getKnobSize(arg1, InputSize.XSmall) }),
            [InputSize.Small] = computeProps({ iconSize = IconSize.Small, size = getKnobSize(arg1, InputSize.Small) }),
            [InputSize.Medium] = computeProps({ iconSize = IconSize.Small, size = getKnobSize(arg1, InputSize.Medium) }),
            [InputSize.Large] = computeProps({ iconSize = IconSize.Small, size = getKnobSize(arg1, InputSize.Large) })
        },
        isInverse = {
            [false] = {
                knob = {
                    style = arg1.Color.Content.Emphasis
                },
                iconContainer = {
                    backgroundStyle = arg1.Inverse.Content.Emphasis
                }
            },
            [true] = {
                knob = {
                    style = arg1.Inverse.Content.Emphasis
                },
                iconContainer = {
                    backgroundStyle = arg1.Color.Content.Emphasis
                }
            }
        }
    }
end

return function(arg1, arg2, bool1: boolean)
    local var1 = VariantsContext.useVariants("Knob", variantsFactory, arg1)
    return composeStyleVariant(var1.common, var1.sizes[arg2], var1.isInverse[bool1])
end
