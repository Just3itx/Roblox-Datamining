-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T06:00:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")

local Enums = require(ProfilePlatform.Common.Enums)
local useProfileJsonComponent = require(ProfilePlatform.Hooks.useProfileJsonComponent)

local FFlagProfilePlatformAddCurrentlyPlaying = require(ProfilePlatform.Flags.FFlagProfilePlatformAddCurrentlyPlaying)

return function(str1: string?): boolean
    local contextualInformation = (useProfileJsonComponent(Enums.Components.UserProfileHeader) or {}).contextualInformation
    local context = contextualInformation and contextualInformation.context

    if context and context ~= "None" then
        if context == Enums.ContextualTypes.Presence and (str1 == Enums.PresenceTypes.Online or str1 == Enums.PresenceTypes.Offline) then
            return false
        end

        return not FFlagProfilePlatformAddCurrentlyPlaying
            or str1 ~= Enums.PresenceTypes.InGame
            or context ~= Enums.ContextualTypes.Presence
            or false
    end

    return false
end
