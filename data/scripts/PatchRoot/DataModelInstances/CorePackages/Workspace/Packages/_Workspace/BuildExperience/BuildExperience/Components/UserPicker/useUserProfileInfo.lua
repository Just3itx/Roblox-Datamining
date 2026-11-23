-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:21:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local React = require(BuildExperienceParent.React)
local SignalsReact = require(BuildExperienceParent.SignalsReact)

local UserProfile = require(BuildExperienceParent.DataHydration.UserProfile)

local function useUserProfileInfo(num1: number)
    local var1 = React.useMemo(function()
        return UserProfile.getAndFetchUserInfo(num1)
    end, { num1 })

    local var2 = SignalsReact.useSignalState(var1.info)
    local var3 = SignalsReact.useSignalState(var1.status)

    return {
        displayName = if var2 == nil then "" else var2.displayName,
        username = if var2 == nil then "" else var2.username,
        hasVerifiedBadge = not (var2 == nil) and var2.hasVerifiedBadge,
        isLoading = var3 ~= "Ready"
    }
end

return useUserProfileInfo
