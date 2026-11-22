-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T15:41:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerTriggeredModals = script:FindFirstAncestor("ServerTriggeredModals")
local ServerTriggeredModalsParent = ServerTriggeredModals.Parent

local React = require(ServerTriggeredModalsParent.React)
local AppNavBar = require(ServerTriggeredModalsParent.AppNavBar)
local Foundation = require(ServerTriggeredModalsParent.Foundation)
local CentralOverlay = require(ServerTriggeredModalsParent.CentralOverlay)
local RobloxAppEnums = require(ServerTriggeredModalsParent.RobloxAppEnums)
local LocalUserIdStore = require(ServerTriggeredModalsParent.LocalUserIdStore).LocalUserIdStore
local SignalsReact = require(ServerTriggeredModalsParent.SignalsReact)
local SduiSharedUtilities = require(ServerTriggeredModalsParent.SduiSharedUtilities)
local SharedFlags = require(ServerTriggeredModalsParent.SharedFlags)

local FFlagPushNotificationsUpsellPassClientAttributesToPrompts = SharedFlags.FFlagPushNotificationsUpsellPassClientAttributesToPrompts
local useDispatch = require(ServerTriggeredModalsParent.RoactUtils).Hooks.RoactRodux.useDispatch
local useStore = require(ServerTriggeredModalsParent.RoactUtils).Hooks.RoactRodux.useStore

local CentralOverlayType = RobloxAppEnums.CentralOverlayType
local SetCentralOverlay = CentralOverlay.Actions.SetCentralOverlay
local SduiFeatureEntryPoint = SduiSharedUtilities.SduiFeatureEntryPoint
local SduiLoadTimer = SduiSharedUtilities.SduiLoadTimer
local View = Foundation.View

local Logger = require(ServerTriggeredModals.Logger)
local reportPromptImpression = require(ServerTriggeredModals.reportPromptImpression)
local logPromptModalSkipped = require(ServerTriggeredModals.logPromptModalSkipped)
local sendModalImpressionEvent = require(ServerTriggeredModalsParent.ServerTriggeredModalImpressions).sendModalImpressionEvent
local fetchPrompts = require(ServerTriggeredModals.SduiV2.fetchPrompts)
local PromptsEntryPoint = require(ServerTriggeredModals.SduiV2.PromptsEntryPoint)
local PromptStyle = require(ServerTriggeredModals.SduiV2.PromptStyle)
local usePromptEntries = require(ServerTriggeredModals.SduiV2.usePromptEntries)
local useModalSignalStore = require(ServerTriggeredModals.SignalStores.useModalSignalStore)
local FFlagPromptsActionEventLogging = require(ServerTriggeredModals.Flags.FFlagPromptsActionEventLogging)
local FFlagPromptsModalSkipTelemetry = require(ServerTriggeredModals.Flags.FFlagPromptsModalSkipTelemetry)
local FFlagPlusUpsellSheetHomePrompt = require(ServerTriggeredModals.Flags.FFlagPlusUpsellSheetHomePrompt)
local PlusUpsellSheetPrompt = if FFlagPlusUpsellSheetHomePrompt then require(script.Parent.Parent.PlusUpsellSheetPrompt) else nil
local getEntryPointSurfaceConfig = require(script.Parent.getEntryPointSurfaceConfig)
local getHomepagePromptsClientAttributes = require(script.Parent.Parent.getHomepagePromptsClientAttributes)
local CoachmarkRenderer = require(script.Parent.CoachmarkRenderer)
local SurfaceBanner = require(script.Parent.SurfaceBanner)

