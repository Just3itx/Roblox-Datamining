-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T10:11:01Z
-- Luau bytecode version: 14 | Luau type version: 3
local scriptParentParentParent = script.Parent.Parent.Parent
local Contexts = require(scriptParentParentParent.dependencies).SocialLuaAnalytics.Analytics.Enums.Contexts

return {
    AddFriends = Contexts.AddFriends,
    HomePage = `{Contexts.HomePage}FriendsSort`,
    HomePageProfile = `{Contexts.HomePage}Profile`,
    SocialTabProfile = `{Contexts.SocialTab}Profile`,
    ContactsList = `{Contexts.ContactImport}FindFriendsBanner`
}
