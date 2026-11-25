-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:50:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent

local _Component = require(ProfilePlatform.Types.Component)
local Enums = require(ProfilePlatform.Common.Enums)
local getSupportedActionsForProfileType = require(ProfilePlatform.Hooks.getSupportedActionsForProfileType)
local FFlagAddSocialLinksToCommunityProfile = require(ProfilePlatformParent.SharedFlags).FFlagAddSocialLinksToCommunityProfile

local FFlagAddCommunityLockedToCommunityProfile = require(ProfilePlatformParent.SharedFlags).FFlagAddCommunityLockedToCommunityProfile
local FFlagAddEventsToCommunityProfile = require(ProfilePlatform.Flags.FFlagAddEventsToCommunityProfile)
local FFlagHideLeaveFromOpenCommunityOwner = require(ProfilePlatform.Flags.FFlagHideLeaveFromOpenCommunityOwner)
local FFlagGroupAnnouncementsSdui = require(ProfilePlatformParent.SharedFlags).FFlagGroupAnnouncementsSdui
local FFlagGroupForumsDiscoverySdui = require(ProfilePlatformParent.SharedFlags).FFlagGroupForumsDiscoverySdui

return function()
    local tbl1 = {
        {
            component = Enums.Components.CommunityProfileHeader
        },
        {
            component = Enums.Components.About
        },
        {
            component = Enums.Components.Actions,
            supportedActions = getSupportedActionsForProfileType(Enums.ProfileTypes.Community),
            isActionsV2Supported = true
        },
        {
            component = Enums.Components.Experiences
        },
        {
            component = Enums.Components.Store
        },
        {
            component = Enums.Components.ViewFullProfile
        },
        {
            component = Enums.Components.CoverPhoto
        }
    }

    if FFlagAddSocialLinksToCommunityProfile then
        table.insert(tbl1, { component = Enums.Components.SocialLinks })
    end

    if FFlagAddCommunityLockedToCommunityProfile then
        table.insert(tbl1, { component = Enums.Components.CommunityLocked })
    end

    if FFlagHideLeaveFromOpenCommunityOwner then
        table.insert(tbl1, { component = Enums.Components.CommunityDeactivated })
    end

    if FFlagAddEventsToCommunityProfile then
        table.insert(tbl1, { component = Enums.Components.Events })
    end

    if FFlagGroupAnnouncementsSdui then
        table.insert(tbl1, { component = Enums.Components.Announcements })
    end

    if FFlagGroupForumsDiscoverySdui then
        table.insert(tbl1, { component = Enums.Components.GroupForumsDiscovery })
    end

    return tbl1
end
