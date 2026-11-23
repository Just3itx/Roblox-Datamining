-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T21:11:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TelemetryService = game:GetService("TelemetryService")

local BuildExperience = script:FindFirstAncestor("BuildExperience")

local shouldSampleHundredthsPercent = require(BuildExperience.Telemetry.shouldSampleHundredthsPercent)

local function sendBuildExperienceStat(tbl1)
    local sampleHundredthsPercent = tbl1.sampleHundredthsPercent
    if sampleHundredthsPercent and not shouldSampleHundredthsPercent(sampleHundredthsPercent) then
        return
    end

    TelemetryService:LogStat(tbl1.config, { customFields = tbl1.customFields }, tbl1.value)
end

return sendBuildExperienceStat
