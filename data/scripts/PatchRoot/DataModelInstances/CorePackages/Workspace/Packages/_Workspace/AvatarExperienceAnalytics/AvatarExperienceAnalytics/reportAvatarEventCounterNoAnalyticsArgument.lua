-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T12:50:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")
local getAvatarEventCounterNameWithPlatform = require(script.Parent.getAvatarEventCounterNameWithPlatform)

local function reportAvatarEventCounterNoAnalyticsArgument(str1: string)
    if not str1 then
        RbxAnalyticsService:ReportCounter("AvatarExperienceCounterMiss", 1)
        return
    end
    local avatarEventCounterNameWithPlatform = getAvatarEventCounterNameWithPlatform(str1)
    RbxAnalyticsService:ReportCounter(avatarEventCounterNameWithPlatform, 1)
end

return reportAvatarEventCounterNoAnalyticsArgument
