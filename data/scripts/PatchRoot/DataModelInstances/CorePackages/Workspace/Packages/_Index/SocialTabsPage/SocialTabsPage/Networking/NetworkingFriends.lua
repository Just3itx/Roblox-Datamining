-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T21:10:47Z
-- Luau bytecode version: 14 | Luau type version: 3
local SocialTabsPage = script:FindFirstAncestor("SocialTabsPage")
local SocialTabsPageParent = SocialTabsPage.Parent

local FriendsNetworking = require(SocialTabsPageParent.FriendsNetworking)
local myRoduxNetworking = require(SocialTabsPage.Networking.myRoduxNetworking)

return FriendsNetworking.config({ roduxNetworking = myRoduxNetworking })
