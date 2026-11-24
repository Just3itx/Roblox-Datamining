-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T10:31:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChatShared = script:FindFirstAncestor("ExpChatShared")
local ExpChatSharedParent = ExpChatShared.Parent
local Rodux = require(ExpChatSharedParent.Rodux)

local ClientAppLoaded = require(ExpChatShared.Actions.ClientAppLoaded)
local LocalTeamChanged = require(ExpChatShared.Actions.LocalTeamChanged)

local createReducer = Rodux.createReducer
local tbl1 = {}
tbl1[LocalTeamChanged.name] = function(_, arg1)
    return arg1.team
end

tbl1[ClientAppLoaded.name] = function(_, arg1)
    return arg1.team
end

return createReducer(nil, tbl1)
