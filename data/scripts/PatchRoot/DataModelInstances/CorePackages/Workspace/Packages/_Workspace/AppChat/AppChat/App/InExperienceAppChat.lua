-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:01:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SessionService = game:GetService("SessionService")

local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local React = require(AppChatParent.React)
local _ReactFocusNavigation = require(AppChatParent.ReactFocusNavigation)
local Responsive = require(AppChatParent.Responsive)
local UIBlox = require(AppChatParent.UIBlox)
local UserLib = require(AppChatParent.UserLib)
local RoactUtils = require(AppChatParent.RoactUtils)
local SocialCommon = require(AppChatParent.SocialCommon)
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local Constants = UIBlox.App.Style.Constants

local AppSessionService = require(AppChatParent.RoactServiceTags).AppSessionService
local RoactServices = require(AppChatParent.RoactServices).RoactServices

local SetAppLoaded = require(AppChat.Actions.SetAppLoaded)
local GetAppLoadedStore = require(AppChat.Stores.GetAppLoadedStore)
local FFlagAppChatUseSignalsForAppLoaded = require(AppChat.Flags.FFlagAppChatUseSignalsForAppLoaded)
local EnteredChatFromEntryPoint = require(AppChat.Actions.EnteredChatFromEntryPoint)

local InExperienceAppChatContainer = require(AppChat.App.InExperienceAppChatContainer)
local getAllFriendsAsync = require(AppChat.Conversations.Thunks.getAllFriendsAsync)
local getLocalUserFriendsCount = require(AppChat.Conversations.Thunks.getLocalUserFriendsCount)
local GetLocalUser = UserLib.Thunks.GetLocalUser

local LayerCollectorProvider = UIBlox.Core.Layout.LayerCollector.LayerCollectorProvider

local AppChatToastManagerInExp = require(AppChat.App.AppChatToastManagerInExp)
local AppChatPersistentEventReceivers = require(AppChat.Components.EventReceivers.AppChatPersistentEventReceivers)
local useIsAppChatVisible = require(AppChat.App.Hooks.useIsAppChatVisible)
local usePreventExperienceControls = require(AppChat.App.Hooks.usePreventExperienceControls)
local useAppChatUpdateSession = require(AppChat.Hooks.useAppChatUpdateSession)
local usePartyChatReactiveFeatureRestriction = require(AppChat.Hooks.usePartyChatReactiveFeatureRestriction)

local Style = require(AppChatParent.Style)
local UiModeStyleProvider = Style.UiModeStyleProvider
local DesignTokenProvider = Style.DesignTokenProvider
local SquadEventReceiver = require(AppChatParent.SquadsCore.SquadEventReceiver)
local SquadOverlay = require(AppChatParent.SquadsCore.SquadOverlay)

local useParentContainerVisibilitySignal = require(AppChat.App.Hooks.useParentContainerVisibilitySignal)
local ParentContainerContext = require(AppChat.Contexts.ParentContainer.ParentContainerContext)
local Foundation = require(AppChatParent.Foundation)
local ColorMode = Foundation.Enums.ColorMode
local OverlayHost = require(AppChat.Components.OSA.OverlayHost)

local bool1 = game:DefineFastFlag("DebugAppChatDisplayOnJoin", false)
local DisplayOrder = game:DefineFastInt("AppChatInExperienceDisplayOrder", 5)
local FFlagAppChatReactiveFeatureRestrictions = require(AppChatParent.SharedFlags).FFlagAppChatReactiveFeatureRestrictions
local GetFFlagIsSquadEnabled = require(AppChatParent.SharedFlags).GetFFlagIsSquadEnabled
local FFlagAppChatGateInExpSquadEventReceiver = require(AppChat.Flags.FFlagAppChatGateInExpSquadEventReceiver)

local GetFFlagAppChatInExpToastSnoozeMenuDismissFix = require(AppChatParent.SharedFlags).GetFFlagAppChatInExpToastSnoozeMenuDismissFix
local PartyPageCarouselExperimentation = require(AppChatParent.SocialExperiments).PartyPageCarouselExperimentation
local FFlagEnableAppChatSnoozeMenuFocus = require(AppChatParent.SharedFlags).FFlagEnableAppChatSnoozeMenuFocus
local isSideSheetEnabled = require(AppChatParent.InExperienceSideSheetUtils.isSideSheetEnabled)
local FFlagSideSheetFocusNav = require(AppChatParent.SharedFlags).FFlagSideSheetFocusNav
local FFlagEnableDrawerAnimatingHook = require(AppChatParent.SharedFlags).FFlagEnableDrawerAnimatingHook

