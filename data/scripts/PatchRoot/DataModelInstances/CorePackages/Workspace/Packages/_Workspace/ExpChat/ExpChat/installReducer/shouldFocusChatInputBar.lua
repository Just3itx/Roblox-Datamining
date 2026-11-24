-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:01:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent
local Rodux = require(ExpChatParent.Rodux)
local var1 = require(ExpChatParent.ExpChatShared).Logger:new("ExpChat/Reducers/" .. script.Name)

local Actions = ExpChat.Actions
local AvatarContextMenuWhisperSelected = require(Actions.AvatarContextMenuWhisperSelected)
local PresetTrayKeyboardSelected = require(Actions.PresetTrayKeyboardSelected)

local createReducer = Rodux.createReducer
local tbl1 = {}
tbl1[AvatarContextMenuWhisperSelected.name] = function(num1: number, _): number
    var1:trace("AvatarContextMenuWhisperSelected dispatched")
    return num1 * -1
end

tbl1[PresetTrayKeyboardSelected.name] = function(num1: number, _): number
    var1:trace("PresetTrayKeyboardSelected dispatched")
    return num1 * -1
end

return createReducer(1, tbl1)
