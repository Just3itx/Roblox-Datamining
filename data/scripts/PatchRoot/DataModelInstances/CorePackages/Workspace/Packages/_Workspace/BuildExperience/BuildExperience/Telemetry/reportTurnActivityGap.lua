-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T21:11:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TelemetryService = game:GetService("TelemetryService")

local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local SharedFlags = require(BuildExperienceParent.SharedFlags)

local sendBuildExperienceStat = require(BuildExperience.Telemetry.sendBuildExperienceStat)

local FFlagBuildExperiencePromptFailureTelemetry = SharedFlags.FFlagBuildExperiencePromptFailureTelemetry

game:DefineFastInt("BuildExperienceTurnActivityGapMsThrottleHundredthsPercent", 0)

local tbl1 = {
    eventName = "buildExperienceTurnActivityGapMs",
    backends = { "RobloxTelemetryStat" },
    lastUpdated = { 2026, 6, 30 },
    description = "Milliseconds between visible chat-turn UI updates during a live CAS turn."
}

local function shouldSample(fastInt: number): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return not (fastInt <= 0) and (fastInt >= 10000 or math.random(1, 10000) <= fastInt)
end

return {
    log = function(num1: number, isFirstActivity: boolean, universeId: number?)
        if FFlagBuildExperiencePromptFailureTelemetry then
            sendBuildExperienceStat({
                config = tbl1,
                sampleHundredthsPercent = game:GetFastInt("BuildExperienceTurnActivityGapMsThrottleHundredthsPercent"),
                value = math.max(0, math.round(num1)),
                customFields = { universeId = universeId, isFirstActivity = isFirstActivity }
            })
        elseif shouldSample((game:GetFastInt("BuildExperienceTurnActivityGapMsThrottleHundredthsPercent"))) then
            TelemetryService:LogStat(
                tbl1,
                {
                    customFields = { universeId = universeId, isFirstActivity = isFirstActivity }
                },
                math.max(0, math.floor(num1 + 0.5))
            )
        end
    end,
    TurnActivityGapStatConfig = tbl1
}
