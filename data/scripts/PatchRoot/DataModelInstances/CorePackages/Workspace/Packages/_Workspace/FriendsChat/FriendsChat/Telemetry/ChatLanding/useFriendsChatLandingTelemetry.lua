-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T13:30:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsChat = script:FindFirstAncestor("FriendsChat")
local FriendsChatParent = FriendsChat.Parent

local React = require(FriendsChatParent.React)

local ChatLandingTelemetryEvents = require(FriendsChatParent.AppChat.ChatLandingTelemetryEvents)
local ChatLandingTelemetryLayer = require(FriendsChatParent.AppChat.ChatLandingTelemetryLayer)
local ChatLandingTelemetryState = require(FriendsChatParent.AppChat.ChatLandingTelemetryState)
local _GetConversationListStore = require(FriendsChatParent.AppChat.GetConversationListStore)
local GetFriendsChatSettingsStore = require(FriendsChatParent.AppChat.GetFriendsChatSettingsStore)
local useTelemetry = require(FriendsChatParent.AppChat.useTelemetry)

local FFlagFriendsChatLandingTelemetryFields = require(FriendsChat.Flags.FFlagFriendsChatLandingTelemetryFields)

local getChatLandingConversationInfo = require(script.Parent.getChatLandingConversationInfo)
local getChatLandingSharedCounts = require(script.Parent.getChatLandingSharedCounts)

local function getIsChatEnabled() -- Luacid: Inlined by compiler; 1 call site recovered
    return GetFriendsChatSettingsStore(false).getChatEnabled(false)
end

local function useFriendsChatLandingTelemetry(tbl1)
    local emit = useTelemetry(ChatLandingTelemetryLayer.Context).emit
    local var1 = ChatLandingTelemetryState.useSetState()

    local var2 = React.useRef(tbl1.displayedConversations)
    var2.current = tbl1.displayedConversations
    local var3 = React.useRef(tbl1.isFiltered)
    var3.current = tbl1.isFiltered
    local var4 = React.useRef(emit)
    var4.current = emit

    local var5 = React.useMemo(function()
        return getChatLandingSharedCounts(tbl1.conversations)
    end, { tbl1.conversations })

    React.useEffect(function()
        var1(function(arg1)
            local var6 = table.clone(arg1)
            var6.chatLandingListCount = var5.chatLandingListCount
            var6.pendingConversationCount = var5.pendingConversationCount
            var6.unfilteredConversationCount = var5.unfilteredConversationCount
            return var6
        end)
    end, { var5, var1 })

    React.useEffect(function()
        var4.current(ChatLandingTelemetryEvents.ScreenRendered, { isChatEnabled = getIsChatEnabled() })
    end, {})

    local emptyStateType = tbl1.emptyStateType
    React.useEffect(function()
        if FFlagFriendsChatLandingTelemetryFields and emptyStateType ~= nil then
            var4.current(ChatLandingTelemetryEvents.ChatEmptyStateScreenRendered, { emptyStateType = emptyStateType })
        end
    end, { emptyStateType })

    return {
        fireSearchActivatedEvent = React.useCallback(function()
            var4.current(ChatLandingTelemetryEvents.ChatLandingSearchBtnClicked, {})
        end, {}),
        fireConversationClickedEvent = React.useCallback(function(arg1, _, osaImpressionId: string?)
            if arg1 == nil or arg1.id == nil then
                return
            end

            local chatLandingConversationInfo = getChatLandingConversationInfo(arg1, var2.current or {}, var3.current == true)
            local var6 = table.clone(chatLandingConversationInfo)
            var6.osaImpressionId = osaImpressionId

            var4.current(ChatLandingTelemetryEvents.ConversationClicked, var6)
            var4.current(
                ChatLandingTelemetryEvents.ConversationClickedIndexStat,
                {
                    statValue = chatLandingConversationInfo.selectedIndex
                }
            )
        end, {}),
        fireConversationImpressionEvent = React.useCallback(function(arg1)
            if arg1 == nil or arg1.id == nil then
                return
            end

            local chatLandingConversationInfo = getChatLandingConversationInfo(arg1, var2.current or {}, var3.current == true)
            var4.current(ChatLandingTelemetryEvents.ConversationCellRendered, chatLandingConversationInfo)
            var4.current(
                ChatLandingTelemetryEvents.ConversationCellRenderedIndexStat,
                {
                    statValue = chatLandingConversationInfo.selectedIndex
                }
            )
        end, {})
    }
end

return useFriendsChatLandingTelemetry
