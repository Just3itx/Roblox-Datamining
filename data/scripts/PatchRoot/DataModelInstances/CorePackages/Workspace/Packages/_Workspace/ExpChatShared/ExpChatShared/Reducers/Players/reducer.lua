-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T10:31:15Z
-- Luau bytecode version: 14 | Luau type version: 3
local ExpChatShared = script:FindFirstAncestor("ExpChatShared")
local ExpChatSharedParent = ExpChatShared.Parent
local Flags = ExpChatShared.Flags

local Rodux = require(ExpChatSharedParent.Rodux)

local getFFlagUseCharacterStore = require(Flags.getFFlagUseCharacterStore)

return Rodux.combineReducers({
    byUserId = require(script.Parent.byUserId),
    byDisplayName = require(script.Parent.byDisplayName),
    byUsername = require(script.Parent.byUsername),
    charactersByUserId = if getFFlagUseCharacterStore() then nil else require(script.Parent.charactersByUserId)
})
