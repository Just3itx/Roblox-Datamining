-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T02:21:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserList = script:FindFirstAncestor("UserList")
local UserListParent = UserList.Parent

local Rodux = require(UserListParent.Rodux)
local myRoduxNetworking = require(UserList.Networking.myRoduxNetworking)

return function()
    return Rodux.combineReducers({ NetworkStatus = myRoduxNetworking.installReducer() })
end
