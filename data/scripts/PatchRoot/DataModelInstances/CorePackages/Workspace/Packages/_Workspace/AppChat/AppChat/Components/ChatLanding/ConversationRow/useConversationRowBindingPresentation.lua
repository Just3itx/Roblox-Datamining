-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:11:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local React = require(AppChatParent.React)
local ReactFocusNavigation = require(AppChatParent.ReactFocusNavigation)
local Signals = require(AppChatParent.Signals)
local SignalsReact = require(AppChatParent.SignalsReact)
local UserProfiles = require(AppChatParent.UserProfiles)

local useLocalization = require(AppChatParent.Localization).Hooks.useLocalization

local useChatPagePadding = require(AppChat.Contexts.ChatPagePadding.useChatPagePadding)
local ChatPlacementContext = require(AppChat.Contexts.ChatPlacementContext)
local useThemeBackground = require(AppChatParent.ThemeBackground).useThemeBackground
local FFlagAppThemeHalloween2026ChatBackground = require(AppChat.Flags.FFlagAppThemeHalloween2026ChatBackground)
local useTelemetry = require(AppChat.Telemetry.useTelemetry)
local ChatLandingTelemetryLayer = require(AppChat.Telemetry.Layers.ChatLandingTelemetryLayer)
local GetConversationStore = require(AppChat.Stores.GetConversationStore)
local GetConversationViewModelStore = require(AppChat.Stores.GetConversationViewModelStore)
local FFlagEnableBlackbirdCheck = require(AppChatParent.SharedFlags).FFlagEnableBlackbirdCheck
local FFlagAppChatUseActivationOnFocus = require(AppChatParent.SharedFlags).FFlagAppChatUseActivationOnFocus
local conversationFocusActivationDelaySeconds = require(AppChat.Flags.conversationFocusActivationDelaySeconds)
local FFlagDebugAppChatEnableDomLocators = require(AppChat.Flags.FFlagDebugAppChatEnableDomLocators)
local FFlagAppChatUseBindingConversationFacePile = require(AppChat.Flags.FFlagAppChatUseBindingConversationFacePile)

local getOtherParticipants = require(AppChat.Conversations.getOtherParticipants)
local useActivationOnFocus = require(AppChatParent.FocusNavigationUtils).useActivationOnFocus
local useConversationRowActivation = require(script.Parent.useConversationRowActivation)
local useRelativeTimestampSignalBinding = require(script.Parent.useRelativeTimestampSignalBinding)
local normalizeConversationForTelemetry = require(script.Parent.normalizeConversationForTelemetry)

local function useSubscriptionBadgeVisibility(itemSignal, arg1)
    local var1, var2 = React.useBinding(false)
    local var3 = UserProfiles.Stores.UserProfileStore.get()

    React.useLayoutEffect(function()
        if not FFlagEnableBlackbirdCheck or not FFlagAppChatUseBindingConversationFacePile then
            return
        end

        local var4 = nil
        local var5 = nil
        local bool1 = false

        return Signals.createEffect(function(arg2)
            local var6 = itemSignal(arg2)
            local conversation = arg1.getConversation(var6.id, arg2)
            local var7 = var6.presentationSignal(arg2)
            local otherParticipants = getOtherParticipants(conversation, var7.localUserId)
            local var8 = if conversation == nil or conversation.type ~= "one_to_one" or #otherParticipants ~= 1 then nil else tostring(otherParticipants[1])

            if var8 ~= var4 then
                var4 = var8
                var5 = if var8 == nil then nil else var3.fetchNamesByUserIds({ var8 })
            end

            local bool2 = false
            if var5 ~= nil then
                local success, result = pcall(var5, arg2)
                if success and result.status == "success" and #result.data > 0 then
                    local var9 = result.data[1]
                    if var9.getHasRobloxSubscription == nil then
                        bool2 = false
                    else
                        bool2 = var9.getHasRobloxSubscription(arg2) == true
                    end
                end
            end
            if bool2 ~= bool1 then
                bool1 = bool2
                var2(bool2)
            end
        end)
    end, {
        arg1,
        itemSignal,
        var2,
        var3
    })
    return var1
end

