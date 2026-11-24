-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T08:01:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TextChatService = game:GetService("TextChatService")

local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent

local React = require(ExpChatParent.React)
local SignalsReact = require(ExpChatParent.SignalsReact)
local Dictionary = require(ExpChatParent.llama).Dictionary
local List = require(ExpChatParent.llama).List
local ExpChatShared = require(ExpChatParent.ExpChatShared)

local Config = require(ExpChat.Config)
local useInterpolatedClientSettings = require(ExpChat.ClientSettings.useInterpolatedClientSettings)

local GetChatStatusStore = require(ExpChat.Stores.GetChatStatusStore)
local GetMessagesStore = require(ExpChat.Stores.GetMessagesStore)
local GetGlobalChatTooltipStore = require(ExpChat.Stores.GetGlobalChatTooltipStore)
local GetChatTooltipStore = require(ExpChat.Stores.GetChatTooltipStore)

local UI = script:FindFirstAncestor("UI")
local ScrollingView = require(UI.ScrollingView)
local TopBanner = require(UI.TopBanner)
local GlobalChatTooltip = require(UI.GlobalChatTooltip)
local isChatRegionLocked = require(ExpChat.isChatRegionLocked)
local showChatEnabledUI = require(ExpChat.showChatEnabledUI)

local useUserExperiment = require(ExpChatParent.RoactAppExperiment).useUserExperiment
local FStringReportingIXPLayer = require(ExpChatParent.SharedFlags).FStringReportingIXPLayer
local GetFFlagEnableChatLineReporting = require(ExpChatParent.SharedFlags).GetFFlagEnableChatLineReporting
local GetFFlagMemoizeChatReportingMenu = require(ExpChatParent.SharedFlags).GetFFlagMemoizeChatReportingMenu

local getFFlagChatWindowUseCallbackOptimizations = require(ExpChat.Flags.getFFlagChatWindowUseCallbackOptimizations)
local FFlagExpChatEnableV2ChatWindow = require(ExpChat.Flags.FFlagExpChatEnableV2ChatWindow)
local FFlagExpChatPresetChatEnabled = ExpChatShared.Flags.FFlagExpChatPresetChatEnabled
local FFlagExpChatTopBannerForPresetChatAccess = require(ExpChat.Flags.FFlagExpChatTopBannerForPresetChatAccess)
local useIsARButtonVisible = require(ExpChat.useIsARButtonVisible)
local ExpChatPerfTracker = require(ExpChatParent.ChatUIPrimitives).Telemetry.ExpChatPerfTracker
local FFlagExpChatPerfTrackerTabName = require(ExpChatParent.ChatUIPrimitives).Flags.FFlagExpChatPerfTrackerTabName
local FFlagExpChatRewriteInline = require(ExpChat.Flags.FFlagExpChatRewriteInline)
local GetFFlagTextChatEnableUniverseChatTabs = ExpChatShared.Flags.GetFFlagTextChatEnableUniverseChatTabs
local FFlagExpChatUseUnifiedTooltipStore = ExpChatShared.Flags.FFlagExpChatUseUnifiedTooltipStore
local FFlagExpChatRenderHistoricalMessages = require(ExpChat.Flags.FFlagExpChatRenderHistoricalMessages)

local tbl1 = {
    LayoutOrder = 1,
    size = UDim2.fromScale(1, 1),
    messages = not FFlagExpChatEnableV2ChatWindow and {} or nil,
    transparencyValue = if GetFFlagMemoizeChatReportingMenu() then React.createBinding(Config.ChatWindowBackgroundTransparency) else Config.ChatWindowBackgroundTransparency,
    textTransparency = React.createBinding(0),
    mutedUserIds = {},
    verifiedUserIds = {},
    showTranslationButton = false
}

