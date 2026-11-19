-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T08:30:55Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local _React = require(FoundationParent.React)

local useTokens = require(Foundation.Providers.Style.useTokens)

local Motion = require(FoundationParent.Motion)
local TransitionPreset = Motion.TransitionPreset

local function useOptionSelectorGroupItemMotionStates(num1: number?, num2: number)
    local var1 = useTokens()
    return {
        Default = Motion.createState({
            transparency = num1 or 0,
            textTransparency = num1 or 0
        }, {
            iconTransparency = Motion.transition(TransitionPreset.Default, { easingStyle = Enum.EasingStyle.Linear, duration = var1.Time.Time_500 }),
            transparency = Motion.transition({ easingStyle = Enum.EasingStyle.Linear, duration = var1.Time.Time_200 }),
            default = Motion.transition(TransitionPreset.Default, { duration = var1.Time.Time_200 })
        }),
        Disabled = Motion.createState(
            { transparency = num2, textTransparency = num2 },
            {
                default = Motion.transition({ easingStyle = Enum.EasingStyle.Linear, duration = var1.Time.Time_100 })
            }
        )
    }
end
return useOptionSelectorGroupItemMotionStates
