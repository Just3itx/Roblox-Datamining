-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:31:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local Foundation = require(BuildExperienceParent.Foundation)
local Motion = require(BuildExperienceParent.Motion)
local React = require(BuildExperienceParent.React)

local _AnimatedChipGroupView = require(script.Parent.AnimatedChipGroupView)
local usePreferences = Foundation.Hooks.usePreferences
local useTokens = Foundation.Hooks.useTokens

local function useAnimatedChipGroupViewModel(tbl1)
    local reducedMotion = usePreferences().reducedMotion
    local tokens = useTokens()
    local seconds = (#tbl1.chips - 1) * 0.15 + 0.25
    local var2, var3 = Motion.useMotion({ seconds = if reducedMotion then seconds else 0 })

    React.useEffect(function()
        var3(
            Motion.createState({ seconds = seconds }, {
                default = Motion.transition({ duration = if reducedMotion then 0 else seconds, easingStyle = Enum.EasingStyle.Linear })
            })
        )
    end, { var3, seconds, reducedMotion })

    local chipAnimationStates = ({})
    for k in tbl1.chips do
        local var4 = 0.15 * (k - 1)
        local tbl3 = {
            hasStarted = var2.seconds:map(function(num2: number): boolean
                return var4 <= num2
            end),
            groupTransparency = var2.seconds:map(function(num2: number): number
                return 1 - math.clamp((num2 - var4) / 0.25, 0, 1)
            end)
        }

        chipAnimationStates[k] = tbl3
    end

    return {
        chips = tbl1.chips,
        chipGroupRef = tbl1.chipGroupRef,
        chipAnimationStates = chipAnimationStates,
        tokens = tokens
    }
end

return useAnimatedChipGroupViewModel
