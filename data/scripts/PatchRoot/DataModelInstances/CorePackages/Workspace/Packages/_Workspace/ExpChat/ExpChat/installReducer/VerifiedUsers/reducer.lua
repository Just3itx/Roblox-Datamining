-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:01:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChatParent = script:FindFirstAncestor("ExpChat").Parent
local Rodux = require(ExpChatParent.Rodux)
local Dictionary = require(ExpChatParent.llama).Dictionary
local Actions = require(ExpChatParent.ExpChatShared).Actions
local PlayerAdded = Actions.PlayerAdded
local PlayerRemoved = Actions.PlayerRemoved

local createReducer = Rodux.createReducer
local tbl1 = {}
tbl1[PlayerAdded.name] = function(tbl2, arg1)
    if not arg1.hasVerifiedBadge then
        return tbl2
    end
    return Dictionary.join(tbl2, { [arg1.userId] = arg1.hasVerifiedBadge })
end

tbl1[PlayerRemoved.name] = function(tbl2, arg1)
    if tbl2[arg1.userId] == nil then
        return tbl2
    end
    return Dictionary.removeKey(tbl2, arg1.userId)
end

return createReducer({}, tbl1)
