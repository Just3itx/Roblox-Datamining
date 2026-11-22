-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T21:01:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialTabsPage = script:FindFirstAncestor("SocialTabsPage")
local SocialTabsPageParent = SocialTabsPage.Parent

local FriendsNetworking = require(SocialTabsPageParent.FriendsNetworking)
local SocialCommon = require(SocialTabsPageParent.SocialCommon)
local RobloxAppEnums = require(SocialTabsPageParent.RobloxAppEnums)
local UserList = require(SocialTabsPageParent.UserList)

local AppPage = RobloxAppEnums.AppPage
local CtaSurfaces = UserList.Enums.CtaSurfaces
local ClientCtaActions = UserList.Enums.ClientCtaActions
local FriendshipOriginSourceType = FriendsNetworking.Enums.FriendshipOriginSourceType
local ChatEntryPointNames = SocialCommon.Enums.ChatEntryPointNames
local FFlagSocialTabsSelfRowViewCta = require(SocialTabsPage.Flags.FFlagSocialTabsSelfRowViewCta)
local FFlagSocialTabsViewOnlyRowCta = require(SocialTabsPage.Flags.FFlagSocialTabsViewOnlyRowCta)

local tbl1 = {
    friendshipOriginSourceType = FriendshipOriginSourceType.SocialTabsPage.rawValue(),
    chatEntryPoint = ChatEntryPointNames.SocialTabsPage,
    primaryCtaMinWidth = 64,
    primaryCtaMaxWidth = 90,
    clientActions = FFlagSocialTabsViewOnlyRowCta and { ClientCtaActions.ViewProfile } or nil,
    showSelfProfileCta = if FFlagSocialTabsSelfRowViewCta then true else nil
}

local function forTab(subpage: string) -- Luacid: Inlined by compiler; 2 call sites recovered
    local var1 = table.clone(tbl1)
    var1.analytics = {
        surface = CtaSurfaces.SocialTabsPage,
        subpage = subpage
    }
    return var1
end

local RowSelection = {
    friendshipOriginSourceType = tbl1.friendshipOriginSourceType
}

return {
    Friends = forTab(AppPage.SocialTabsFriends),
    Mutuals = forTab(AppPage.SocialTabsMutuals),
    RowSelection = RowSelection
}