return (React.memo(function(arg1)
    local var1 = Dictionary.join(tbl1, arg1)
    local chatWindowSettings = var1.chatWindowSettings
    local backgroundTransparency = useInterpolatedClientSettings(chatWindowSettings).BackgroundTransparency
    local backgroundColor3 = useInterpolatedClientSettings(chatWindowSettings).BackgroundColor3
    local var2 = nil
    local var3

    if FFlagExpChatPresetChatEnabled and FFlagExpChatTopBannerForPresetChatAccess then
        var3 = useIsARButtonVisible()
    else
        local chatStatusStore = GetChatStatusStore(false)
        var2 = SignalsReact.useSignalState(chatStatusStore.getChatStatus)
        var3 = showChatEnabledUI(var2)
    end

    local var4

    if FFlagExpChatUseUnifiedTooltipStore then
        local chatTooltipStore = GetChatTooltipStore(false)
        var4 = SignalsReact.useSignalState(chatTooltipStore.getIsEligible("GlobalChatTooltip"))
    else
        local globalChatTooltipStore = GetGlobalChatTooltipStore(false)
        var4 = SignalsReact.useSignalState(globalChatTooltipStore.getIsGlobalChatTooltipEligible)
    end

    if FFlagExpChatUseUnifiedTooltipStore then
        local setIsChatWindowOpen = GetChatTooltipStore(false).setIsChatWindowOpen
        React.useEffect(function()
            setIsChatWindowOpen(var1.visible)
            return function()
                setIsChatWindowOpen(false)
            end
        end, { var1.visible, setIsChatWindowOpen })
    end

    local var5 = nil
    local var6 = nil
    if GetFFlagMemoizeChatReportingMenu() and not FFlagExpChatEnableV2ChatWindow then
        var6 = React.useRef(if FFlagExpChatEnableV2ChatWindow then nil else var1.messages)
        React.useEffect(function()
            local var7 = var6
            var7.current = if FFlagExpChatEnableV2ChatWindow then nil else var1.messages
        end, { if FFlagExpChatEnableV2ChatWindow then nil else var1.messages })

        var5 = React.useCallback(function()
            return var6.current
        end, {})
    end

    if FFlagExpChatEnableV2ChatWindow then
        var5 = React.useCallback(function()
            local messagesStore = GetMessagesStore(false)
            local tbl2 = {
                windowMessagesInOrderByTabId = messagesStore.getWindowMessagesInOrderByTabId(false),
                byMessageId = messagesStore.getByMessageId(false),
                windowMessagesInOrder = messagesStore.getWindowMessagesInOrder(false)
            }

            if not var1.isChannelBarVisible then
                return List.map(tbl2.windowMessagesInOrder, function(arg2)
                    return tbl2.byMessageId[arg2]
                end)
            elseif GetFFlagTextChatEnableUniverseChatTabs() then
                local selectedChannelName = var1.selectedChannelName

                if var1.targetTextChannel and tbl2.windowMessagesInOrderByTabId[var1.targetTextChannel.Name] then
                    selectedChannelName = var1.targetTextChannel.Name
                end
                if selectedChannelName then
                    return List.map(tbl2.windowMessagesInOrderByTabId[selectedChannelName] or {}, function(arg2)
                        return tbl2.byMessageId[arg2]
                    end)
                end

                return {}
            elseif var1.targetTextChannel then
                return List.map(tbl2.windowMessagesInOrderByTabId[var1.targetTextChannel.Name] or {}, function(arg2)
                    return tbl2.byMessageId[arg2]
                end)
            else
                return {}
            end
        end, { var1.isChannelBarVisible, var1.targetTextChannel, if GetFFlagTextChatEnableUniverseChatTabs() then var1.selectedChannelName else nil })
    end

    local var7 = if GetFFlagEnableChatLineReporting() then useUserExperiment({ FStringReportingIXPLayer }, function(arg2)
        return (arg2[FStringReportingIXPLayer] or {}).EnableChatLineReporting
    end) else false

    local var8 = React.useCallback(function(arg2, arg3)
        if type(arg3) == "number" then
            return var1.transparencyValue
        end

        return arg3:map(function(num1: number): number
            return arg2 + num1 * (1 - arg2)
        end)
    end, getFFlagChatWindowUseCallbackOptimizations() and { var1.transparencyValue } or nil)

    local onTextMessageLabelButtonActivated = React.useCallback(function(arg2)
        var1.resetTargetChannel()

        local var9 = tonumber(arg2.userId)
        if var9 then
            var1.activateWhisperMode(var9)
        end
    end, getFFlagChatWindowUseCallbackOptimizations() and { var1.resetTargetChannel, var1.activateWhisperMode } or nil)

    local selectedChannelName = var1.selectedChannelName or "UNKNOWN_TAB"
    local var10 = FFlagExpChatPerfTrackerTabName and { tabName = selectedChannelName } or nil
    React.useEffect(function()
        ExpChatPerfTracker.finish(ExpChatPerfTracker.Events.ChatWindowMountTTI, {}, var10)
        return function()
            ExpChatPerfTracker.cancelAll()
        end
    end, {})
    React.useEffect(function()
        ExpChatPerfTracker.finish(ExpChatPerfTracker.Events.ChatWindowTabSwitchTTI, { tabId = selectedChannelName }, var10)
    end, { selectedChannelName })

    local tbl2

    if FFlagExpChatEnableV2ChatWindow then
        tbl2 = {
            showTranslationButton = var1.showTranslationButton,
            chatWindowSettings = var1.chatWindowSettings,
            textTransparency = var1.textTransparency,
            onTextMessageLabelButtonActivated = onTextMessageLabelButtonActivated,
            isSpatialUIEnabled = var1.isSpatialUIEnabled,
            chatWindowTransparencyBindable = if FFlagExpChatRewriteInline then var1.transparencyValue else nil,
            visible = var1.visible,
            selectedChannelName = if GetFFlagTextChatEnableUniverseChatTabs() then var1.selectedChannelName else nil,
            historicalMessageCountSignal = if FFlagExpChatRenderHistoricalMessages then GetMessagesStore(false).getHistoricalWindowMessageCount else nil
        }
    else
        tbl2 = {}
    end

    tbl2.messageComponentsSignal = var1.messageComponentsSignal

    local var11 = var1.textTransparency:map(function(chatWindowMessageHideRootFadeThreshold: number): boolean
        return chatWindowMessageHideRootFadeThreshold < Config.ChatWindowMessageHideRootFadeThreshold
    end)

    local var12

    if var1.disableLineReporting or isChatRegionLocked() or not (var3 and var7) then
        var12 = nil
    else
        local createElement = React.createElement
        local var13 = TopBanner
        local tbl3 = {
            backgroundColor3 = backgroundColor3,
            backgroundTransparency = backgroundTransparency,
            iconTransparency = if GetFFlagMemoizeChatReportingMenu() then var1.transparencyValue else var8(backgroundTransparency, var1.transparencyValue),
            onFocus = var1.onFocus,
            onUnfocus = var1.onUnfocus,
            getMessages = 0,
            messages = 0
        }

        if not GetFFlagMemoizeChatReportingMenu() then
            var5 = nil
        end

        tbl3.getMessages = var5
        tbl3.messages = if GetFFlagMemoizeChatReportingMenu() then nil else var1.messages
        var12 = createElement(var13, tbl3)
    end

    local scrollingView = React.createElement(
        ScrollingView,
        Dictionary.join({
            size = var1.size,
            isChannelBarVisible = var1.isChannelBarVisible,
            scrollResetKey = var1.scrollResetKey,
            scrollToTopOnReset = var1.scrollToTopOnReset,
            onCanvasPositionChanged = var1.onCanvasPositionChanged,
            contentTopPadding = var1.contentTopPadding
        }, tbl2)
    )

    local createElement = React.createElement
    local str1 = "Frame"

    local tbl3 = {
        BackgroundColor3 = backgroundColor3,
        BorderSizePixel = 0,
        LayoutOrder = var1.LayoutOrder,
        Size = var1.size,
        Visible = var1.visible,
        BackgroundTransparency = if var1.suppressBackground then 1 else var8(backgroundTransparency, var1.transparencyValue),
        [React.Change.AbsoluteSize] = not getFFlagChatWindowUseCallbackOptimizations() and function(arg2)
            local chatWindowConfiguration = TextChatService:FindFirstChildOfClass("ChatWindowConfiguration")
            if chatWindowConfiguration and var1.onAbsoluteSizeChanged then
                var1.onAbsoluteSizeChanged(arg2, chatWindowConfiguration)
            end
        end or React.useCallback(function(arg2)
            local chatWindowConfiguration = TextChatService:FindFirstChildOfClass("ChatWindowConfiguration")
            if chatWindowConfiguration and var1.onAbsoluteSizeChanged then
                var1.onAbsoluteSizeChanged(arg2, chatWindowConfiguration)
            end
        end, { TextChatService, var1.onAbsoluteSizeChanged }),
        [React.Change.AbsolutePosition] = not getFFlagChatWindowUseCallbackOptimizations() and function(arg2)
            local chatWindowConfiguration = TextChatService:FindFirstChildOfClass("ChatWindowConfiguration")
            if chatWindowConfiguration and var1.onAbsoluteSizeChanged then
                var1.onAbsolutePositionChanged(arg2, chatWindowConfiguration)
            end
        end or React.useCallback(function(arg2)
            local chatWindowConfiguration = TextChatService:FindFirstChildOfClass("ChatWindowConfiguration")
            if chatWindowConfiguration and var1.onAbsoluteSizeChanged then
                var1.onAbsolutePositionChanged(arg2, chatWindowConfiguration)
            end
        end, { TextChatService, var1.onAbsolutePositionChanged })
    }

    local tbl4 = {
        hoverLayer = React.createElement("Frame", {
            BackgroundTransparency = 1,
            Size = UDim2.fromScale(1, 1),
            [React.Event.MouseEnter] = var1.onHovered,
            [React.Event.MouseLeave] = var1.onUnhovered
        }),
        uiSizeConstraint = React.createElement("UISizeConstraint", {
            MaxSize = if var1.isSpatialUIEnabled then Vector2.new(math.huge, 400) else Vector2.new(Config.ChatWindowMaxWidth, Config.ChatWindowMaxHeight)
        }),
        contentFrame = React.createElement(
            "Frame",
            {
                BackgroundTransparency = 1,
                Size = UDim2.fromScale(1, 1),
                Visible = var11
            },
            { TopBanner = var12, scrollingView = scrollingView }
        ),
        GlobalChatTooltip = if var4 then React.createElement(
            GlobalChatTooltip,
            {
                visible = var1.visible,
                targetTextChannel = var1.targetTextChannel,
                chatStatus = var2
            }
        ) else nil
    }
    return createElement(str1, tbl3, tbl4)
end))
