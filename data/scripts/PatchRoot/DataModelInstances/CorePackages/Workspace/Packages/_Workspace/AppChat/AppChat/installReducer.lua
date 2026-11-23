-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:50:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent
local Rodux = require(AppChatParent.Rodux)

local FFlagAppChatPresenceStoreMigration = require(AppChat.Flags.FFlagAppChatPresenceStoreMigration)
local FFlagAppChatRemoveAliasesSlice = require(AppChat.Flags.FFlagAppChatRemoveAliasesSlice)
local FFlagAppChatRemovePlaceInfosAsync = require(AppChat.Flags.FFlagAppChatRemovePlaceInfosAsync)
local FFlagAppChatUseDataHydrationForChatTimeouts = require(AppChat.Flags.FFlagAppChatUseDataHydrationForChatTimeouts)
local FFlagAppChatUseDataHydrationForPlaceInfos = require(AppChat.Flags.FFlagAppChatUseDataHydrationForPlaceInfos)
local FFlagAppChatUseSignalsForAppLoaded = require(AppChat.Flags.FFlagAppChatUseSignalsForAppLoaded)
local FFlagAppChatUseSignalsForChatSettings = require(AppChat.Flags.FFlagAppChatUseSignalsForChatSettings)

local FFlagAppChatUseSignalsForExternalNavigationRequest = require(AppChat.Flags.FFlagAppChatUseSignalsForExternalNavigationRequest)
local FFlagAppChatUseSignalsForLastEntryPoint = require(AppChat.Flags.FFlagAppChatUseSignalsForLastEntryPoint)

return function()
    return Rodux.combineReducers({
        PlaceInfos = if FFlagAppChatUseDataHydrationForPlaceInfos then nil else require(AppChatParent.PlaceInfoRodux).Reducers.PlaceInfosReducer,
        PlaceInfosAsync = if FFlagAppChatRemovePlaceInfosAsync then nil else require(AppChatParent.PlaceInfoRodux).Reducers.PlaceInfosAsyncReducer,
        Aliases = if FFlagAppChatRemoveAliasesSlice then nil else require(script.Aliases),
        AppLoaded = if FFlagAppChatUseSignalsForAppLoaded then nil else require(AppChat.installReducer.AppLoaded),
        ChatSettings = if FFlagAppChatUseSignalsForChatSettings then nil else require(AppChat.installReducer.ChatSettings),
        ChatTimeouts = if FFlagAppChatUseDataHydrationForChatTimeouts then nil else require(AppChat.installReducer.ChatTimeouts),
        Conversations = require(AppChat.installReducer.Conversations),
        ConversationsAsync = require(AppChat.installReducer.ConversationsAsync),
        Friends = require(script.Friends),
        ExternalNavigationRequest = if FFlagAppChatUseSignalsForExternalNavigationRequest then nil else require(AppChat.installReducer.ExternalNavigationRequest),
        LastEntryPoint = if FFlagAppChatUseSignalsForLastEntryPoint then nil else require(script.LastEntryPoint),
        Modals = require(script.Modals),
        ParticipantMetadata = require(script.ParticipantMetadata),
        Presence = if FFlagAppChatPresenceStoreMigration then nil else require(script.Presence),
        networkStatus = require(AppChat.Http.RoduxNetworking).installReducer()
    })
end
