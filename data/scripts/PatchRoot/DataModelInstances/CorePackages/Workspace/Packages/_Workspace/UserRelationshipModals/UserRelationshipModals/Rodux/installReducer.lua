-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T21:11:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserRelationshipModals = script:FindFirstAncestor("UserRelationshipModals")
local UserRelationshipModalsParent = UserRelationshipModals.Parent

local Rodux = require(UserRelationshipModalsParent.Rodux)
local myRoduxNetworking = require(UserRelationshipModals.Networking.myRoduxNetworking)

return function()
    return Rodux.combineReducers({ NetworkStatus = myRoduxNetworking.installReducer() })
end
