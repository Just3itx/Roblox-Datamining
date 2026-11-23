-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T05:01:12Z
-- Luau bytecode version: 14 | Luau type version: 3
local AchievementsParent = script:FindFirstAncestor("Achievements").Parent

local LoggingProtocol = require(AchievementsParent.LoggingProtocol)

game:DefineFastInt("AchievementGrantedThrottleHundrethsPercent", 0)

return {
    eventName = "AchievementGranted",
    backends = { LoggingProtocol.TelemetryBackends.Points },
    throttlingPercentage = game:GetFastInt("AchievementGrantedThrottleHundrethsPercent"),
    lastUpdated = { 24, 7, 3 },
    description = "Report whenever an achievement is granted to Points with document name \"achievementgranted\""
}
