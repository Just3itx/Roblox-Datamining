-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T16:50:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialBlockingModal = script:FindFirstAncestor("SocialBlockingModal")
local SocialBlockingModalParent = SocialBlockingModal.Parent

local Rodux = require(SocialBlockingModalParent.Rodux)

local myRoduxNetworking = require(SocialBlockingModal.Networking.myRoduxNetworking)

return function()
    return Rodux.combineReducers({ NetworkStatus = myRoduxNetworking.installReducer() })
end