local FocusNavigationUtils = require(AppChatParent.FocusNavigationUtils)
local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum
local FocusNavigationEventNameEnum = FocusNavigationUtils.FocusNavigationEventNameEnum
local FocusRoot = FocusNavigationUtils.FocusRoot
local InputHandlers = require(AppChatParent.InputHandlers)

local NotificationSnoozeMenuVisibleSignal = require(AppChatParent.ToastNotification).Signals.NotificationSnoozeMenuVisibleSignal
local useAppPolicy = require(AppChatParent.UniversalAppPolicy).useAppPolicy
local useSelector = require(AppChatParent.RoactUtils).Hooks.RoactRodux.useSelector

local Drawer = require(AppChatParent.Drawer)
local useDrawerVisible = Drawer.Hooks.useDrawerVisible
local useDrawerAnimating = Drawer.Hooks.useDrawerAnimating

local eventMap = {
    [Enum.KeyCode.ButtonB] = FocusNavigationEventNameEnum.NavigateBack,
    [Enum.KeyCode.Escape] = FocusNavigationEventNameEnum.NavigateBack
}

function wrapWithFocusRoot(arg1, eventHandlers, arg2)
    return React.createElement(FocusRoot, {
        eventHandlers = eventHandlers,
        eventMap = eventMap,
        isAutoFocusRoot = not FFlagEnableAppChatSnoozeMenuFocus or arg2,
        isIsolated = true,
        surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.PopUp
    }, arg1)
end

