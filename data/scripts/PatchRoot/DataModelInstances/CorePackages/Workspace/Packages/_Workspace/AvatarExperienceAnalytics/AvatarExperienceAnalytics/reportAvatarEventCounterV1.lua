-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T12:50:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")

local getAvatarEventCounterNameWithPlatform = require(script.Parent.getAvatarEventCounterNameWithPlatform)

local function reportAvatarEventCounterV1(counterName)
    counterName = getAvatarEventCounterNameWithPlatform(counterName)
    RbxAnalyticsService:ReportCounter(counterName, 1)
end

return reportAvatarEventCounterV1
