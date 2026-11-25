-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:50:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent
local React = require(ProfilePlatformParent.React)

local Enums = require(ProfilePlatform.Common.Enums)
local useProfileJsonComponent = require(ProfilePlatform.Hooks.useProfileJsonComponent)
local useProfileWrapperContext = require(ProfilePlatform.Contexts.useProfileWrapperContext)
local parseSectionsFromData = require(ProfilePlatform.Components.About.parseSectionsFromData)
local FFlagProfileAboutDetailsUseSheet = require(ProfilePlatformParent.SharedFlags).FFlagProfileAboutDetailsUseSheet

return function()
    local profileType = useProfileWrapperContext().profileType
    local aboutDetails = useProfileJsonComponent(Enums.Components.About) or {}

    local aboutSections = React.useMemo(function()
        return parseSectionsFromData(
            aboutDetails,
            profileType,
            if profileType == Enums.ProfileTypes.User and aboutDetails.name then `@{aboutDetails.name}` else aboutDetails.name or ""
        )
    end, { aboutDetails, profileType, aboutDetails.name })

    local profileName = if FFlagProfileAboutDetailsUseSheet then if profileType == Enums.ProfileTypes.User and aboutDetails.name then `@{aboutDetails.name}` else aboutDetails.name else nil
    return { aboutDetails = aboutDetails, aboutSections = aboutSections, profileName = profileName }
end
