-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T15:40:55Z
-- Luau bytecode version: 14 | Luau type version: 3
local FriendsLandingParent = script:FindFirstAncestor("FriendsLanding").Parent

local SocialCommon = require(FriendsLandingParent.SocialCommon)
local CtaSurfaces = require(FriendsLandingParent.UserList).Enums.CtaSurfaces
return {
    supportedActions = { "Chat", "JoinExperience" },
    chatEntryPoint = SocialCommon.Enums.ChatEntryPointNames.FriendsLandingPage,
    analytics = {
        surface = CtaSurfaces.FriendsLandingPage
    }
}
