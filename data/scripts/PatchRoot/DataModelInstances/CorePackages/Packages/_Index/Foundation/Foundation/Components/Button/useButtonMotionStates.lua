-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T04:01:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FoundationParent = script:FindFirstAncestor("Foundation").Parent

local _React = require(FoundationParent.React)

local Motion = require(FoundationParent.Motion)
local TransitionPreset = Motion.TransitionPreset

local function useButtonMotionStates(num1: number?, num2: number)
    return {
        Default = Motion.createState({
            transparency = num1 or 0,
            textTransparency = num1 or 0,
            iconScale = 1
        }, {
            iconTransparency = Motion.transition(TransitionPreset.Default, { easingStyle = Enum.EasingStyle.Linear, duration = 0.5 }),
            transparency = Motion.transition({ easingStyle = Enum.EasingStyle.Linear, duration = 0.2 }),
            default = Motion.transition(TransitionPreset.Default, { duration = 0.2 })
        }),
        Loading = Motion.createState({
            transparency = 0,
            textTransparency = 1,
            iconTransparency = 1,
            iconScale = 0
        }, {
            iconTransparency = Motion.transition(TransitionPreset.Default, { easingStyle = Enum.EasingStyle.Linear, duration = 0.2 }),
            default = Motion.transition(TransitionPreset.Default, { duration = 0.2 })
        }),
        Disabled = Motion.createState(
            { transparency = num2, textTransparency = num2 },
            {
                default = Motion.transition({ easingStyle = Enum.EasingStyle.Linear, duration = 0.1 })
            }
        )
    }
end
return useButtonMotionStates