local FFlagSduiAllowNoConfigsBuilt = SharedFlags.FFlagSduiAllowNoConfigsBuilt
local FFlagPromptsImpressionUsesTitle = SharedFlags.FFlagPromptsImpressionUsesTitle
local FFlagPromptsHandlerCoachmarkEnabled = SharedFlags.FFlagPromptsHandlerCoachmarkEnabled
local FFlagEdpGameLeavePromptsHandlerEnabled = SharedFlags.FFlagEdpGameLeavePromptsHandlerEnabled
local FFlagEdpOpenPromptsHandlerEnabled = SharedFlags.FFlagEdpOpenPromptsHandlerEnabled
local FFlagNotificationStreamPromptsHandlerEnabled = SharedFlags.FFlagNotificationStreamPromptsHandlerEnabled
local FFlagSduiSystemBannerComponent = SharedFlags.FFlagSduiSystemBannerComponent
local FFlagSduiSurfaceBannerScrollAwaySticky = SharedFlags.FFlagSduiSurfaceBannerScrollAwaySticky
local FFlagSduiSurfaceBannerAlwaysMounted = SharedFlags.FFlagSduiSurfaceBannerAlwaysMounted
local FFlagAppIaScrollAway = SharedFlags.FFlagAppIaScrollAway
local FFlagSduiDismissPromptAction = SharedFlags.FFlagSduiDismissPromptAction
local FFlagHomepagePromptsPaddingFix = SharedFlags.FFlagHomepagePromptsPaddingFix
local FFlagHomepagePromptsHandlerPassClientAttributes = SharedFlags.FFlagHomepagePromptsHandlerPassClientAttributes
local FFlagPromptsEdpOpenReplaceOnFetch = SharedFlags.FFlagPromptsEdpOpenReplaceOnFetch
local FFlagPromptsHandlerFetchOncePerSession = SharedFlags.FFlagPromptsHandlerFetchOncePerSession
local FIntPromptsHandlerSessionTimeoutMs = SharedFlags.FIntPromptsHandlerSessionTimeoutMs
local FFlagChatPushUpsellPromptsEnabled = SharedFlags.FFlagChatPushUpsellPromptsEnabled

local tbl1 = ({})

local tbl2 = ({})

local function parsePromptStyles(fStringHomePromptsHandlerPromptStyles: string): {[any]: any}?
    local tbl3 = {}
    for value in string.gmatch(fStringHomePromptsHandlerPromptStyles, "[^,%s]+") do
        table.insert(tbl3, value)
    end
    return if #tbl3 == 0 then nil else tbl3
end

local function claimAppSessionRequest(chatLandingOpen, configKey: string): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    if not FFlagChatPushUpsellPromptsEnabled or chatLandingOpen ~= PromptsEntryPoint.ChatLandingOpen then
        return true
    end
    local currentUserId = LocalUserIdStore.getCurrentUserId(false)
    if tbl2[configKey] == currentUserId then
        return false
    end
    tbl2[configKey] = currentUserId
    return true
end

local function forwardsClientAttributes(chatLandingOpen) -- Luacid: Inlined by compiler; 2 call sites recovered
    return if FFlagEdpGameLeavePromptsHandlerEnabled or FFlagEdpOpenPromptsHandlerEnabled then true else FFlagChatPushUpsellPromptsEnabled and chatLandingOpen == PromptsEntryPoint.ChatLandingOpen
end

local function getHomepagePromptStyles(homepageLaunch) -- Luacid: Inlined by compiler; 2 call sites recovered
    if homepageLaunch ~= PromptsEntryPoint.HomepageLaunch then
        return nil
    end
    return (parsePromptStyles(SharedFlags.FStringHomePromptsHandlerPromptStyles))
end

