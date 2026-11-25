-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T06:01:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local Enums = require(ProfilePlatform.Common.Enums)

local getProfilePlatform = require(ProfilePlatform.Networking.getProfilePlatform)
local _Component = require(ProfilePlatform.Types.Component)

local FFlagProfilePlatformAddCurrentlyPlaying = require(ProfilePlatform.Flags.FFlagProfilePlatformAddCurrentlyPlaying)

local FFlagProfilePlatformRefreshActionsRespectPolicies = require(ProfilePlatform.Flags.FFlagProfilePlatformRefreshActionsRespectPolicies)
local FFlagProfilePlatformGracefulVisibility = require(ProfilePlatform.Flags.FFlagProfilePlatformGracefulVisibility)

function GetProfilePlatform(profileId: string, arg1)
    local var1 = (not FFlagProfilePlatformRefreshActionsRespectPolicies or arg1 == nil)
        and {
            component = Enums.Components.Actions,
            isActionsV2Supported = true
        }
        or arg1

    local components = {
        {
            component = Enums.Components.UserProfileHeader
        },
        var1
    }

    if FFlagProfilePlatformAddCurrentlyPlaying then
        table.insert(components, { component = Enums.Components.CurrentlyPlaying })
    end
    if FFlagProfilePlatformGracefulVisibility then
        table.insert(components, { component = Enums.Components.Friends })
    end

    return getProfilePlatform.API({
        profileId = profileId,
        profileType = Enums.ProfileTypes.User,
        components = components,
        includeComponentOrdering = false
    })
end

return GetProfilePlatform
