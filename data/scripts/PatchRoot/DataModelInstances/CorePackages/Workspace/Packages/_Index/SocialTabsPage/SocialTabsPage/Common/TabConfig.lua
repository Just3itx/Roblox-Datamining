-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T21:01:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialTabsPage = script:FindFirstAncestor("SocialTabsPage")
local SocialTabsPageParent = SocialTabsPage.Parent

local AppPage = require(SocialTabsPageParent.RobloxAppEnums).AppPage

local Friends = {
    id = AppPage.SocialTabsFriends,
    tabLabelKey = "CommonUI.Features.Label.Friends",
    getScreen = function()
        return require(SocialTabsPage.Components.TabContent.FriendsTabContent)
    end
}

local Mutuals = {
    id = AppPage.SocialTabsMutuals,
    tabLabelKey = "Feature.Friends.Mutuals",
    getScreen = function()
        return require(SocialTabsPage.Components.TabContent.MutualsTabContent)
    end
}

return {
    Friends = Friends,
    Mutuals = Mutuals,
    routeOrder = { Friends, Mutuals }
}