local var1 = React.memo(function(tbl3) -- name: PromptsHandler
    local entryPoint = tbl3.entryPoint

    local var1 = FFlagNotificationStreamPromptsHandlerEnabled and entryPoint == PromptsEntryPoint.NotificationStreamOpen
    local promptStyle = tbl3.promptStyle

    local fFlagLuaAppEnableSduiHomePage = SharedFlags.FFlagHomePromptsHandlerRestrictPromptStyles and SharedFlags.FFlagLuaAppEnableSduiHomePage
    local var2 = useDispatch()
    local var3 = if FFlagSduiDismissPromptAction then useStore() else nil
    local modalSignalStore = useModalSignalStore()
    local universeId = if (FFlagEdpGameLeavePromptsHandlerEnabled or FFlagEdpOpenPromptsHandlerEnabled) and tbl3.clientAttributes ~= nil then tbl3.clientAttributes.universeId else nil
    local replaceOnFetch = if FFlagPromptsEdpOpenReplaceOnFetch then tbl3.replaceOnFetch else nil
    local var5 = if FFlagPushNotificationsUpsellPassClientAttributesToPrompts then getHomepagePromptsClientAttributes.use(entryPoint, tbl3.clientAttributes) else nil

    local surfaceConfig = React.useMemo(function()
        if FFlagEdpGameLeavePromptsHandlerEnabled or FFlagEdpOpenPromptsHandlerEnabled then
            return getEntryPointSurfaceConfig(entryPoint, universeId)
        end
        return getEntryPointSurfaceConfig(entryPoint)
    end, FFlagEdpGameLeavePromptsHandlerEnabled and { entryPoint, universeId }
        or FFlagEdpOpenPromptsHandlerEnabled and { entryPoint, universeId }
        or { entryPoint })

    local var7 = SignalsReact.useSignalState(modalSignalStore.getHasShownGetter(entryPoint))
    local var8 = SignalsReact.useSignalState(modalSignalStore.getMetadataGetter(entryPoint))

    local var9 = nil
    local var10

    if FFlagHomepagePromptsHandlerPassClientAttributes then
        var9 = React.useMemo(function()
            if var1 then
                return tbl3.clientAttributes
            elseif FFlagPushNotificationsUpsellPassClientAttributesToPrompts
                and entryPoint == PromptsEntryPoint.HomepageLaunch
                and (not (FFlagEdpGameLeavePromptsHandlerEnabled or FFlagEdpOpenPromptsHandlerEnabled) or tbl3.clientAttributes == nil)
            then
                return var5
            elseif forwardsClientAttributes(entryPoint) and tbl3.clientAttributes ~= nil then
                return tbl3.clientAttributes
            elseif entryPoint == PromptsEntryPoint.HomepageLaunch then
                return getHomepagePromptsClientAttributes.get()
            end
            return nil
        end, {
            entryPoint,
            var5,
            tbl3.clientAttributes,
            var1
        })

        local useMemo = React.useMemo
        local function func1()
            return {
                entryPoint = entryPoint,
                surfaceKey = surfaceConfig.surfaceKey,
                configKey = surfaceConfig.configKey,
                clearOnEmptyResponse = true,
                allowNoConfigsBuilt = if FFlagSduiAllowNoConfigsBuilt then true else nil,
                loadTimer = SduiLoadTimer.createLoadTimer(surfaceConfig.configKey),
                clientAttributes = var9,
                replaceOnFetch = if FFlagPromptsEdpOpenReplaceOnFetch then replaceOnFetch else nil,
                promptStyles = if fFlagLuaAppEnableSduiHomePage then getHomepagePromptStyles(entryPoint) else nil
            }
        end

        local var11 = var9
        local var12 = if FFlagPromptsEdpOpenReplaceOnFetch then replaceOnFetch else nil
        var10 = useMemo(func1, { entryPoint, surfaceConfig, var11, fFlagLuaAppEnableSduiHomePage, var12 })
    else
        local useMemo = React.useMemo
        local function func1()
            return {
                entryPoint = entryPoint,
                surfaceKey = surfaceConfig.surfaceKey,
                configKey = surfaceConfig.configKey,
                clearOnEmptyResponse = true,
                allowNoConfigsBuilt = if FFlagSduiAllowNoConfigsBuilt then true else nil,
                loadTimer = SduiLoadTimer.createLoadTimer(surfaceConfig.configKey),
                clientAttributes = if forwardsClientAttributes(entryPoint) or var1 then tbl3.clientAttributes else nil,
                replaceOnFetch = if FFlagPromptsEdpOpenReplaceOnFetch then replaceOnFetch else nil,
                promptStyles = if fFlagLuaAppEnableSduiHomePage then getHomepagePromptStyles(entryPoint) else nil
            }
        end

        local tbl4

        if FFlagEdpGameLeavePromptsHandlerEnabled
            or FFlagEdpOpenPromptsHandlerEnabled
            or FFlagChatPushUpsellPromptsEnabled
            or FFlagNotificationStreamPromptsHandlerEnabled
        then
            local clientAttributes = tbl3.clientAttributes
            local var11 = if FFlagPromptsEdpOpenReplaceOnFetch then replaceOnFetch else nil
            tbl4 = {
                entryPoint,
                surfaceConfig,
                clientAttributes,
                fFlagLuaAppEnableSduiHomePage,
                var11,
                var1
            }
        else
            local var11 = if FFlagPromptsEdpOpenReplaceOnFetch then replaceOnFetch else nil
            tbl4 = {
                entryPoint,
                surfaceConfig,
                fFlagLuaAppEnableSduiHomePage,
                var11
            }
        end

        var10 = useMemo(func1, tbl4)
    end

    local var11 = React.useRef(os.clock() + FIntPromptsHandlerSessionTimeoutMs / 1000)

    if FFlagPushNotificationsUpsellPassClientAttributesToPrompts then
        React.useEffect(function()
            local bool1 = entryPoint == PromptsEntryPoint.HomepageLaunch
                and not ((FFlagEdpGameLeavePromptsHandlerEnabled or FFlagEdpOpenPromptsHandlerEnabled) and tbl3.clientAttributes ~= nil)
            local sessionClientAttribute = if bool1 then getHomepagePromptsClientAttributes.sessionClientAttribute else nil

            if bool1 and var9 == nil and (not FFlagPromptsHandlerFetchOncePerSession or sessionClientAttribute == nil) then
                return
            end

            if not FFlagPromptsHandlerFetchOncePerSession or sessionClientAttribute == nil then
                if claimAppSessionRequest(entryPoint, var10.configKey) then
                    local bool2 = if FFlagEdpOpenPromptsHandlerEnabled then bool1 or entryPoint == PromptsEntryPoint.ExperienceDetailsPageOpen else nil

                    if var1 or not FFlagEdpOpenPromptsHandlerEnabled and bool1 or FFlagEdpOpenPromptsHandlerEnabled and bool2 then
                        fetchPrompts(var10, true)
                        return
                    end
                    fetchPrompts(var10)
                end

                return
            end

            local configKey = var10.configKey
            local var12 = if var9 then var9[sessionClientAttribute] else nil

            if var12 ~= nil then
                if tbl1[configKey] == false then
                    tbl1[configKey] = var12
                elseif tbl1[configKey] ~= var12 then
                    tbl1[configKey] = var12
                    fetchPrompts(var10, true)
                end

                return
            end

            if tbl1[configKey] ~= nil then
                return
            end

            local var13 = task.delay(math.max(0, var11.current - os.clock()), function()
                if tbl1[configKey] == nil then
                    tbl1[configKey] = false
                    fetchPrompts(var10, true)
                end
            end)
            return function()
                task.cancel(var13)
            end
        end, {
            entryPoint,
            var10,
            tbl3.clientAttributes,
            var9,
            var1
        })
    else
        React.useEffect(function()
            if not claimAppSessionRequest(entryPoint, var10.configKey) then
                return
            end

            local bool1 = if FFlagEdpOpenPromptsHandlerEnabled then entryPoint == PromptsEntryPoint.ExperienceDetailsPageOpen else nil
            fetchPrompts(
                var10,
                if var1 then true elseif FFlagEdpOpenPromptsHandlerEnabled then if bool1 then true else nil else nil
            )
        end, { var10, if FFlagEdpOpenPromptsHandlerEnabled then entryPoint elseif FFlagChatPushUpsellPromptsEnabled then entryPoint else nil, var1 })
    end

    local var12 = usePromptEntries(surfaceConfig.configKey, PromptStyle.Modal)
    local var13 = var12[1]
    local var14 = if FFlagSduiDismissPromptAction then React.useRef(nil) else nil
    local var15 = if FFlagSduiDismissPromptAction then React.useRef(nil) else nil
    local useEffect = React.useEffect
    local function func1()
        if var7 then
            if FFlagPromptsModalSkipTelemetry then
                logPromptModalSkipped.logAll(logPromptModalSkipped.Reason.AlreadyShown, entryPoint, var12)
            end

            return
        end

        if var8 then
            if FFlagPromptsModalSkipTelemetry then
                logPromptModalSkipped.logAll(logPromptModalSkipped.Reason.LegacyMetadata, entryPoint, var12)
            end

            return
        end

        if var13 == nil
            or var13.config == nil
            or var13.identifier == nil
            or var13.robloxComponentType == nil
            or var13.title == nil
        then
            if FFlagPromptsModalSkipTelemetry and var13 ~= nil then
                logPromptModalSkipped.log(logPromptModalSkipped.Reason.IncompleteEntry, entryPoint, var13)
            end

            return
        end

        modalSignalStore.setHasShown(entryPoint, true)
        if FFlagPromptsModalSkipTelemetry then
            logPromptModalSkipped.markShown(entryPoint, var13)
        end
        var2(
            SetCentralOverlay(CentralOverlayType.SduiPromptModal, {
                configKey = surfaceConfig.configKey,
                appPage = surfaceConfig.appPage,
                modalId = var13.identifier,
                modalType = if FFlagPromptsImpressionUsesTitle then var13.title else var13.robloxComponentType
            })
        )

        if FFlagSduiDismissPromptAction then
            var14.current = var13.title
            var15.current = var13.identifier
        end
    end

    local var16 = if FFlagPromptsModalSkipTelemetry then var12 else nil
    useEffect(func1, { var7, var8, var2, modalSignalStore, var13, surfaceConfig, entryPoint, var16 })

    if FFlagSduiDismissPromptAction then
        React.useEffect(function()
            local current = var14.current
            if current == nil then
                return
            end
            for _, value in var12 do
                if value.title == current then
                    return
                end
            end

            local current2 = var15.current
            var14.current = nil
            var15.current = nil
            local centralOverlay = var3:getState().CentralOverlay
            if centralOverlay ~= nil
                and centralOverlay.OverlayType == CentralOverlayType.SduiPromptModal
                and centralOverlay.Arguments ~= nil
                and centralOverlay.Arguments.modalId == current2
            then
                var2(SetCentralOverlay())
            end
        end, { var12, var2, var3 })
    end

    if FFlagPlusUpsellSheetHomePrompt then
        PlusUpsellSheetPrompt.usePlusUpsellSheetPrompt(
            {
                entryPoint = entryPoint,
                hasShownKey = entryPoint,
                modalSignalStore = modalSignalStore
            }
        )
    end

    local bool1 = promptStyle == PromptStyle.SurfaceBanner
    local var17 = usePromptEntries(surfaceConfig.configKey, PromptStyle.SurfaceBanner)
    local var18 = if bool1 then var17[1] else nil
    local identifier = if var18 then var18.identifier or nil else nil
    local var19 = if var18 then if FFlagPromptsImpressionUsesTitle then var18.title else var18.robloxComponentType else nil
    local bool2 = promptStyle == PromptStyle.InlineBanner
    local var20 = usePromptEntries(surfaceConfig.configKey, PromptStyle.InlineBanner)
    local var21 = if bool2 then var20[1] else nil
    local identifier2 = if var21 then var21.identifier or nil else nil
    local var22 = if var21 then if FFlagPromptsImpressionUsesTitle then var21.title else var21.robloxComponentType else nil

    React.useEffect(function()
        if identifier and var19 then
            reportPromptImpression(var19, identifier):catch(function()
                Logger:warning("Failed to report prompt impression")
            end)
            sendModalImpressionEvent(identifier, var19)
        end
    end, { identifier, var19 })

    React.useEffect(function()
        if identifier2 and var22 then
            reportPromptImpression(var22, identifier2):catch(function()
                Logger:warning("Failed to report prompt impression")
            end)
            sendModalImpressionEvent(identifier2, var22)
        end
    end, { identifier2, var22 })

    local bool3 = false
    if FFlagPromptsHandlerCoachmarkEnabled then
        for _, value in (usePromptEntries(surfaceConfig.configKey, PromptStyle.Coachmark)) do
            if value.config and value.identifier and value.title then
                bool3 = true
                break
            end
        end
    end

    local scrollAwayEnabled = FFlagSduiSurfaceBannerScrollAwaySticky and FFlagAppIaScrollAway and AppNavBar.getScrollAwayEnabled()

    local var23 = var18 ~= nil or FFlagSduiSurfaceBannerAlwaysMounted
    local var24 = nil
    if bool1 then
        if FFlagSduiSystemBannerComponent and var23 and scrollAwayEnabled then
            var24 = React.createElement(SurfaceBanner, {
                identifier = if var18 then var18.identifier else nil,
                configKey = surfaceConfig.configKey,
                appPage = surfaceConfig.appPage,
                surfaceBannerContent = tbl3.surfaceBannerContent
            })
        elseif FFlagSduiSystemBannerComponent and var23 then
            local createElement = React.createElement
            local str1 = "Frame"
            local tbl4 = {
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1
            }
            local tbl5 = {
                Layout = React.createElement(
                    "UIListLayout",
                    {
                        FillDirection = Enum.FillDirection.Vertical,
                        SortOrder = Enum.SortOrder.LayoutOrder
                    }
                ),
                SurfaceBanner = 0,
                ContentContainer = 0
            }
            local var25

            if var18 then
                local createElement2 = React.createElement
                local var26 = SduiFeatureEntryPoint
                local tbl6 = {
                    configKey = surfaceConfig.configKey,
                    identifier = var18.identifier,
                    appPage = surfaceConfig.appPage,
                    additionalAnalyticsData = if FFlagPromptsActionEventLogging then {
                        promptInstanceId = if var18.identifier then var18.identifier else nil
                    } else nil,
                    shouldDisplayLoading = false,
                    shouldDisplayError = false,
                    LayoutOrder = 1
                }
                var25 = createElement2(var26, tbl6)
            else
                var25 = nil
            end

            tbl5.SurfaceBanner = var25

            tbl5.ContentContainer = React.createElement(
                "Frame",
                {
                    LayoutOrder = 2,
                    Size = UDim2.new(1, 0, 0, 0),
                    BackgroundTransparency = 1
                },
                {
                    UIFlexItem = React.createElement("UIFlexItem", { FlexMode = Enum.UIFlexMode.Fill }),
                    Content = tbl3.surfaceBannerContent
                }
            )
            var24 = createElement(str1, tbl4, tbl5)
        else
            var24 = tbl3.surfaceBannerContent
        end
    elseif bool2 then
        if var21 then
            local createElement = React.createElement
            local var25 = SduiFeatureEntryPoint
            local tbl4 = {
                configKey = surfaceConfig.configKey,
                identifier = var21.identifier,
                appPage = surfaceConfig.appPage,
                additionalAnalyticsData = if FFlagPromptsActionEventLogging then {
                    promptInstanceId = if var21.identifier then var21.identifier else nil
                } else nil,
                shouldDisplayLoading = false,
                shouldDisplayError = false
            }
            var24 = createElement(var25, tbl4)
        else
            var24 = tbl3.inlineBannerFallback
        end
    end

    if (FFlagHomepagePromptsPaddingFix or var1) and bool2 then
        local bool4 = var17[1] ~= nil
        if var24 ~= nil then
            local bool5 = bool4 and tbl3.topPadding ~= nil
            local bool6 = tbl3.bottomPadding ~= nil
            var24 = React.createElement(View, {
                Size = UDim2.new(1, 0, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                padding = {
                    top = if bool5 then UDim.new(0, tbl3.topPadding) else nil,
                    bottom = if bool6 then UDim.new(0, tbl3.bottomPadding) else nil
                }
            }, { InlineBanner = var24 })
        elseif bool4 and tbl3.topPadding then
            var24 = React.createElement("Frame", { Size = UDim2.new(1, 0, 0, tbl3.topPadding), BackgroundTransparency = 1 })
        end
    end

    if not (FFlagPromptsHandlerCoachmarkEnabled and bool3) then
        return var24
    end

    return React.createElement(React.Fragment, nil, {
        Slot = var24,
        Coachmarks = React.createElement(CoachmarkRenderer, { surfaceConfig = surfaceConfig, hasShownKey = entryPoint })
    })
end)

function var1.resetFetchedSessionsForTests()
    table.clear(tbl1)
    table.clear(tbl2)
end
return var1
