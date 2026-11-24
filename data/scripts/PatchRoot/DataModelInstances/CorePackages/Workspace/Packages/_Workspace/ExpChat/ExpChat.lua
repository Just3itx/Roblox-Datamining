-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T07:10:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local scriptParent = script.Parent
local ActionBindableEvent = require(scriptParent.ExpChatShared).ActionBindableEvent
local useExpChatMessagesReducerSlice = require(script.useExpChatMessagesReducerSlice)

return {
    Events = require(script.Events),
    mountClientApp = require(script.mountClientApp),
    listenToDispatch = require(script.listenToDispatch)(ActionBindableEvent),
    GlobalFlags = require(script.GlobalFlags),
    getExperienceChatVisualConfig = require(script.getExperienceChatVisualConfig),
    Stores = require(script.Stores),
    Hooks = { useExpChatMessagesReducerSlice = useExpChatMessagesReducerSlice },
    isUserChatEnabled = require(script.isUserChatEnabled),
    requestSelectTab = require(script.ExternalNavigation.requestSelectTab),
    requestSelectFriendsTab = require(script.ExternalNavigation.requestSelectFriendsTab),
    isHistoricalMessage = require(script.isHistoricalMessage),
    shouldSkipHistoricalMessage = require(script.shouldSkipHistoricalMessage),
    shouldSuppressUnreadForTabMetadata = require(script.shouldSuppressUnreadForTabMetadata),
    ExpChatPerfTracker = require(scriptParent.ChatUIPrimitives).Telemetry.ExpChatPerfTracker,
    ["jest.config"] = script["jest.config"],
    ["jest.bench.config"] = script["jest.bench.config"],
    ["mockDataModel-jest.config"] = script["mockDataModel-jest.config"]
}
