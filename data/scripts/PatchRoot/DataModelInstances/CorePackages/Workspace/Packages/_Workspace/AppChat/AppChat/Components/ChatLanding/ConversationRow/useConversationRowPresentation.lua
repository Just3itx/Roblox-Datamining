-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:11:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local React = require(AppChatParent.React)
local ReactFocusNavigation = require(AppChatParent.ReactFocusNavigation)
local Signals = require(AppChatParent.Signals)
local SignalsReact = require(AppChatParent.SignalsReact)

local useLocalization = require(AppChatParent.Localization).Hooks.useLocalization

local useChatPagePadding = require(AppChat.Contexts.ChatPagePadding.useChatPagePadding)
local ChatPlacementContext = require(AppChat.Contexts.ChatPlacementContext)
local useThemeBackground = require(AppChatParent.ThemeBackground).useThemeBackground
local FFlagAppThemeHalloween2026ChatBackground = require(AppChat.Flags.FFlagAppThemeHalloween2026ChatBackground)
local useRelativeTimestampBinding = require(AppChat.Hooks.useRelativeTimestampBinding)
local useTelemetry = require(AppChat.Telemetry.useTelemetry)
local ChatLandingTelemetryLayer = require(AppChat.Telemetry.Layers.ChatLandingTelemetryLayer)
local GetConversationStore = require(AppChat.Stores.GetConversationStore)
local GetConversationViewModelStore = require(AppChat.Stores.GetConversationViewModelStore)
local FFlagEnableBlackbirdCheck = require(AppChatParent.SharedFlags).FFlagEnableBlackbirdCheck
local FFlagAppChatUseActivationOnFocus = require(AppChatParent.SharedFlags).FFlagAppChatUseActivationOnFocus
local conversationFocusActivationDelaySeconds = require(AppChat.Flags.conversationFocusActivationDelaySeconds)
local useIsRobloxSubscriber = require(AppChatParent.UserProfiles).Hooks.useIsRobloxSubscriber

local useGetOneToOneFriendIdFromConversationId = require(AppChat.Hooks.useGetOneToOneFriendIdFromConversationId)
local useActivationOnFocus = require(AppChatParent.FocusNavigationUtils).useActivationOnFocus
local useConversationRowActivation = require(script.Parent.useConversationRowActivation)
local normalizeConversationForTelemetry = require(script.Parent.normalizeConversationForTelemetry)

local function isShowingSquadButton(bool1: boolean, bool2: boolean, isSquadEnabled: boolean?): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return isSquadEnabled == true and bool1 and bool2
end

