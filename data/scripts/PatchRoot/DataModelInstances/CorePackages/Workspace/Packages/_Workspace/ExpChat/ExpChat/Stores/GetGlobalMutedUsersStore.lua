-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:31:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent
local Signals = require(ExpChatParent.Signals)

if not require(ExpChat.Flags.FFlagExpChatUseChatMuteStore) then
    local createGlobalMutedUsersStore = require(script.createGlobalMutedUsersStore)
    return Signals.createComputed(createGlobalMutedUsersStore)
end

local ChatMute = require(ExpChatParent.ChatMute)

return Signals.createComputed(function()
    return {
        getMutedGlobalUsernames = ChatMute.getMutedUsernames(),
        getMutedGlobalDisplayNames = ChatMute.getMutedDisplayNames(),
        getMutedGlobalUserIds = ChatMute.getMutedUserIds(),
        muteGlobalUsername = function(username: string)
            ChatMute.mutePlayer({ username = username })
        end,
        unmuteGlobalUsername = function(username: string)
            ChatMute.unmutePlayer({ username = username })
        end,
        muteGlobalDisplayName = function(displayName: string)
            ChatMute.mutePlayer({ displayName = displayName })
        end,
        unmuteGlobalDisplayName = function(displayName: string)
            ChatMute.unmutePlayer({ displayName = displayName })
        end,
        isUsernameMuted = ChatMute.isUsernameMuted,
        isDisplayNameMuted = ChatMute.isDisplayNameMuted,
        muteGlobalUserId = function(arg1)
            ChatMute.mutePlayer({ userId = tostring(arg1) })
        end,
        unmuteGlobalUserId = function(arg1)
            ChatMute.unmutePlayer({ userId = tostring(arg1) })
        end,
        isUserIdMuted = ChatMute.isUserIdMuted
    }
end)
