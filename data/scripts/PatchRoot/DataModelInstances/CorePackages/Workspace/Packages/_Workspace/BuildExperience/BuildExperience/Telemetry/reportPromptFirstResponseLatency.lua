-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T21:11:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")

local FIntBuildExperiencePromptFirstResponseMsThrottleHundredthsPercent = require(BuildExperience.Flags.FIntBuildExperiencePromptFirstResponseMsThrottleHundredthsPercent)
local sendBuildExperienceStat = require(BuildExperience.Telemetry.sendBuildExperienceStat)

local config = {
    eventName = "buildExperiencePromptFirstResponseMs",
    backends = { "RobloxTelemetryStat" },
    lastUpdated = { 2026, 10, 8 },
    description = "Milliseconds from sending a Build chat prompt to its first visible response (agent text or tool activity), including backend retries."
}

local function reportPromptFirstResponseLatency(num1: number, stalled: boolean)
    sendBuildExperienceStat({
        config = config,
        sampleHundredthsPercent = FIntBuildExperiencePromptFirstResponseMsThrottleHundredthsPercent,
        value = math.max(0, math.round(num1)),
        customFields = { stalled = stalled }
    })
end

return reportPromptFirstResponseLatency
