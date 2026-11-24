-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:01:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent
local Rodux = require(ExpChatParent.Rodux)

local Actions = ExpChat.Actions
local VoiceUIVisibilityChanged = require(Actions.VoiceUIVisibilityChanged)

local createReducer = Rodux.createReducer
local tbl1 = {}
tbl1[VoiceUIVisibilityChanged.name] = function(_: boolean, arg1)
    return arg1.visible
end

return createReducer(false, tbl1)
