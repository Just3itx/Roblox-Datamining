-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T04:01:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FoundationParent = script:FindFirstAncestor("Foundation").Parent

local _React = require(FoundationParent.React)

local Motion = require(FoundationParent.Motion)
local TransitionPreset = Motion.TransitionPreset

local function useSpinnerMotionStates()
    return {
        Default = Motion.createState({ scale = 0, transparency = 1 }, {
            default = Motion.transition(TransitionPreset.Default, { duration = 0.2 }),
            transparency = Motion.transition({ easingStyle = Enum.EasingStyle.Linear, duration = 0.2 })
        }),
        Loading = Motion.createState({ scale = 1, transparency = 0 }, {
            default = Motion.transition(TransitionPreset.Default, { duration = 0.2, delay = 0.1 }),
            transparency = Motion.transition({ easingStyle = Enum.EasingStyle.Linear, duration = 0.2 })
        })
    }
end

return useSpinnerMotionStates
