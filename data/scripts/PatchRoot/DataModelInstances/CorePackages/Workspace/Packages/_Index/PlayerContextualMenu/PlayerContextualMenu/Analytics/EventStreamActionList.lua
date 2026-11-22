-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T09:40:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local EventNames = require(script.Parent.EventNames)
local Enums = require(scriptParentParentParent.SocialLuaAnalytics).Analytics.Enums
local Contexts = Enums.Contexts
local SubPages = Enums.SubPages
local EventTypes = Enums.EventTypes

local function profileUserId<T>(arg1: T): T
    return arg1
end

return {
    [EventNames.RequestFriendship] = {
        context = Contexts.FriendsLanding,
        eventType = EventTypes.ButtonClick,
        additionalInfo = {
            subpage = SubPages.PlayerContextualMenu,
            btn = "addFriend"
        },
        formatRulesForAdditionalInfo = { profileUserId = profileUserId }
    },
    [EventNames.Unfriend] = {
        context = Contexts.FriendsLanding,
        eventType = EventTypes.ButtonClick,
        additionalInfo = {
            subpage = SubPages.PlayerContextualMenu,
            btn = "unFriend"
        },
        formatRulesForAdditionalInfo = { profileUserId = profileUserId }
    },
    [EventNames.AcceptFriendRequest] = {
        context = Contexts.FriendsLanding,
        eventType = EventTypes.ButtonClick,
        additionalInfo = {
            subpage = SubPages.PlayerContextualMenu,
            btn = "acceptFriend"
        },
        formatRulesForAdditionalInfo = { profileUserId = profileUserId }
    },
    [EventNames.IgnoreFriendRequest] = {
        context = Contexts.FriendsLanding,
        eventType = EventTypes.ButtonClick,
        additionalInfo = {
            subpage = SubPages.PlayerContextualMenu,
            btn = "ignoreFriend"
        },
        formatRulesForAdditionalInfo = { profileUserId = profileUserId }
    },
    [EventNames.BlockPlayer] = {
        context = Contexts.FriendsLanding,
        eventType = EventTypes.ButtonClick,
        additionalInfo = {
            subpage = SubPages.PlayerContextualMenu,
            btn = "block"
        },
        formatRulesForAdditionalInfo = { profileUserId = profileUserId }
    },
    [EventNames.ReportPlayer] = {
        context = Contexts.FriendsLanding,
        eventType = EventTypes.ButtonClick,
        additionalInfo = {
            subpage = SubPages.PlayerContextualMenu,
            btn = "report"
        },
        formatRulesForAdditionalInfo = { profileUserId = profileUserId }
    },
    [EventNames.JoinExperience] = {
        context = Contexts.FriendsLanding,
        eventType = EventTypes.ButtonClick,
        additionalInfo = {
            subpage = SubPages.PlayerContextualMenu,
            btn = "joinUser"
        },
        formatRulesForAdditionalInfo = { profileUserId = profileUserId }
    },
    [EventNames.ViewExperienceDetails] = {
        context = Contexts.FriendsLanding,
        eventType = EventTypes.ButtonClick,
        additionalInfo = {
            subpage = SubPages.PlayerContextualMenu,
            btn = "viewExperienceDetails"
        },
        formatRulesForAdditionalInfo = { profileUserId = profileUserId }
    },
    [EventNames.ViewPlatformProfile] = {
        context = Contexts.FriendsLanding,
        eventType = EventTypes.ButtonClick,
        additionalInfo = {
            subpage = SubPages.PlayerContextualMenu,
            btn = "viewPlatformProfile"
        },
        formatRulesForAdditionalInfo = { profileUserId = profileUserId }
    }
}
