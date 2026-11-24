-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T10:31:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChatShared = script:FindFirstAncestor("ExpChatShared")
local ExpChatSharedParent = ExpChatShared.Parent
local Rodux = require(ExpChatSharedParent.Rodux)

local LocalCharacterLoaded = require(ExpChatShared.Actions.LocalCharacterLoaded)

local createReducer = Rodux.createReducer
local tbl1 = {}
tbl1[LocalCharacterLoaded.name] = function(_, arg1)
    return arg1.character
end

return createReducer(nil, tbl1)
