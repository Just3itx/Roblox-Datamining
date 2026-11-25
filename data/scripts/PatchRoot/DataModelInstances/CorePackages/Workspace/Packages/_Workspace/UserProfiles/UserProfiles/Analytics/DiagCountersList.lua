-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T20:31:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local EventNames = require(script.Parent.EventNames)

local UserProfilesParent = script:FindFirstAncestor("UserProfiles").Parent
local DiagEventTypes = require(UserProfilesParent.SocialLuaAnalytics).Analytics.Enums.DiagEventTypes
local ErrorCodesForLogging = require(script.Parent.ErrorCodesForLogging)

return {
    [EventNames.UserProfilesRequestBegin] = {
        name = game:DefineFastString("UserProfilesRequestBegin", "UserProfilesRequestBegin")
    },
    [EventNames.UserProfilesRequestSuccess] = {
        name = game:DefineFastString("UserProfilesRequestSuccess", "UserProfilesRequestSuccess")
    },
    [EventNames.UserProfilesRequestFail] = {
        name = game:DefineFastString("UserProfilesRequestFail", "UserProfilesRequestFail")
    },
    [EventNames.UserProfilesRequestFailAfterRetry] = {
        name = game:DefineFastString("UserProfilesRequestFailAfterRetry", "UserProfilesRequestFailAfterRetry")
    },
    [EventNames.UserProfilesRequestSuccessAfterRetry] = {
        name = game:DefineFastString("UserProfilesRequestSuccessAfterRetry", "UserProfilesRequestSuccessAfterRetry")
    },
    [EventNames.UserProfilesErrorCode] = {
        type = DiagEventTypes.Counter,
        name = function(arg1)
            local str1 = tostring(arg1.status)
            local userProfilesErrorCode = EventNames.UserProfilesErrorCode

            return if ErrorCodesForLogging[str1] then userProfilesErrorCode .. str1 else userProfilesErrorCode .. "Other"
        end
    },
    [EventNames.UserProfilesUnmountEarly] = {
        type = DiagEventTypes.Counter,
        name = game:DefineFastString("UserProfilesUnmountEarly", "UserProfilesUnmountEarly")
    }
}
