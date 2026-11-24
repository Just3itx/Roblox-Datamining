-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T13:11:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local LocalizationService = game:GetService("LocalizationService")
local Players = game:GetService("Players")
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")
local FriendsChatParent = script:FindFirstAncestor("FriendsChat").Parent

local React = require(FriendsChatParent.React)
local SignalsReact = require(FriendsChatParent.SignalsReact)
local ReactFocusNavigation = require(FriendsChatParent.ReactFocusNavigation)
local Foundation = require(FriendsChatParent.Foundation)
local EnumScreens = require(FriendsChatParent.AppChat.EnumScreens)
local GetChatModerationStatusDataHydration = require(FriendsChatParent.AppChat.GetChatModerationStatusDataHydration)
local InExperienceAppChatModal = require(FriendsChatParent.AppChat.InExperienceAppChatModal)
local IXPNavigationUtils = require(FriendsChatParent.AppChat.IXPNavigationUtils)

local LocalizationProvider = require(FriendsChatParent.Localization).LocalizationProvider
local Localization = require(FriendsChatParent.RobloxAppLocales).Localization

local useChatWindowSettings = require(FriendsChatParent.ExpChatIntegration.useChatWindowSettings)

local AppTelemetryLayer = require(FriendsChatParent.AppChat.AppTelemetryLayer)
local ChatPlacementContext = require(FriendsChatParent.AppChat.ChatPlacementContext)
local ChatSessionRefCount = require(FriendsChatParent.AppChat.ChatSessionRefCount)
local useAppChatUpdateSession = require(FriendsChatParent.AppChat.useAppChatUpdateSession)
local useGetAndSetRef = require(FriendsChatParent.AppChat.useGetAndSetRef)
local usePartyChatReactiveFeatureRestriction = require(FriendsChatParent.AppChat.usePartyChatReactiveFeatureRestriction)
local SocialCommon = require(FriendsChatParent.SocialCommon)

local FriendsChatTabName = require(script.Parent.FriendsChatTabName)
local ConversationList = require(script.Parent.ConversationList)
local FriendsChatConversationWindow = require(script.Parent.ConversationWindow.FriendsChatConversationWindow)
local GetFriendsChatNavigationStore = require(script.Parent.Stores.GetFriendsChatNavigationStore)
local GetFriendsChatRealtimeStore = require(script.Parent.Stores.GetFriendsChatRealtimeStore)
local useFriendsChatVisibilityTelemetry = require(script.Parent.Telemetry.App.useFriendsChatVisibilityTelemetry)

local FriendsChatLandingTelemetryProviders = require(script.Parent.Telemetry.ChatLanding.FriendsChatLandingTelemetryProviders)

local FriendsChatConversationTelemetryProviders = require(script.Parent.Telemetry.ChatConversation.FriendsChatConversationTelemetryProviders)

local ExpChatPerfTracker = require(FriendsChatParent.ChatUIPrimitives).Telemetry.ExpChatPerfTracker

local SharedFlags = require(FriendsChatParent.SharedFlags)
local FFlagAppChatReactiveFeatureRestrictions = SharedFlags.FFlagAppChatReactiveFeatureRestrictions
local FFlagFriendsChatConversationListFocusNav = SharedFlags.FFlagFriendsChatConversationListFocusNav

local FFlagFriendsChatFocusInputOnConversationActivated = require(script.Parent.Flags.FFlagFriendsChatFocusInputOnConversationActivated)
local FFlagFriendsChatIxpScreenExposure = require(script.Parent.Flags.FFlagFriendsChatIxpScreenExposure)
local FStringFriendsChatLandingPageIxpLayer = require(script.Parent.Flags.FStringFriendsChatLandingPageIxpLayer)

local FStringFriendsChatConversationPageIxpLayer = require(script.Parent.Flags.FStringFriendsChatConversationPageIxpLayer)
local FFlagFriendsChatIxpParallelScreenLayers = require(script.Parent.Flags.FFlagFriendsChatIxpParallelScreenLayers)

local FStringFriendsChatLandingConversationRowsIxpLayer = require(script.Parent.Flags.FStringFriendsChatLandingConversationRowsIxpLayer)

local FStringFriendsChatLandingConversationListIxpLayer = require(script.Parent.Flags.FStringFriendsChatLandingConversationListIxpLayer)

local FStringFriendsChatLandingPerformanceIxpLayer = require(script.Parent.Flags.FStringFriendsChatLandingPerformanceIxpLayer)

local FStringFriendsChatConversationComposerIxpLayer = require(script.Parent.Flags.FStringFriendsChatConversationComposerIxpLayer)

