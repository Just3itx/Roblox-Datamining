-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:00:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent
local Rodux = require(ExpChatParent.Rodux)
local ClientAppLoaded = require(ExpChatParent.ExpChatShared).Actions.ClientAppLoaded
local LastInputTypeChanged = require(ExpChat.Actions.LastInputTypeChanged)

local createReducer = Rodux.createReducer
local tbl1 = {}
tbl1[ClientAppLoaded.name] = function(_: boolean, arg1)
    return arg1.isTouchEnabled
end

tbl1[LastInputTypeChanged.name] = function(bool1: boolean, arg1): boolean
    return arg1.lastInputTypeUsed == Enum.UserInputType.Touch
        or not (arg1.lastInputTypeUsed == Enum.UserInputType.Keyboard) and bool1
end

return createReducer(false, tbl1)
