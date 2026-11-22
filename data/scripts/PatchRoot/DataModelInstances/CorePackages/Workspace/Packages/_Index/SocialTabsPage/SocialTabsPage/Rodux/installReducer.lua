-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T21:10:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialTabsPage = script:FindFirstAncestor("SocialTabsPage")
local SocialTabsPageParent = SocialTabsPage.Parent

local Rodux = require(SocialTabsPageParent.Rodux)
local myRoduxNetworking = require(SocialTabsPage.Networking.myRoduxNetworking)

return function()
    return Rodux.combineReducers({ NetworkStatus = myRoduxNetworking.installReducer() })
end
