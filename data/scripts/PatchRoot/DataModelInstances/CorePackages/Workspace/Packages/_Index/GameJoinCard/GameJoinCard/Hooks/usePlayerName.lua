-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T19:51:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameJoinCardParent = script:FindFirstAncestor("GameJoinCard").Parent

local React = require(GameJoinCardParent.React)
local Signals = require(GameJoinCardParent.Signals)
local SignalsReact = require(GameJoinCardParent.SignalsReact)
local UserProfiles = require(GameJoinCardParent.UserProfiles)
local SharedFlags = require(GameJoinCardParent.SharedFlags)

local FFlagSocialCarouselUseProfileStore = SharedFlags.FFlagSocialCarouselUseProfileStore
local FFlagUserProfilePlatformProfile = SharedFlags.FFlagUserProfilePlatformProfile

local function usePlayerName(str1: string)
    if not FFlagSocialCarouselUseProfileStore then
        local var1 = UserProfiles.Hooks.useUserProfilesFetch({
            userIds = { str1 },
            query = if FFlagUserProfilePlatformProfile then UserProfiles.Queries.userProfilesCombinedNameByUserIds else UserProfiles.Queries.userProfilesCombinedAndPlatformByUserIds
        })

        return React.useMemo(function()
            if var1.data then
                return UserProfiles.Selectors.getCombinedNameFromId(var1.data, str1) or ""
            end

            return ""
        end, { var1.data, str1 })
    end

    local var1 = React.useMemo(function()
        return UserProfiles.Stores.UserProfileStore.get().fetchNamesByUserIds({ str1 })
    end, { str1 })

    local var2 = React.useMemo(function()
        return Signals.createComputed(function(arg1)
            local var2 = var1(arg1)
            local var3 = var2 and var2.data and var2.data[1]
            if var3 and var3.names then
                return (var3.names.getCombinedName(arg1))
            end

            return nil
        end)
    end, { var1 })

    return SignalsReact.useSignalState(var2) or ""
end

return usePlayerName
