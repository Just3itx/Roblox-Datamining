-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T21:10:44Z
-- Luau bytecode version: 14 | Luau type version: 3
local SocialTabsPage = script:FindFirstAncestor("SocialTabsPage")
local SocialTabsPageParent = SocialTabsPage.Parent

local RoduxNetworking = require(SocialTabsPageParent.RoduxNetworking)
local networkImpl = require(SocialTabsPage.Networking.networkImpl)
local RODUX_KEY = require(SocialTabsPage.Common.Constants).RODUX_KEY

return RoduxNetworking.config({ keyPath = RODUX_KEY .. ".NetworkStatus", networkImpl = networkImpl })
