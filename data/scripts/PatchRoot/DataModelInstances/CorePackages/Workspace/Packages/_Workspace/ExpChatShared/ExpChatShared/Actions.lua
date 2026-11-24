-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T10:10:53Z
-- Luau bytecode version: 14 | Luau type version: 3
local CharacterAdded = require(script.CharacterAdded)
local ChatInputBarActivatedTeamMode = require(script.ChatInputBarActivatedTeamMode)
local ChatInputBarActivatedWhisperMode = require(script.ChatInputBarActivatedWhisperMode)
local ChatInputBarResetTargetChannel = require(script.ChatInputBarResetTargetChannel)
local ChatWindowMessagesCleared = require(script.ChatWindowMessagesCleared)
local ClientAppLoaded = require(script.ClientAppLoaded)
local CommandAliasChanged = require(script.CommandAliasChanged)
local FriendsChatChannelSelected = require(script.FriendsChatChannelSelected)
local LocalCharacterLoaded = require(script.LocalCharacterLoaded)
local LocalTeamChanged = require(script.LocalTeamChanged)
local LocalTextChannelParticipantRemoved = require(script.LocalTextChannelParticipantRemoved)
local PlayerAdded = require(script.PlayerAdded)
local PlayerRemoved = require(script.PlayerRemoved)
local TargetTextChannelPropertyChanged = require(script.TargetTextChannelPropertyChanged)
local TextChatChannelSelected = require(script.TextChatChannelSelected)
local UniverseChatChannelSelected = require(script.UniverseChatChannelSelected)
return {
    CharacterAdded = CharacterAdded,
    ChatInputBarActivatedTeamMode = ChatInputBarActivatedTeamMode,
    ChatInputBarActivatedWhisperMode = ChatInputBarActivatedWhisperMode,
    ChatInputBarResetTargetChannel = ChatInputBarResetTargetChannel,
    ChatWindowMessagesCleared = ChatWindowMessagesCleared,
    ClientAppLoaded = ClientAppLoaded,
    CommandAliasChanged = CommandAliasChanged,
    FriendsChatChannelSelected = FriendsChatChannelSelected,
    LocalCharacterLoaded = LocalCharacterLoaded,
    LocalTeamChanged = LocalTeamChanged,
    LocalTextChannelParticipantRemoved = LocalTextChannelParticipantRemoved,
    PlayerAdded = PlayerAdded,
    PlayerRemoved = PlayerRemoved,
    TargetTextChannelPropertyChanged = TargetTextChannelPropertyChanged,
    TextChatChannelSelected = TextChatChannelSelected,
    TextChannelCreated = require(script.TextChannelCreated),
    TextChannelRemoved = require(script.TextChannelRemoved),
    UniverseChatChannelSelected = UniverseChatChannelSelected,
    UserMuted = require(script.UserMuted),
    UserUnmuted = require(script.UserUnmuted)
}
