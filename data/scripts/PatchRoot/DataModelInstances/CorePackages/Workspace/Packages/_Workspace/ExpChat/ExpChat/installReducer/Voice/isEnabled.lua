-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:01:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent
local Rodux = require(ExpChatParent.Rodux)

local Actions = ExpChat.Actions
local VoiceEnabledChanged = require(Actions.VoiceEnabledChanged)

local createReducer = Rodux.createReducer
local tbl1 = {}
tbl1[VoiceEnabledChanged.name] = function(_: boolean, arg1)
    return arg1.enabled
end

return createReducer(false, tbl1)
