-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T16:31:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsMenuParent = script:FindFirstAncestor("FriendsMenu").Parent

local UniversalAppPolicy = require(FriendsMenuParent.UniversalAppPolicy)

local function getRenameFriendsToConnectionsEnabledFriendsMenu()
    return UniversalAppPolicy.getAppFeaturePolicies().getRenameFriendsToConnections()
end

return getRenameFriendsToConnectionsEnabledFriendsMenu
