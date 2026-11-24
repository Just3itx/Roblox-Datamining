-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:31:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent
local Signals = require(ExpChatParent.Signals)
local createMessagesStore = require(script.createMessagesStore)

local FFlagExpChatUseChatMuteStore = require(ExpChat.Flags.FFlagExpChatUseChatMuteStore)

return Signals.createComputed(function()
    local getMutedGlobalUserIds = if FFlagExpChatUseChatMuteStore then require(ExpChat.Stores.GetGlobalMutedUsersStore)(false).getMutedGlobalUserIds else nil
    return createMessagesStore(getMutedGlobalUserIds)
end)
