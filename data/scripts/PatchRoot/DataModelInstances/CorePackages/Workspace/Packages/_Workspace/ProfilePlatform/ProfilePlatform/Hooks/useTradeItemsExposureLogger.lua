-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T06:00:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent

local React = require(ProfilePlatformParent.React)
local useLocalUserId = require(ProfilePlatformParent.RobloxAppHooks).useLocalUserId

local Enums = require(ProfilePlatform.Common.Enums)
local useProfileWrapperContext = require(ProfilePlatform.Contexts.useProfileWrapperContext)
local useHasPaidTradingAccess = require(ProfilePlatform.Hooks.useHasPaidTradingAccess)
local logTradeItemsExposureIfEligible = require(ProfilePlatform.Utils.logTradeItemsExposureIfEligible)

local function useTradeItemsExposureLogger()
    local var1 = useProfileWrapperContext()
    local profileId = var1.profileId
    local bool1 = var1.profileType == Enums.ProfileTypes.User
    local localUserId = tostring((useLocalUserId()))
    local localHasPaidTradingAccess = useHasPaidTradingAccess(localUserId)
    local otherHasPaidTradingAccess = useHasPaidTradingAccess(if bool1 then profileId else nil)

    return React.useCallback(function()
        if not bool1 then
            return
        end

        logTradeItemsExposureIfEligible({
            profileId = tostring(profileId),
            localUserId = localUserId,
            localHasPaidTradingAccess = localHasPaidTradingAccess,
            otherHasPaidTradingAccess = otherHasPaidTradingAccess
        })
    end, {
        profileId,
        localUserId,
        localHasPaidTradingAccess,
        otherHasPaidTradingAccess,
        bool1
    })
end
return useTradeItemsExposureLogger
