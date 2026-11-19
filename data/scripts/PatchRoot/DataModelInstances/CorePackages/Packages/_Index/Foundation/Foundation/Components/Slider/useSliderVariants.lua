-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T09:00:56Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")

local InputSize = require(Foundation.Enums.InputSize)

local SliderVariant = require(Foundation.Enums.SliderVariant)

local composeStyleVariant = require(Foundation.Utility.composeStyleVariant)

local _Tokens = require(Foundation.Providers.Style.Tokens)

local VariantsContext = require(Foundation.Providers.Style.VariantsContext)

local _Types = require(Foundation.Components.Types)

local Flags = require(Foundation.Utility.Flags)

local function variantsFactory(arg1)
    return {
        common = {
            bar = { tag = "position-center-center anchor-center-center radius-circle" },
            fill = { tag = "radius-circle" }
        },
        variants = {
            [SliderVariant.Emphasis] = {
                bar = { tag = "bg-shift-200" },
                fill = { tag = "bg-emphasis" },
                knob = {
                    style = arg1.Color.Extended.White.White_100,
                    dragStyle = arg1.Color.System.Emphasis,
                    hasShadow = true
                }
            },
            [SliderVariant.Standard] = {
                bar = { tag = "bg-shift-200" },
                fill = { tag = "bg-system-contrast" },
                knob = {
                    style = arg1.Color.System.Contrast,
                    dragStyle = arg1.Color.System.Contrast,
                    stroke = {
                        Color = arg1.Color.Stroke.Default.Color3,
                        Transparency = arg1.Color.Stroke.Default.Transparency,
                        Thickness = arg1.Stroke.Standard
                    },
                    hasShadow = true
                }
            },
            [SliderVariant.Utility] = {
                knob = {
                    style = arg1.Color.None,
                    dragStyle = arg1.Color.None,
                    stroke = {
                        Color = arg1.Color.System.Contrast.Color3,
                        Transparency = arg1.Color.System.Contrast.Transparency,
                        Thickness = arg1.Stroke.Thicker
                    },
                    hasShadow = true
                }
            }
        },
        sizes = {
            [InputSize.XSmall] = {
                bar = {
                    height = arg1.Size.Size_100
                }
            },
            [InputSize.Small] = {
                bar = {
                    height = arg1.Size.Size_150
                }
            },
            [InputSize.Medium] = {
                bar = {
                    height = arg1.Size.Size_200
                }
            },
            [InputSize.Large] = {
                bar = {
                    height = arg1.Size.Size_250
                }
            }
        },
        orientation = {
            [true] = {
                selectionGroup = {
                    SelectionBehaviorLeft = Enum.SelectionBehavior.Escape,
                    SelectionBehaviorRight = Enum.SelectionBehavior.Escape,
                    SelectionBehaviorUp = Enum.SelectionBehavior.Stop,
                    SelectionBehaviorDown = Enum.SelectionBehavior.Stop
                }
            },
            [false] = {
                selectionGroup = {
                    SelectionBehaviorLeft = Enum.SelectionBehavior.Stop,
                    SelectionBehaviorRight = Enum.SelectionBehavior.Stop,
                    SelectionBehaviorUp = Enum.SelectionBehavior.Escape,
                    SelectionBehaviorDown = Enum.SelectionBehavior.Escape
                }
            }
        }
    }
end

return function(arg1, arg2, arg3, bool1: boolean)
    local var1 = VariantsContext.useVariants("Slider", variantsFactory, arg1)
    if Flags.FoundationSliderCapture then
        return composeStyleVariant(var1.common, var1.variants[arg3], var1.sizes[arg2])
    end
    return composeStyleVariant(var1.common, var1.variants[arg3], var1.sizes[arg2], var1.orientation[bool1])
end