local function useConversationRowBindingPresentation(tbl1)
    local conversationStore = GetConversationStore(false)
    local conversationViewModelStore = GetConversationViewModelStore(false)
    local pendingSubtitleText = useLocalization({ pendingSubtitleText = "Feature.Chat.Message.MessageUnavailable" }).pendingSubtitleText

    local var1 = React.useMemo(function()
        local function getConversationId(arg1) -- Luacid: Inlined by compiler; 6 call sites recovered
            return tbl1.itemSignal(arg1).id
        end

        return {
            conversationId = Signals.createComputed(getConversationId),
            presentation = Signals.createComputed(function(arg1)
                return tbl1.itemSignal(arg1).presentationSignal(arg1)
            end),
            hasConversation = Signals.createComputed(function(arg1): boolean
                return conversationViewModelStore.getTitle((getConversationId(arg1)))(arg1) ~= nil
            end),
            shouldShowOSA = Signals.createComputed(function(arg1)
                return conversationViewModelStore.getShouldShowOSA((getConversationId(arg1)))(arg1)
            end),
            shouldShowU13ChatOptIn = Signals.createComputed(function(arg1)
                return conversationViewModelStore.getShouldShowU13ChatOptIn((getConversationId(arg1)))(arg1)
            end),
            conversationType = Signals.createComputed(function(arg1)
                return conversationViewModelStore.getConversationType((getConversationId(arg1)))(arg1)
            end),
            testId = Signals.createComputed(function(arg1)
                if FFlagDebugAppChatEnableDomLocators then
                    return (conversationViewModelStore.getTestId((getConversationId(arg1)))(arg1))
                end

                return nil
            end),
            locatorTitle = Signals.createComputed(function(arg1)
                if FFlagDebugAppChatEnableDomLocators then
                    return (conversationViewModelStore.getLocatorTitle((getConversationId(arg1)))(arg1))
                end

                return nil
            end),
            showSquadButton = Signals.createComputed(function(arg1): boolean
                local var1 = tbl1.itemSignal(arg1)

                return var1.presentationSignal(arg1).isSquadEnabled == true
                    and conversationViewModelStore.getTitle(var1.id)(arg1) ~= nil
                    and conversationViewModelStore.getHasGroupUp(var1.id)(arg1) == true
            end)
        }
    end, { conversationViewModelStore, tbl1.itemSignal })

    local var2 = SignalsReact.useSignalState(var1.presentation)
    local hasConversation = SignalsReact.useSignalState(var1.hasConversation)
    local shouldShowOsa = SignalsReact.useSignalState(var1.shouldShowOSA)
    local shouldShowU13ChatOptIn = SignalsReact.useSignalState(var1.shouldShowU13ChatOptIn)
    local conversationType = SignalsReact.useSignalState(var1.conversationType)
    local testId = SignalsReact.useSignalState(var1.testId)
    local locatorTitle = SignalsReact.useSignalState(var1.locatorTitle)
    local showSquadButton = SignalsReact.useSignalState(var1.showSquadButton)

    local var10 = React.useCallback(function(arg1, arg2)
        return conversationViewModelStore.getTitle(arg1.id)(arg2) or ""
    end, { conversationViewModelStore })
    local var11 = React.useCallback(function(arg1, arg2)
        local title = conversationViewModelStore.getTitle(arg1.id)
        local isSubtitlePending = conversationViewModelStore.getIsSubtitlePending(arg1.id)

        if title(arg2) == nil then
            return ""
        end

        if isSubtitlePending(arg2) then
            return pendingSubtitleText
        end

        return conversationViewModelStore.getSubtitle(arg1.id)(arg2) or ""
    end, { conversationViewModelStore, pendingSubtitleText })
    local var12 = React.useCallback(function(arg1, arg2): boolean
        return not (conversationViewModelStore.getTitle(arg1.id)(arg2) == nil
            or conversationViewModelStore.getHasUnreadMessages(arg1.id)(arg2) ~= true)
            and not conversationViewModelStore.getIsSubtitlePending(arg1.id)(arg2)
    end, { conversationViewModelStore })
    local var13 = React.useCallback(function(arg1, arg2)
        return conversationViewModelStore.getUnixTime(arg1.id)(arg2)
    end, { conversationViewModelStore })
    local var14 = React.useCallback(function(arg1)
        return arg1.id
    end, {})
    local title = SignalsReact.useSignalBinding(function(arg1)
        return var10(tbl1.itemSignal(arg1), arg1)
    end)
    local subtitleText = SignalsReact.useSignalBinding(function(arg1)
        return var11(tbl1.itemSignal(arg1), arg1)
    end)
    local showUnread = SignalsReact.useSignalBinding(function(arg1)
        return var12(tbl1.itemSignal(arg1), arg1)
    end)
    local timestampText = useRelativeTimestampSignalBinding(tbl1.itemSignal, var13)
    local showTimestamp = not showSquadButton
    local showSubscriptionBadge = useSubscriptionBadgeVisibility(tbl1.itemSignal, conversationStore)
    local var20 = SignalsReact.useSignalBinding(function(arg1)
        return var14(tbl1.itemSignal(arg1))
    end)

    local var21 = useChatPagePadding()
    local var22 = ChatPlacementContext.useChatPlacementContext()
    local bool2 = if FFlagAppThemeHalloween2026ChatBackground then useThemeBackground() ~= nil else false
    local telemetry = useTelemetry(ChatLandingTelemetryLayer.Context)
    local getCurrentOptions = React.useCallback(function()
        local var24 = tbl1.itemSignal(false)
        local id = var24.id
        local var25 = var24.presentationSignal(false)
        return {
            conversationId = id,
            hasConversation = conversationViewModelStore.getTitle(id)(false) ~= nil,
            shouldShowOSA = conversationViewModelStore.getShouldShowOSA(id)(false),
            shouldShowU13ChatOptIn = conversationViewModelStore.getShouldShowU13ChatOptIn(id)(false),
            conversationType = conversationViewModelStore.getConversationType(id)(false),
            onActivated = var25.onActivated,
            onSquadJoinButtonActivated = var25.onSquadJoinButtonActivated,
            fireClickEvent = var25.fireClickEvent
        }
    end, { conversationViewModelStore, tbl1.itemSignal })

    local var25 = useConversationRowActivation({
        conversationId = var1.conversationId(false),
        hasConversation = hasConversation,
        shouldShowOSA = shouldShowOsa,
        shouldShowU13ChatOptIn = shouldShowU13ChatOptIn,
        conversationType = conversationType,
        onActivated = var2.onActivated,
        onSquadJoinButtonActivated = var2.onSquadJoinButtonActivated,
        fireClickEvent = var2.fireClickEvent,
        telemetry = telemetry,
        getCurrentOptions = getCurrentOptions
    })

    local rowRef = React.useRef(nil)
    local onActivated = var25.onActivated
    local bool3 = var2.isWideMode == true
    if FFlagAppChatUseActivationOnFocus then
        local var27 = React.useCallback(function()
            return tbl1.itemSignal(false).id
        end, { tbl1.itemSignal })
        useActivationOnFocus(bool3, rowRef, onActivated, nil, var27, nil, conversationFocusActivationDelaySeconds)
    else
        local var27 = React.useContext(ReactFocusNavigation.FocusNavigationContext)
        React.useEffect(function()
            if not (bool3 and var27) then
                return function() end
            end
            local var28 = var27.focusedGuiObject:subscribe(function(current)
                if rowRef.current and current == rowRef.current then
                    onActivated()
                end
            end)
            return function()
                var28:unsubscribe()
            end
        end, {
            onActivated,
            bool3,
            var27,
            rowRef
        })
    end
    local var27 = React.useRef(nil)
    React.useEffect(function()
        return Signals.createEffect(function(arg1)
            local var28 = tbl1.itemSignal(arg1)
            local fireImpressionEvent = var28.presentationSignal(arg1).fireImpressionEvent
            if fireImpressionEvent == nil or var27.current == var28.id then
                return
            end

            local conversation = conversationStore.getConversation(var28.id, arg1)
            if conversation == nil then
                return
            end

            var27.current = var28.id
            fireImpressionEvent(normalizeConversationForTelemetry(conversation))
        end)
    end, { conversationStore, tbl1.itemSignal })

    local tbl2 = {
        hasConversation = hasConversation,
        title = title,
        testId = testId,
        locatorTitle = locatorTitle,
        entryHeight = var2.entryHeight or 64,
        pagePaddingLeft = var21.left,
        pagePaddingRight = var21.right,
        timestampText = timestampText,
        subtitleText = subtitleText,
        showSubscriptionBadge = showSubscriptionBadge,
        showSquadButton = showSquadButton,
        showTimestamp = showTimestamp,
        showUnread = showUnread,
        squadLocation = var22.chatPlacement,
        rowRef = rowRef,
        onRowActivated = onActivated,
        onSquadActivated = var25.onSquadActivated,
        showBackground = if var2.showBackground ~= nil then var2.showBackground else not (ChatPlacementContext.isPlacementInExperience(var22.chatPlacement) or bool2),
        debugCellValue = 0
    }

    if not var2.isDebugEnabled then
        var20 = nil
    end

    tbl2.debugCellValue = var20
    return tbl2
end

return useConversationRowBindingPresentation