local FStringFriendsChatConversationMessagesIxpLayer = require(script.Parent.Flags.FStringFriendsChatConversationMessagesIxpLayer)

local FStringFriendsChatConversationPerformanceIxpLayer = require(script.Parent.Flags.FStringFriendsChatConversationPerformanceIxpLayer)

local exposureHandler = IXPNavigationUtils.createExposureHandler(FStringFriendsChatLandingPageIxpLayer)
local exposureHandler2 = IXPNavigationUtils.createExposureHandler(FStringFriendsChatConversationPageIxpLayer)
local var1 = FFlagFriendsChatIxpParallelScreenLayers
    and { IXPNavigationUtils.createExposureHandler(FStringFriendsChatLandingConversationRowsIxpLayer), IXPNavigationUtils.createExposureHandler(FStringFriendsChatLandingConversationListIxpLayer), IXPNavigationUtils.createExposureHandler(FStringFriendsChatLandingPerformanceIxpLayer) }
    or {}

local var2 = FFlagFriendsChatIxpParallelScreenLayers
    and { IXPNavigationUtils.createExposureHandler(FStringFriendsChatConversationComposerIxpLayer), IXPNavigationUtils.createExposureHandler(FStringFriendsChatConversationMessagesIxpLayer), IXPNavigationUtils.createExposureHandler(FStringFriendsChatConversationPerformanceIxpLayer) }
    or {}

