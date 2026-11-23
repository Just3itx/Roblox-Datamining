-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:11:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local React = require(BuildExperienceParent.React)

local AnalyticsEventContext = require(BuildExperience.Analytics.AnalyticsEventContext)
local AnalyticsPageEvents = require(BuildExperience.Analytics.AnalyticsPageEvents)
local _GoalLockedActionId = require(BuildExperience.Analytics.Goals.GoalLockedActionId)
local FFlagBuildExperienceEventContextTelemetry = require(BuildExperience.Flags.FFlagBuildExperienceEventContextTelemetry)

local function useGoalLockedTelemetry(num1: number, str1: string, arg1, arg2)
    local var1 = React.useRef({})
    local var2 = if FFlagBuildExperienceEventContextTelemetry then React.useContext(AnalyticsEventContext) else nil

    React.useEffect(function()
        if arg1 ~= nil then
            local str2 = `{num1}.{str1}.{arg1}.primary`
            if not var1.current[str2] then
                var1.current[str2] = true
                AnalyticsPageEvents.goalCtaImpression(num1, str1, arg1, "primary", var2)
            end
        end

        if arg2 == nil then
            return
        end

        local str2 = `{num1}.{str1}.{arg2}.secondary`
        if not var1.current[str2] then
            var1.current[str2] = true
            AnalyticsPageEvents.goalCtaImpression(num1, str1, arg2, "secondary", var2)
        end
    end, {
        num1,
        str1,
        arg1,
        arg2,
        var2
    })
    return React.useCallback(function(arg3, arg4)
        AnalyticsPageEvents.goalCtaClick(num1, str1, arg4, arg3, var2)
    end, { num1, str1, var2 })
end

return useGoalLockedTelemetry
