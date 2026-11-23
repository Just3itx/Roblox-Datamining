-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:20:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local React = require(BuildExperienceParent.React)

local _AnalyticsWindow = require(BuildExperience.Analytics.AnalyticsWindow)
local AnalyticsEventContext = require(BuildExperience.Analytics.AnalyticsEventContext)
local AnalyticsPageEvents = require(BuildExperience.Analytics.AnalyticsPageEvents)
local FFlagBuildExperienceEventContextTelemetry = require(BuildExperience.Flags.FFlagBuildExperienceEventContextTelemetry)
local _useGoalsSectionViewModel = require(script.Parent.useGoalsSectionViewModel)

local function useGoalsSectionTelemetry(num1: number, arg1, bool1: boolean, tbl1)
    local var1 = React.useRef({})
    local var2 = if FFlagBuildExperienceEventContextTelemetry then React.useContext(AnalyticsEventContext) else nil

    React.useEffect(function()
        if not bool1 then
            return
        end

        for _, value in tbl1 do
            local str1 = if value.isLocked then "locked" else "unlocked"
            local str2 = `{num1}.{arg1}.{value.goal.id}.{str1}`
            if not var1.current[str2] then
                var1.current[str2] = true
                AnalyticsPageEvents.goalImpression(num1, value.goal.id, str1, arg1, var2)
            end
        end
    end, {
        bool1,
        tbl1,
        num1,
        arg1,
        var2
    })
end
return useGoalsSectionTelemetry