function InExperienceAppChat()
    local var1 = React.useRef(nil)
    local var2 = useDispatch()
    local var3, hideAppChat = useIsAppChatVisible(bool1)
    local var5 = React.useContext(ParentContainerContext)
    local showParentContainer = var5.showParentContainer
    local hideParentContainer = var5.hideParentContainer
    local updateCurrentSquadId = var5.updateCurrentSquadId
    local visibilitySignal = var5.visibilitySignal
    local requestedRouteSignal = var5.requestedRouteSignal
    local getRequestedRoute = var5.getRequestedRoute
    local clearRequestedRoute = var5.clearRequestedRoute
    local initialConversationId, setInitialConversationId = React.useState("")
    local requestedRoute, var9 = React.useState(getRequestedRoute())
    local var10, var11 = React.useState(true)
    local var12 = nil
    local var13 = nil
    if isSideSheetEnabled and FFlagSideSheetFocusNav and FFlagEnableDrawerAnimatingHook then
        var12 = useDrawerVisible()
        var13 = useDrawerAnimating()
    end
    useParentContainerVisibilitySignal()
    useAppChatUpdateSession(var3)
    usePreventExperienceControls(var3)
    if FFlagAppChatReactiveFeatureRestrictions then
        usePartyChatReactiveFeatureRestriction(var3)
    end

    React.useEffect(function()
        if not var3 then
            return
        end

        if FFlagAppChatUseSignalsForAppLoaded then
            GetAppLoadedStore(false).setAppLoaded(true)
        else
            var2(SetAppLoaded(true))
        end
        var2(getAllFriendsAsync(true))

        if PartyPageCarouselExperimentation.getPartyPageCarouselEnabled() then
            var2(getLocalUserFriendsCount())
        end
    end, { var2, var3 })

    React.useEffect(function()
        var2(GetLocalUser())
    end, { var2 })
    React.useEffect(function()
        local connection = visibilitySignal:connect(function(arg1)
            if not arg1 and var1.current then
                var1.current.Enabled = false
            end
        end)

        return function()
            connection:disconnect()
        end
    end, { visibilitySignal })

    React.useEffect(function()
        local connection = requestedRouteSignal:connect(function(arg1)
            var9(arg1)
        end)

        return function()
            connection:disconnect()
        end
    end, { requestedRouteSignal })

    if GetFFlagIsSquadEnabled() then
        local var14 = useSelector(function(arg1)
            local currentSquad = arg1.Squad and arg1.Squad.Squad and arg1.Squad.Squad.currentSquad
            return if currentSquad and currentSquad.squadId then currentSquad.squadId else ""
        end)

        React.useEffect(function()
            updateCurrentSquadId(var14)
        end, { var14, updateCurrentSquadId })
    end

    local var14 = if GetFFlagIsSquadEnabled() then useSelector(function(arg1)
        return arg1.Squad.SquadPrompt.arguments
    end) else nil

    local var15 = React.useMemo(function()
        local result = {}
        result[FocusNavigationEventNameEnum.NavigateBack] = {
            handler = InputHandlers.onRelease(function(arg1)
                hideParentContainer()
                arg1:cancel()
            end)
        }
        return result
    end, { hideParentContainer })

    local var16 = useAppPolicy(function(arg1)
        return arg1.getCanAccessParty()
    end)

    local promptType = GetFFlagIsSquadEnabled() and var14 and var14.promptType

    if FFlagEnableAppChatSnoozeMenuFocus then
        React.useEffect(function()
            local connection = NotificationSnoozeMenuVisibleSignal:connect(function(tbl2)
                var11(not tbl2.visible)
            end)
            return function()
                connection:disconnect()
            end
        end, {})
    end

    local navigateToChat = React.useCallback(function(str1: string)
        local function openLegacyAppChat() -- Luacid: Inlined by compiler; 1 call site recovered
            showParentContainer()
            setInitialConversationId(str1)
            var2(EnteredChatFromEntryPoint(SocialCommon.Enums.ChatEntryPointNames.ToastInExp))
        end
        return var5.openFriendsChatConversation(str1):andThen(function<T>(arg1: T): T
            if not arg1 then
                openLegacyAppChat()
            end

            return arg1
        end)
    end, { var2, var5.openFriendsChatConversation, showParentContainer })

    if isSideSheetEnabled and FFlagSideSheetFocusNav and FFlagEnableDrawerAnimatingHook then
        React.useEffect(function()
            var11(not (var12 or var13))
        end, { var12, var13 })
    end

    if FFlagAppChatGateInExpSquadEventReceiver then
        var16 = GetFFlagIsSquadEnabled() and var16
    end

    local tbl2 = {
        SquadEventReceiver = if var16 then React.createElement(SquadEventReceiver) else nil,
        AppChatPersistentEventReceivers = React.createElement(AppChatPersistentEventReceivers, { isInExperience = true }),
        AppChatToastManagerInExp = React.createElement(AppChatToastManagerInExp, {
            hideAllChatToasts = if GetFFlagAppChatInExpToastSnoozeMenuDismissFix() then nil else var3,
            isAppChatVisible = if GetFFlagAppChatInExpToastSnoozeMenuDismissFix() then var3 else nil,
            navigateToChat = navigateToChat
        }),
        AppChatContainer = 0
    }
    local createElement = React.createElement
    local var18 = UiModeStyleProvider
    local tbl3 = {
        style = {
            themeName = ColorMode.Dark,
            fontName = Constants.FontName.Gotham
        }
    }
    local createElement2 = React.createElement
    local var19 = DesignTokenProvider
    local tbl4 = {
        tokenMappers = {}
    }
    local tbl5 = { AppChatScreenGui = 0 }
    local var20

    if var3 or promptType then
        local createElement3 = React.createElement
        local str1 = "ScreenGui"
        local tbl6 = {
            ResetOnSpawn = false,
            ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
            ScreenInsets = Enum.ScreenInsets.CoreUISafeInsets,
            DisplayOrder = DisplayOrder,
            ref = var1
        }
        local wrapWithFocusRoot = wrapWithFocusRoot
        local tbl7 = {
            SquadOverlay = if promptType then React.createElement(SquadOverlay) else nil,
            AppChat = 0
        }
        local element

        if var3 then
            element = React.createElement(LayerCollectorProvider, {}, {
                containerRef = React.createElement(Responsive.ContainerRef.Provider, {
                    value = var1
                }, { React.createElement(RoactServices.ServiceProvider, {
                        services = {
                            [AppSessionService] = SessionService
                        }
                    }, {
                        InExperienceAppChatContainer = React.createElement(InExperienceAppChatContainer, {
                            hideAppChat = hideAppChat,
                            initialConversationId = initialConversationId,
                            setInitialConversationId = setInitialConversationId,
                            requestedRoute = requestedRoute,
                            clearRequestedRoute = clearRequestedRoute
                        })
                    }) })
            })
        else
            element = nil
        end

        tbl7.AppChat = element
        var20 = createElement3(str1, tbl6, wrapWithFocusRoot(tbl7, var15, var10))
    else
        var20 = nil
    end

    tbl5.AppChatScreenGui = var20
    tbl2.AppChatContainer = createElement(var18, tbl3, { createElement2(var19, tbl4, tbl5) })

    tbl2.OverlayHost = React.createElement(
        OverlayHost,
        {
            providers = {{
                class = Foundation.FoundationProvider,
                props = {
                    colorMode = ColorMode.Dark
                }
            }}
        }
    )
    return React.createElement(React.Fragment, {}, tbl2)
end

return InExperienceAppChat
