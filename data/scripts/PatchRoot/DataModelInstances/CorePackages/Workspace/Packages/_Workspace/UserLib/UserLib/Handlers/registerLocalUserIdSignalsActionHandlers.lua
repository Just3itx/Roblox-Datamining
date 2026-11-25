-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T20:20:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserLib = script:FindFirstAncestor("UserLib")
local UserLibParent = UserLib.Parent

local ActionHandlers = require(UserLibParent.SignalsMiddleware).ActionHandlers
local SetLocalUserId = require(UserLib.Actions.SetLocalUserId)
local ClearUserSpecificData = require(UserLib.Actions.ClearUserSpecificData)
local LocalUserIdStore = require(UserLibParent.LocalUserIdStore).LocalUserIdStore

local function handleSetLocalUserId(tbl1): boolean
    LocalUserIdStore.setCurrentUserId(tbl1.userId)
    return false
end

local function handleClearUserSpecificData(_): boolean
    LocalUserIdStore.reset()
    return false
end

return function(arg1)
    ActionHandlers.register(arg1, SetLocalUserId.name, handleSetLocalUserId)
    ActionHandlers.register(arg1, ClearUserSpecificData.name, handleClearUserSpecificData)
end
