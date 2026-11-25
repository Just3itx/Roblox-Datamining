-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T06:01:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local Enums = require(ProfilePlatform.Common.Enums)

local getProfilePlatform = require(ProfilePlatform.Networking.getProfilePlatform)

function GetProfilePlatform(profileId: string)
    return getProfilePlatform.API({
        profileId = profileId,
        profileType = Enums.ProfileTypes.User,
        components = {{
            component = Enums.Components.UserProfileHeader
        }},
        includeComponentOrdering = false
    })
end

return GetProfilePlatform