local function useConversationRowPresentation(tbl1)
    local conversationStore = GetConversationStore(false)
    local conversationViewModelStore = GetConversationViewModelStore(false)
    local var1 = React.useMemo(function()
        return {
            title = conversationViewModelStore.getTitle(tbl1.conversationId),
            subtitle = conversationViewModelStore.getSubtitle(tbl1.conversationId),
            isSubtitlePending = conversationViewModelStore.getIsSubtitlePending(tbl1.conversationId),
            hasUnreadMessages = conversationViewModelStore.getHasUnreadMessages(tbl1.conversationId),
            hasGroupUp = conversationViewModelStore.getHasGroupUp(tbl1.conversationId),
            shouldShowOSA = conversationViewModelStore.getShouldShowOSA(tbl1.conversationId),
            shouldShowU13ChatOptIn = conversationViewModelStore.getShouldShowU13ChatOptIn(tbl1.conversationId),
            conversationType = conversationViewModelStore.getConversationType(tbl1.conversationId),
            unixTime = conversationViewModelStore.getUnixTime(tbl1.conversationId),
            testId = conversationViewModelStore.getTestId(tbl1.conversationId),
            locatorTitle = conversationViewModelStore.getLocatorTitle(tbl1.conversationId)
        }
    end, { conversationViewModelStore, tbl1.conversationId })
    local var2 = React.useMemo(function()
        return Signals.createComputed(function(arg1)
            return conversationStore.getConversation(tbl1.conversationId, arg1)
        end)
    end, { conversationStore, tbl1.conversationId })
    local var3 = SignalsReact.useSignalState(var2)
    local title = SignalsReact.useSignalState(var1.title)
    local var5 = SignalsReact.useSignalState(var1.subtitle)
    local var6 = SignalsReact.useSignalState(var1.isSubtitlePending)
    local var7 = SignalsReact.useSignalState(var1.hasUnreadMessages)
    local var8 = SignalsReact.useSignalState(var1.hasGroupUp)
    local shouldShowOsa = SignalsReact.useSignalState(var1.shouldShowOSA)
    local shouldShowU13ChatOptIn = SignalsReact.useSignalState(var1.shouldShowU13ChatOptIn)
    local conversationType = SignalsReact.useSignalState(var1.conversationType)
    local var12 = SignalsReact.useSignalState(var1.unixTime)
    local testId = SignalsReact.useSignalState(var1.testId)
    local locatorTitle = SignalsReact.useSignalState(var1.locatorTitle)
    local hasConversation = title ~= nil
    local var15 = useChatPagePadding()
    local var16 = ChatPlacementContext.useChatPlacementContext()
    local bool2 = if FFlagAppThemeHalloween2026ChatBackground then useThemeBackground() ~= nil else false
    local telemetry = useTelemetry(ChatLandingTelemetryLayer.Context)
    local timestampText = useRelativeTimestampBinding(var12)
    local var19 = useLocalization({ pendingSubtitleText = "Feature.Chat.Message.MessageUnavailable" })

    local var20 = useGetOneToOneFriendIdFromConversationId(tbl1.conversationId)
    local var21 = useIsRobloxSubscriber

    if not FFlagEnableBlackbirdCheck then
        var20 = nil
    end

    local showSubscriptionBadge = var21(var20)

    local var23 = useConversationRowActivation({
        conversationId = tbl1.conversationId,
        hasConversation = hasConversation,
        shouldShowOSA = shouldShowOsa,
        shouldShowU13ChatOptIn = shouldShowU13ChatOptIn,
        conversationType = conversationType,
        onActivated = tbl1.onActivated,
        onSquadJoinButtonActivated = tbl1.onSquadJoinButtonActivated,
        fireClickEvent = tbl1.fireClickEvent,
        telemetry = telemetry
    })

    local showSquadButton = isShowingSquadButton(hasConversation, var8, tbl1.isSquadEnabled)
    local showTimestamp = not showSquadButton
    local showUnread = hasConversation and var7 and not var6
    local subtitleText = if hasConversation and var6 then var19.pendingSubtitleText elseif hasConversation then var5 else ""
    local rowRef = React.useRef(nil)
    local onRowActivated = React.useCallback(function()
        var23.onActivated()
    end, { var23.onActivated })

    local bool5 = tbl1.isWideMode == true

    if FFlagAppChatUseActivationOnFocus then
        local var28 = React.useCallback(function()
            return tbl1.conversationId
        end, { tbl1.conversationId })
        useActivationOnFocus(bool5, rowRef, onRowActivated, nil, var28, nil, conversationFocusActivationDelaySeconds)
    else
        local var28 = React.useContext(ReactFocusNavigation.FocusNavigationContext)
        React.useEffect(function()
            if not (bool5 and var28) then
                return function() end
            end
            local var29 = var28.focusedGuiObject:subscribe(function(current)
                if rowRef.current and current == rowRef.current then
                    onRowActivated()
                end
            end)
            return function()
                var29:unsubscribe()
            end
        end, { onRowActivated, bool5, var28 })
    end

    local var28 = React.useRef(tbl1.fireImpressionEvent)
    local var29 = React.useRef(nil)
    var28.current = tbl1.fireImpressionEvent

    React.useEffect(function()
        if var28.current == nil or not hasConversation or var29.current == tbl1.conversationId then
            return
        end

        local conversation = conversationStore.getConversation(tbl1.conversationId, false)
        if conversation == nil then
            return
        end
        var29.current = tbl1.conversationId
        var28.current(normalizeConversationForTelemetry(conversation))
    end, { tbl1.conversationId, hasConversation, conversationStore })

    return {
        hasConversation = hasConversation,
        conversationId = tbl1.conversationId,
        title = title or "",
        testId = testId,
        locatorTitle = locatorTitle,
        entryHeight = tbl1.entryHeight or 64,
        pagePaddingLeft = var15.left,
        pagePaddingRight = var15.right,
        timestampText = timestampText,
        subtitleText = subtitleText,
        showSubscriptionBadge = showSubscriptionBadge,
        showSquadButton = showSquadButton,
        showTimestamp = showTimestamp,
        showUnread = showUnread,
        showBackground = if tbl1.showBackground ~= nil then tbl1.showBackground else not (ChatPlacementContext.isPlacementInExperience(var16.chatPlacement) or bool2),
        squadLocation = var16.chatPlacement,
        participants = if var3 == nil then nil else var3.participants,
        rowRef = rowRef,
        onRowActivated = onRowActivated,
        onSquadActivated = var23.onSquadActivated
    }
end

return useConversationRowPresentation
