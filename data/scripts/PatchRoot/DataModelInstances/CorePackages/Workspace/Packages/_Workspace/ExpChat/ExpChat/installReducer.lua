-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T08:51:07Z
-- Luau bytecode version: 14 | Luau type version: 3
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent
local Rodux = require(ExpChatParent.Rodux)
local ExpChatShared = require(ExpChatParent.ExpChatShared)

local getEnableChatInputBarConfigurationAutocompleteEnabled = require(ExpChat.Flags.getEnableChatInputBarConfigurationAutocompleteEnabled)
local getFFlagUnreduxLastInputTypeChanged = require(ExpChat.Flags.getFFlagUnreduxLastInputTypeChanged)
local FFlagEnableVerifiedBadgeStore = require(ExpChatParent.SharedFlags).FFlagEnableVerifiedBadgeStore
local FFlagExpChatUseChannelTabsStore = require(ExpChatParent.SharedFlags).FFlagExpChatUseChannelTabsStore

return Rodux.combineReducers({
    ChatIntervention = require(script.ChatInterventionReducer),
    Messages = require(script.Messages),
    MutedUsers = ExpChatShared.Reducers.MutedUsers,
    VerifiedUsers = if FFlagEnableVerifiedBadgeStore then nil else require(script.VerifiedUsers),
    Players = ExpChatShared.Reducers.Players,
    LocalCharacter = ExpChatShared.Reducers.LocalCharacter,
    TextChannels = ExpChatShared.Reducers.TextChannels,
    ChatVisibility = require(script.ChatVisibility),
    CanLocalUserChat = require(script.CanLocalUserChat),
    LocalTeam = ExpChatShared.Reducers.LocalTeam,
    isUsingTouch = if getFFlagUnreduxLastInputTypeChanged() then nil else require(script.isUsingTouch),
    isUsingGamepad = if getFFlagUnreduxLastInputTypeChanged() then nil else require(script.isUsingGamepad),
    shouldFocusChatInputBar = require(script.shouldFocusChatInputBar),
    Voice = require(script.Voice),
    BubbleChatSettings = require(script.BubbleChat),
    LegacyBubbleChatSettings = require(script.BubbleChat.LegacyChatReducer),
    ChatLayout = require(script.ChatLayout),
    AutoCastCommands = ExpChatShared.Reducers.AutoCastCommands,
    Adornees = require(script.Adornees),
    ClientSettings = require(script.ClientSettings),
    AutocompleteDropdown = getEnableChatInputBarConfigurationAutocompleteEnabled() and require(script.AutocompleteDropdown) or nil,
    ChannelTabs = if FFlagExpChatUseChannelTabsStore then nil else require(script.ChannelTabs),
    ReverseNudgeToxicUsers = require(script.ReverseNudgeToxicUsers)
})