local function FriendsChatMainContent(tbl1)
    useFriendsChatVisibilityTelemetry()

    local var3 = useChatWindowSettings()
    local var4 = React.useMemo(function()
        return {
            BackgroundColor3 = var3.ChatWindowBackgroundColor3,
            BackgroundTransparency = var3.ChatWindowBackgroundTransparency
        }
    end, { var3 })

    local chatModerationStatusDataHydration = GetChatModerationStatusDataHydration(false)
    local friendsChatNavigationStore = GetFriendsChatNavigationStore(false)
    local friendsChatRealtimeStore = GetFriendsChatRealtimeStore(false)

    local var5 = if FFlagFriendsChatConversationListFocusNav then React.useContext(ReactFocusNavigation.FocusNavigationContext) else nil

    if FFlagAppChatReactiveFeatureRestrictions then
        usePartyChatReactiveFeatureRestriction(true)
    end
    React.useEffect(function()
        friendsChatRealtimeStore.markFriendsTabEntered()
    end, { friendsChatRealtimeStore })
    React.useEffect(function()
        if not FFlagAppChatReactiveFeatureRestrictions then
            chatModerationStatusDataHydration.getUserStatus()
        end
    end, { chatModerationStatusDataHydration })

    React.useEffect(function()
        ExpChatPerfTracker.finish(ExpChatPerfTracker.Events.ChatWindowMountTTI, {}, { tabName = FriendsChatTabName })
        return function()
            ExpChatPerfTracker.cancelAll()
        end
    end, {})
    React.useEffect(function()
        ExpChatPerfTracker.finish(
            ExpChatPerfTracker.Events.ChatWindowTabSwitchTTI,
            { tabId = FriendsChatTabName },
            { tabName = FriendsChatTabName }
        )
    end, {})

    local conversationId = SignalsReact.useSignalState(friendsChatNavigationStore.getEffectiveConversationId)
    if FFlagFriendsChatIxpScreenExposure then
        local current = conversationId ~= nil

        local var7 = React.useRef(nil)

        if var7.current ~= current then
            var7.current = current

            pcall(if current then exposureHandler2 else exposureHandler)
            if FFlagFriendsChatIxpParallelScreenLayers then
                for _, value in if current then var2 else var1 do
                    pcall(value)
                end
            end
        end
    end

    local chatWindowSettings = tbl1.chatWindowSettings or var4
    local parentLayoutOrder = tbl1.parentLayoutOrder or 1
    local localPlayer = Players.LocalPlayer
    local var8 = if localPlayer then tostring(localPlayer.UserId) else nil

    local localization = React.useMemo(function()
        return Localization.new(LocalizationService.RobloxLocaleId)
    end, {})

    React.useEffect(function()
        friendsChatRealtimeStore.setActiveConversationId(conversationId)
        return function()
            friendsChatRealtimeStore.setActiveConversationId(nil)
        end
    end, { friendsChatRealtimeStore, conversationId })

    local var10 = if FFlagFriendsChatConversationListFocusNav then React.useCallback(function(): boolean
        return not (var5 == nil) and var5.focusedGuiObject:getValue() ~= nil
    end, { var5 }) else nil

    local onConversationActivated = React.useCallback(function(str1: string)
        if FFlagFriendsChatConversationListFocusNav and var10() or FFlagFriendsChatFocusInputOnConversationActivated then
            friendsChatNavigationStore.requestFocusInputBar()
        end
        friendsChatNavigationStore.setSelectedConversationId(str1)
    end, { friendsChatNavigationStore, var10 })

    local onBack = React.useCallback(function()
        if FFlagFriendsChatConversationListFocusNav and var10() then
            friendsChatNavigationStore.requestFocusConversationList()
        end
        friendsChatNavigationStore.setSelectedConversationId(nil)
    end, { friendsChatNavigationStore, var10 })

    local onOpenDetails = React.useCallback(function(conversationId2: string)
        ChatSessionRefCount.reserve()
        InExperienceAppChatModal.default:openToScreen({
            screen = EnumScreens.ChatDetails,
            params = {
                conversationId = conversationId2,
                rooted = true,
                entryPoint = SocialCommon.Enums.ChatEntryPointNames.ExperienceChatTabBar
            }
        })
    end, {})

    local onFriendPlaceholderConversationCreated = React.useCallback(function(str1: string)
        friendsChatNavigationStore.setSelectedConversationId(str1)
    end, { friendsChatNavigationStore })

    local element

    if conversationId == nil then
        element = React.createElement(FriendsChatLandingTelemetryProviders, nil, {
            ConversationList = React.createElement(ConversationList, {
                LayoutOrder = parentLayoutOrder,
                chatWindowSettings = chatWindowSettings,
                transparencyValue = tbl1.transparencyValue,
                textTransparency = tbl1.textTransparency,
                isSpatialUIEnabled = tbl1.isSpatialUIEnabled,
                onHovered = tbl1.onHovered,
                onUnhovered = tbl1.onUnhovered,
                onAbsoluteSizeChanged = tbl1.onAbsoluteSizeChanged,
                onAbsolutePositionChanged = tbl1.onAbsolutePositionChanged,
                onConversationActivated = onConversationActivated,
                localUserId = var8
            })
        })
    else
        element = React.createElement(FriendsChatConversationTelemetryProviders, {
            conversationId = conversationId
        }, {
            ConversationWindow = React.createElement(FriendsChatConversationWindow, {
                conversationId = conversationId,
                parentLayoutOrder = parentLayoutOrder,
                chatWindowSettings = chatWindowSettings,
                transparencyValue = tbl1.transparencyValue,
                textTransparency = tbl1.textTransparency,
                isSpatialUIEnabled = tbl1.isSpatialUIEnabled,
                isChannelBarVisible = tbl1.isChannelBarVisible,
                onHovered = tbl1.onHovered,
                onUnhovered = tbl1.onUnhovered,
                onAbsoluteSizeChanged = tbl1.onAbsoluteSizeChanged,
                onAbsolutePositionChanged = tbl1.onAbsolutePositionChanged,
                onBack = onBack,
                onOpenDetails = onOpenDetails,
                onFriendPlaceholderConversationCreated = onFriendPlaceholderConversationCreated
            })
        })
    end

    return React.createElement(LocalizationProvider, { localization = localization }, {
        Content = React.createElement(
            Foundation.FoundationProvider,
            {
                colorMode = Foundation.Enums.ColorMode.Dark
            },
            { Content = element }
        )
    })
end

local function FriendsChatMain(tbl1)
    local localPlayer = Players.LocalPlayer
    local var3 = if localPlayer then tostring(localPlayer.UserId) else "unknown"
    local robloxLocaleId = LocalizationService.RobloxLocaleId
    local playSessionId = RbxAnalyticsService:GetPlaySessionId()

    useAppChatUpdateSession()

    local var4 = React.useMemo(function()
        return {
            context = "platformChat",
            locale = robloxLocaleId,
            entryPoint = SocialCommon.Enums.ChatEntryPointNames.ExperienceChatTabBar,
            userId = var3,
            placement = ChatPlacementContext.Enum.InExperienceFriendsTab,
            playSessionId = playSessionId,
            currentSquadId = nil
        }
    end, { robloxLocaleId, var3, playSessionId })

    local value, var6 = useGetAndSetRef(var4)
    React.useEffect(function()
        var6(var4)
    end, { var4, var6 })

    return React.createElement(
        AppTelemetryLayer.Provider,
        { value = value },
        {
            Content = React.createElement(FriendsChatMainContent, tbl1)
        }
    )
end
return FriendsChatMain
