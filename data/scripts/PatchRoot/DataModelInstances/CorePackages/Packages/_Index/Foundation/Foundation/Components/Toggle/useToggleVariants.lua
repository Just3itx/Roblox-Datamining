-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T09:01:44Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")

local _InternalInput = require(Foundation.Components.InternalInput)

local InputSize = require(Foundation.Enums.InputSize)

local _ControlState = require(Foundation.Enums.ControlState)

local composeStyleVariant = require(Foundation.Utility.composeStyleVariant)

local _Tokens = require(Foundation.Providers.Style.Tokens)

local VariantsContext = require(Foundation.Providers.Style.VariantsContext)
local getKnobSize = require(Foundation.Components.Knob.getKnobSize)

local function computeProps(tbl1)
    local offset = tbl1.knobSize.X.Offset
    local xOffset = (tbl1.size.height - offset) / 2

    return {
        input = {
            tag = tbl1.tag,
            size = UDim2.fromOffset(tbl1.size.width, tbl1.size.height),
            stroke = {
                thickness = tbl1.strokeThickness
            }
        },
        knob = {
            offPosition = UDim2.new(0, xOffset, 0.5, 0),
            onPosition = UDim2.new(0, tbl1.size.width - offset - xOffset, 0.5, 0)
        }
    }
end

local function variantsFactory(arg1)
    return {
        common = {
            input = {
                colors = {
                    backgroundStyle = arg1.Color.ActionStandard.Background,
                    hoverStyle = arg1.Color.State.Hover,
                    checkedStyle = arg1.Color.System.Contrast,
                    labelStyle = arg1.Color.Content.Emphasis,
                    labelHoverStyle = arg1.Color.Content.Emphasis
                },
                cursorRadius = UDim.new(0, arg1.Radius.Circle)
            }
        },
        sizes = {
            [InputSize.XSmall] = computeProps({
                tag = "radius-circle",
                size = {
                    width = arg1.Size.Size_700,
                    height = arg1.Size.Size_400
                },
                knobSize = getKnobSize(arg1, InputSize.XSmall),
                strokeThickness = arg1.Stroke.None
            }),
            [InputSize.Small] = computeProps({
                tag = "radius-circle",
                size = {
                    width = arg1.Size.Size_800,
                    height = arg1.Size.Size_500
                },
                knobSize = getKnobSize(arg1, InputSize.Small),
                strokeThickness = arg1.Stroke.None
            }),
            [InputSize.Medium] = computeProps({
                tag = "radius-circle",
                size = {
                    width = arg1.Size.Size_1000,
                    height = arg1.Size.Size_600
                },
                knobSize = getKnobSize(arg1, InputSize.Medium),
                strokeThickness = arg1.Stroke.None
            }),
            [InputSize.Large] = computeProps({
                tag = "radius-circle",
                size = {
                    width = arg1.Size.Size_1100,
                    height = arg1.Size.Size_600
                },
                knobSize = getKnobSize(arg1, InputSize.Medium),
                strokeThickness = arg1.Stroke.None
            })
        }
    }
end

return function(arg1, arg2)
    local var1 = VariantsContext.useVariants("Toggle", variantsFactory, arg1)
    return composeStyleVariant(var1.common, var1.sizes[arg2])
end
