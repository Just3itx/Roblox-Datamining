-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T06:01:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local Enums = require(ProfilePlatform.Common.Enums)
local _Component = require(ProfilePlatform.Types.Component)

local getProfilePlatform = require(ProfilePlatform.Networking.getProfilePlatform)

function GetProfilePlatform(profileId: string)
    local components = {
        {
            component = Enums.Components.UserProfileHeader
        },
        {
            component = Enums.Components.About
        }
    }

    table.insert(components, { component = Enums.Components.ProfileBackground })

    return getProfilePlatform.API({
        profileId = profileId,
        profileType = Enums.ProfileTypes.User,
        components = components,
        includeComponentOrdering = false
    })
end

return GetProfilePlatform
