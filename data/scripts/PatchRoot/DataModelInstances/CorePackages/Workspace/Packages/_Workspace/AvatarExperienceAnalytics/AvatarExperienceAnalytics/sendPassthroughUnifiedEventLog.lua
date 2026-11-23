-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T12:50:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceAnalyticsParent = script:FindFirstAncestor("AvatarExperienceAnalytics").Parent

local mutedError = require(AvatarExperienceAnalyticsParent.Loggers).mutedError
local UnifiedLoggingSurface = require(AvatarExperienceAnalyticsParent.AvatarExperienceNavigation).Enums.UnifiedLoggingSurface
local FFlagAXInExperienceNotificationsPassthrough = require(script.Parent.FFlagAXInExperienceNotificationsPassthrough)
local UnifiedEventTypes = require(script.Parent.Generated.UnifiedEventTypes)
local sendUnifiedEventLog = require(script.Parent.sendUnifiedEventLog)
local sendUnifiedEventLogForInstance = require(script.Parent.sendUnifiedEventLogForInstance)

local function toUnifiedEventFields<T>(arg1: T): T -- Luacid: unused: defined but never referenced
    return arg1
end

local function reportIfNotPassthrough(str1: string, arg1)
    if arg1.surface == UnifiedLoggingSurface.IN_EXPERIENCE_NOTIFICATIONS and not FFlagAXInExperienceNotificationsPassthrough
        or not UnifiedEventTypes.PassthroughSurfaces[arg1.surface]
    then
        mutedError(str1 .. ": surface is not on the passthrough route", { surface = tostring(arg1.surface) })
    end
end

return {
    send = function(arg1, arg2, arg3)
        sendUnifiedEventLog(arg1, arg2, arg3)
        reportIfNotPassthrough("sendPassthroughUnifiedEventLog", arg1)
    end,
    sendForInstance = function(arg1, arg2, arg3)
        sendUnifiedEventLogForInstance(arg1, arg2, arg3)
        reportIfNotPassthrough("sendPassthroughUnifiedEventLogForInstance", arg2)
    end
}
