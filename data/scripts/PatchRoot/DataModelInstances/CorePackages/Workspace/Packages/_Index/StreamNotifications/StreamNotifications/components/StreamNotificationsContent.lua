-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T23:21:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local StreamNotifications = script:FindFirstAncestor("StreamNotifications")
local components = StreamNotifications.components

local StreamNotificationsParent = StreamNotifications.Parent
local constants = require(StreamNotifications.constants)
local Cryo = require(StreamNotificationsParent.Cryo)
local EventIngest = require(StreamNotificationsParent.Analytics).AnalyticsReporters.EventIngest
local EventIngestService = game:GetService("EventIngestService")
local eventIngest = EventIngest.new(EventIngestService)
local SessionService = game:GetService("SessionService")
local UserInputService = game:GetService("UserInputService")
local GuiService = game:GetService("GuiService")
local ThirdPartyUserService = game:GetService("ThirdPartyUserService")

local EmptyNotifications = require(components.EmptyNotifications)
local MetaActionsMenu = require(components.MetaActionsMenu)
local StreamNotificationAnimationWrapper = require(components.StreamNotificationAnimationWrapper)
local StreamNotificationBundleWrapper = require(components.StreamNotificationBundleWrapper)
local StreamNotificationsContentPage = require(components.StreamNotificationsContentPage)
local fetchStreamNotificationsContentPage = require(StreamNotifications.ContentPage.fetchStreamNotificationsContentPage)
local usePushPermissionClientAttributes = require(StreamNotifications.ContentPage.usePushPermissionClientAttributes)
local StreamPromptsBannerSlot = require(StreamNotifications.StreamPromptsBannerSlot)

local React = require(StreamNotificationsParent.React)
local NotificationsCommon = require(StreamNotificationsParent.NotificationsCommon)
local JoinExperience = NotificationsCommon.JoinExperience
local type = NotificationsCommon.type
local NotificationHelper = NotificationsCommon.NotificationHelper
local FFlagNotificationDeeplinkTapListenersEnabled = NotificationsCommon.FFlagNotificationDeeplinkTapListenersEnabled
local DeeplinkTapListeners = if FFlagNotificationDeeplinkTapListenersEnabled then NotificationsCommon.DeeplinkTapListeners else nil
local EnumStreamNotificationsDisplayState = require(StreamNotifications.EnumStreamNotificationsDisplayState)
local EnumStreamNotificationsLoadingMoreState = require(StreamNotifications.EnumStreamNotificationsLoadingMoreState)

local HttpRequest = require(StreamNotificationsParent.HttpRequest)
local FFlagLuaAppDefaultHttpRetry = require(StreamNotificationsParent.SharedFlags).FFlagLuaAppDefaultHttpRetry
local var1 = HttpRequest.config({
    requestFunction = HttpRequest.requestFunctions.HttpRbxApi,
    maxRetryCount = if FFlagLuaAppDefaultHttpRetry then game:DefineFastInt("StreamNotificationsContentHttpRetryCount", 4) else nil
})

local useDispatch = require(StreamNotificationsParent.RoactUtils).Hooks.RoactRodux.useDispatch

local UIBlox = require(StreamNotificationsParent.UIBlox)
local Foundation = require(StreamNotificationsParent.Foundation)
local IconSize = Foundation.Enums.IconSize
local Loading = Foundation.Loading

local useStyle = UIBlox.Core.Style.useStyle

local useClientTriggerEventHandler = require(StreamNotifications.eventHandler.useClientTriggerEventHandler)

local getStreamNotifications = require(StreamNotifications.utils.getStreamNotifications)
local clearUnreadNotifications = require(StreamNotifications.utils.clearUnreadNotifications)
local postNotificationsApi = require(StreamNotifications.utils.postNotificationsApi)
local postReportNotification = require(StreamNotifications.utils.postReportNotification)
local reportEvent = require(StreamNotifications.utils.reportEvent)
local sortNotifications = require(StreamNotifications.utils.sortNotifications)

local EventStream = require(StreamNotifications.analytics.analyticsService).EventStream
local analyticsConstants = require(StreamNotifications.analytics.analyticsConstants)

local CloseCentralOverlay = require(StreamNotificationsParent.CentralOverlay).Thunks.CloseCentralOverlay
local AbuseVector = require(StreamNotificationsParent.GenericAbuseReporting.AbuseVector)
local OpenDynamicAbuseReport = require(StreamNotificationsParent.GenericAbuseReporting.OpenDynamicAbuseReport)

local bool1 = game:DefineFastFlag("LuaAppNewStreamNotificationsLogFix", false)
local bool2 = game:DefineFastFlag("StreamNotificationFixInitialPageFill", false)
local FFlagStreamNotificationsSduiContentPage = require(StreamNotifications.Flags.FFlagStreamNotificationsSduiContentPage)

local SharedFlags = require(StreamNotificationsParent.SharedFlags)
local GetFStringPCGDKFilteredNotificationTypes = SharedFlags.GetFStringPCGDKFilteredNotificationTypes
local FFlagStreamNotificationsStandardizeClickEvents = SharedFlags.FFlagStreamNotificationsStandardizeClickEvents

local FFlagStreamNotificationImpressionLogging = SharedFlags.FFlagStreamNotificationImpressionLogging
local FFlagNotificationStreamPromptsHandlerEnabled = SharedFlags.FFlagNotificationStreamPromptsHandlerEnabled
local FrameBoundsImpressionsTracker = require(StreamNotificationsParent.Impressions).FrameBoundsImpressionsTracker

local function GetIsFriendCommunicationRestricted(): boolean | ThirdPartyUserService -- Luacid: Inlined by compiler; 1 call site recovered
    return ThirdPartyUserService
        and ThirdPartyUserService:IsChatRestrictionSupported()
        and ThirdPartyUserService.FriendCommunicationRestrictionStatus ~= Enum.ChatRestrictionStatus.NotRestricted
end

local StreamNotificationDropdownExperimentation = require(StreamNotifications.StreamNotificationDropdownExperimentation)

local function createImpressionSignal()
    local bindableEvent = Instance.new("BindableEvent")
    return {
        connect = function(_, arg1): RBXScriptConnection
            return bindableEvent.Event:Connect(arg1)
        end,
        fire = function()
            bindableEvent:Fire()
        end,
        destroy = function()
            bindableEvent:Destroy()
        end
    }
end

return function(tbl1)
    local var2 = useStyle()
    local dropdownEnabled = StreamNotificationDropdownExperimentation.getDropdownEnabled()
    local var3 = useDispatch()
    local var4 = useClientTriggerEventHandler()

    local var5, var6 = React.useState({})

    local activeNotification, var8 = React.useState(nil)

    local displayState, var10 = React.useState(EnumStreamNotificationsDisplayState.Initializing)

    local var11 = nil

    local var12 = nil

    local var13 = nil

    local var14 = tbl1.showOverlay or function(_: boolean) end

    local var15 = React.useRef(EnumStreamNotificationsLoadingMoreState.Loading)
    local var16, var17 = React.useState(EnumStreamNotificationsLoadingMoreState.Loading)
    local var18 = React.useRef(0)

    local var19 = React.useRef({})
    local var20 = React.useRef(0)
    local parentRef = React.useRef(nil)
    local var22 = React.useRef(if FFlagStreamNotificationImpressionLogging then createImpressionSignal() else nil)

    local num1 = if UserInputService.StatusBarSize then UserInputService.StatusBarSize.Y else 0
    local yOffset = constants.Modal.HeaderHeight + num1

    local var23 = React.useMemo(function()
        if not FFlagStreamNotificationImpressionLogging then
            return {
                byNotificationId = {},
                byIndex = {}
            }
        end
        local byNotificationId = {}
        local byIndex = ({})
        local tbl4 = ({})

        for impressionIndex, notification in ipairs(var5) do
            if notification.notificationSourceType ~= "Sendr" then
                continue
            end

            local bundleKey = notification.content.bundleKey
            local var23

            if bundleKey and bundleKey ~= "" then
                var23 = (tbl4[bundleKey] or 0) + 1
                tbl4[bundleKey] = var23
            else
                var23 = nil
            end

            local tbl5 = {
                impressionIndex = impressionIndex,
                bundlePosition = var23,
                notification = notification
            }
            byIndex[impressionIndex] = tbl5
            if notification.id then
                byNotificationId[notification.id] = tbl5
            end
        end

        return { byNotificationId = byNotificationId, byIndex = byIndex }
    end, { var5 })

    local clientAttributes = if FFlagStreamNotificationsSduiContentPage or FFlagNotificationStreamPromptsHandlerEnabled then usePushPermissionClientAttributes() else nil

    React.useEffect(function()
        var11()
    end, {})

    React.useEffect(function()
        if not FFlagStreamNotificationsSduiContentPage or clientAttributes == nil then
            return
        end
        fetchStreamNotificationsContentPage(clientAttributes)
    end, { clientAttributes })

    React.useEffect(function()
        if not FFlagStreamNotificationImpressionLogging then
            return
        end

        return function()
            if var22.current then
                var22.current:destroy()
            end
        end
    end, {})

    local function func1(current: string) -- Luacid: Inlined by compiler; 3 call sites recovered
        var15.current = current
        var17(current)
    end

    var11 = function()
        if var15.current == EnumStreamNotificationsLoadingMoreState.NoMoreNotifications then
            return
        end

        func1(EnumStreamNotificationsLoadingMoreState.Loading)
        getStreamNotifications(var1, constants.DefaultMaxRows, var18.current):andThen(function(arg1)
            arg1 = sortNotifications(arg1)
            local fStringPcgdkFilteredNotificationTypes = GetFStringPCGDKFilteredNotificationTypes()
            local tbl2 = {}

            for _, value in ipairs(arg1) do
                if not (fStringPcgdkFilteredNotificationTypes[value.content.notificationType] and GetIsFriendCommunicationRestricted()) then
                    table.insert(tbl2, value)
                end
            end

            local tbl3 = tbl2

            if tbl3 and #tbl3 > 0 then
                if bool2 then
                    for _, value in ipairs(tbl3) do
                        if value.notificationSourceType ~= "Sendr" then
                            continue
                        end

                        local bundleKey = value.content.bundleKey
                        local var25 = bundleKey and bundleKey ~= "" and bundleKey or value.id
                        if var25 and not var19.current[var25] then
                            var19.current[var25] = true
                            local var26 = var20
                            var26.current += 1
                        end
                    end
                end

                var6(function(arg2)
                    return (Cryo.List.join(arg2, tbl3))
                end)
                func1(EnumStreamNotificationsLoadingMoreState.Default)

                for _, value in ipairs(tbl3) do
                    NotificationHelper.fireEvent(
                        EventStream,
                        analyticsConstants.Context.fetched,
                        analyticsConstants.EventNames.notificationRetrieved,
                        Cryo.Dictionary.join(value.content.clientEventsPayload or {}, {
                            sendrVersion = constants.SENDRVersion,
                            notificationType = value.content.notificationType or nil,
                            notificationId = value.id or nil,
                            notificationState = if FFlagStreamNotificationsStandardizeClickEvents then value.content.currentState or nil else nil
                        })
                    )
                end
            else
                func1(EnumStreamNotificationsLoadingMoreState.NoMoreNotifications)
            end
            var10(EnumStreamNotificationsDisplayState.Default)
            clearUnreadNotifications(var1)
            local num2 = tonumber(var18.current) or 0
            var18.current = num2 + constants.DefaultMaxRows
            if bool2 then
                if var20.current < constants.DefaultMaxRows then
                    var11()
                end
            elseif var5 and #var5 < constants.DefaultMaxRows then
                var11()
            end
        end):catch(function(_)
            var10(EnumStreamNotificationsDisplayState.ErrorRetrieving)
        end)
    end

    local function func2(nextState: string, arg1)
        if dropdownEnabled then
            tbl1.displayStream(false)
        end

        local function func3() -- Luacid: Inlined by compiler; 1 call site recovered
            if dropdownEnabled then
                tbl1.displayStream(true)
            else
                tbl1.setDisplayScreenGuiEnabled(true)
            end
            var10(EnumStreamNotificationsDisplayState.Default)
        end

        var3(
            OpenDynamicAbuseReport({
                abuseVector = AbuseVector.Notifications,
                targetId = arg1.id,
                onSubmit = function()
                    postReportNotification(var1, arg1.id):andThen(function(_) end):catch(function(_) end)

                    var12(nextState, arg1)
                    if not dropdownEnabled then
                        tbl1.setDisplayScreenGuiEnabled(true)
                    end
                    var10(EnumStreamNotificationsDisplayState.Default)
                end,
                onClose = function()
                    var3(CloseCentralOverlay())
                    func3()
                end
            })
        )
    end

    local function func3(id: string?) -- Luacid: Inlined by compiler; 1 call site recovered
        var13()
        if not var5 or not id then
            return
        end

        local var25 = Cryo.List.map(var5, function(arg1)
            if arg1.id == id then
                arg1.dismiss = true
            end
            return arg1
        end)
        var6(var25)
    end

    local finishDismissNotification = React.useCallback(function(id: string)
        if var5 and id then
            local var25 = Cryo.List.filter(var5, function(arg1): boolean
                return not (arg1.id == id) and arg1.dismiss ~= true
            end)
            var6(var25)
        end
    end)

    local sendImpressions = React.useCallback(function(tbl2)
        if not FFlagStreamNotificationImpressionLogging then
            return
        end
        for _, value in ipairs(tbl2) do
            local var26 = var23.byIndex[value]
            local notification = if var26 then var26.notification else nil

            if not notification then
                continue
            end

            NotificationHelper.fireEvent(
                EventStream,
                analyticsConstants.Context.impression,
                analyticsConstants.EventNames.notificationImpression,
                Cryo.Dictionary.join(notification.content.clientEventsPayload or {}, {
                    sendrVersion = constants.SENDRVersion,
                    notificationType = notification.content.notificationType or nil,
                    notificationId = notification.id or nil,
                    notificationState = if FFlagStreamNotificationsStandardizeClickEvents then notification.content.currentState or nil else nil,
                    bundlePosition = var26.bundlePosition or nil,
                    bundleKey = notification.content.bundleKey or nil
                })
            )
        end
    end, { var23 })

    local handleActions = React.useCallback(function(arg1, arg2)
        local var27 = arg2 or activeNotification
        var8(var27)
        NotificationHelper.fireEvent(
            EventStream,
            analyticsConstants.Context.click,
            arg1.eventName or "",
            Cryo.Dictionary.join(arg1.clientEventsPayload or {}, {
                notifType = if FFlagStreamNotificationsStandardizeClickEvents or not bool1 then nil else var27 and var27.content and var27.content.notificationType,
                notifId = if FFlagStreamNotificationsStandardizeClickEvents or not bool1 then nil else var27 and var27.id,
                notificationType = if FFlagStreamNotificationsStandardizeClickEvents then var27 and var27.content and var27.content.notificationType else nil,
                notificationId = if FFlagStreamNotificationsStandardizeClickEvents then var27 and var27.id else nil,
                notificationState = if FFlagStreamNotificationsStandardizeClickEvents then var27 and var27.content and var27.content.currentState else nil,
                visualItemType = arg1.visualItemType or nil,
                visualItemName = arg1.visualItemName or nil,
                sendrVersion = constants.SENDRVersion
            })
        )

        if not arg1.actions or not (#arg1.actions > 0) or not var27 then
            return
        end

        for _, action in ipairs(arg1.actions) do
            if not action.actionType then
                continue
            end
            if action.actionType == type.ActionTypeEnum.Deeplink then
                if FFlagNotificationDeeplinkTapListenersEnabled then
                    DeeplinkTapListeners.notify({
                        notificationType = var27.content and var27.content.notificationType,
                        notificationId = var27.id,
                        url = action.path or "",
                        source = "stream",
                        isInExperience = false
                    })
                end

                if JoinExperience(action.path, false) then
                    tbl1.displayStream(false)
                    SessionService:SetSession(
                        constants.StreamSessionStructuralIdentifier.Level1,
                        constants.StreamSessionStructuralIdentifier.StreamNotification,
                        constants.StreamSessionStructuralIdentifier.StreamNotification
                    )
                    SessionService:SetMetadata(
                        constants.StreamSessionStructuralIdentifier.StreamNotification,
                        constants.StreamSessionStructuralIdentifier.DeleteOnGameLeave,
                        "True"
                    )
                    reportEvent(eventIngest, {
                        action_type = action.actionType,
                        delivery_channel = constants.DeliveryChannel,
                        notification_type = var27.notificationSourceType,
                        notification_id = var27.id
                    })
                end
            elseif action.actionType == type.ActionTypeEnum.NotificationApi then
                local id = if var27 then var27.id or nil else nil
                local path = action.path or nil
                postNotificationsApi(var1, id, path):andThen(function(_)
                    if action.nextState ~= nil and action.nextState ~= "" then
                        var12(action.nextState, var27)
                    end
                end):catch(function(_) end)

                var13()
            elseif action.actionType == type.ActionTypeEnum.Report then
                var10(EnumStreamNotificationsDisplayState.AbuseReport)
                func2(action.nextState, var27)
            elseif action.actionType == type.ActionTypeEnum.Dismiss then
                func3(var27.id)
            elseif action.actionType == type.ActionTypeEnum.ClientTrigger then
                if action.path == "TrustedContactsDoubleOptInModal" then
                    tbl1.displayStream(false)
                end
                local var28 = var4
                local path = action.path
                local tbl2 = {
                    clientEventsPayload = var27.content.clientEventsPayload,
                    callback = 0
                }

                function tbl2.callback()
                    var12(action.nextState, var27)
                end

                var28(path, tbl2)
            end
        end
    end)

    local function openMetaActions(arg1)
        var8(arg1)
        var10(EnumStreamNotificationsDisplayState.MetaActions)
        NotificationHelper.fireEvent(
            EventStream,
            analyticsConstants.Context.click,
            analyticsConstants.EventNames.openMetaActions,
            {
                visualItemType = NotificationsCommon.type.VisualItemTypeEnum.MetaAction,
                sendrVersion = constants.SENDRVersion,
                notificationState = if FFlagStreamNotificationsStandardizeClickEvents then arg1 and arg1.content and arg1.content.currentState or nil else nil
            }
        )
    end

    var13 = function()
        var14(true)
        var8(nil)
        if displayState == EnumStreamNotificationsDisplayState.MetaActions then
            NotificationHelper.fireEvent(
                EventStream,
                analyticsConstants.Context.click,
                analyticsConstants.EventNames.closeMetaActions,
                {
                    visualItemType = NotificationsCommon.type.VisualItemTypeEnum.MetaAction,
                    sendrVersion = constants.SENDRVersion
                }
            )
        end
        var10(EnumStreamNotificationsDisplayState.Default)
    end

    var12 = function(currentState: string, arg1)
        local tbl2 = {}
        if var5 and arg1 then
            for _, value in ipairs(var5) do
                if value.id == arg1.id then
                    value.content.currentState = currentState
                end
                table.insert(tbl2, value)
            end
        end
        var6(tbl2)
    end

    local var28 = React.useMemo(function()
        return React.createElement(MetaActionsMenu, {
            displayState = displayState,
            activeNotification = activeNotification,
            isSmallScreen = tbl1.isSmallScreen,
            handleActions = handleActions,
            closeNotificationDisplay = var13
        })
    end, { displayState, activeNotification })

    local var29 = React.useMemo(function()
        if displayState == EnumStreamNotificationsDisplayState.Initializing then
            return React.createElement(
                Loading,
                {
                    size = IconSize.Large,
                    Position = UDim2.fromScale(0.5, 0.5),
                    AnchorPoint = Vector2.new(0.5, 0.5)
                }
            )
        end

        if var5 and #var5 > 0 then
            local tbl2 = ({})
            tbl2.UIListLayout = React.createElement("UIListLayout", {
                FillDirection = Enum.FillDirection.Vertical,
                SortOrder = Enum.SortOrder.LayoutOrder,
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                Padding = if dropdownEnabled then UDim.new(0, constants.Dropdown.CardGap) else nil
            })
            if dropdownEnabled then
                tbl2.UIPadding = React.createElement("UIPadding", { PaddingRight = UDim.new(0, constants.Dropdown.ScrollBarThickness) })
            end

            if FFlagStreamNotificationsSduiContentPage then
                tbl2.SduiContentPage = React.createElement(StreamNotificationsContentPage, { LayoutOrder = 0 })
            end

            local bool3 = false

            local tbl3 = ({})

            for _, value in ipairs(var5) do
                if value.notificationSourceType ~= "Sendr" then
                    continue
                end

                bool3 = true

                local bundleKey = value.content.bundleKey
                if not bundleKey or bundleKey == "" then
                    continue
                end

                if tbl3[bundleKey] then
                    table.insert(tbl3[bundleKey], value)
                else
                    tbl3[bundleKey] = { value }
                end
            end

            for layoutOrder, notification in ipairs(var5) do
                if notification.notificationSourceType ~= "Sendr" then
                    continue
                end

                local bundleKey = notification.content.bundleKey

                if bundleKey and bundleKey ~= "" and #tbl3[bundleKey] > 1 then
                    if not tbl2[bundleKey] then
                        tbl2[bundleKey] = React.createElement(StreamNotificationBundleWrapper, {
                            layoutOrder = layoutOrder,
                            notifications = tbl3[bundleKey],
                            finishDismissNotification = finishDismissNotification,
                            handleActions = handleActions,
                            openMetaActions = openMetaActions,
                            impressionsTag = if FFlagStreamNotificationImpressionLogging then "StreamNotificationImpression" else nil,
                            impressionMetadataByNotificationId = if FFlagStreamNotificationImpressionLogging then var23.byNotificationId else nil
                        }, {})
                    end
                else
                    local var29 = if FFlagStreamNotificationImpressionLogging then var23.byNotificationId[notification.id] else nil
                    local id = notification.id
                    tbl2[id] = React.createElement(StreamNotificationAnimationWrapper, {
                        layoutOrder = layoutOrder,
                        notification = notification,
                        finishDismissNotification = finishDismissNotification,
                        handleActions = handleActions,
                        openMetaActions = openMetaActions,
                        collapsed = false,
                        impressionsTag = if FFlagStreamNotificationImpressionLogging then "StreamNotificationImpression" else nil,
                        impressionIndex = if FFlagStreamNotificationImpressionLogging then var29 and var29.impressionIndex or nil else nil
                    }, {})
                end
            end

            if var15.current == EnumStreamNotificationsLoadingMoreState.Loading then
                tbl2.LoadingMore = React.createElement("Frame", {
                    Size = UDim2.new(1, 0, 0, constants.LoadingMoreNotifications.Size),
                    BackgroundTransparency = 1,
                    LayoutOrder = math.huge
                }, {
                    LoadingMoreSpinner = React.createElement(
                        Loading,
                        {
                            size = IconSize.Small,
                            Position = UDim2.fromScale(0.5, 0.5),
                            AnchorPoint = Vector2.new(0.5, 0.5)
                        }
                    )
                })
            end

            if bool3 then
                return React.createElement("Frame", {
                    Size = if dropdownEnabled then UDim2.new(1, 0, 0, 0) else UDim2.new(1, 0, 0, -yOffset),
                    AutomaticSize = Enum.AutomaticSize.Y,
                    BackgroundTransparency = 1
                }, tbl2)
            end
        end

        if not FFlagStreamNotificationsSduiContentPage then
            return React.createElement(EmptyNotifications)
        end

        return React.createElement("Frame", {
            Size = UDim2.fromScale(1, 1),
            BackgroundTransparency = 1
        }, {
            UIListLayout = React.createElement("UIListLayout", {
                FillDirection = Enum.FillDirection.Vertical,
                SortOrder = Enum.SortOrder.LayoutOrder,
                HorizontalAlignment = Enum.HorizontalAlignment.Center
            }),
            SduiContentPage = React.createElement(StreamNotificationsContentPage, { LayoutOrder = 1 }),
            EmptyState = React.createElement(
                "Frame",
                {
                    Size = UDim2.fromScale(1, 0),
                    BackgroundTransparency = 1,
                    LayoutOrder = 2
                },
                {
                    UIFlexItem = React.createElement("UIFlexItem", { FlexMode = Enum.UIFlexMode.Fill }),
                    EmptyNotifications = React.createElement(EmptyNotifications)
                }
            )
        })
    end, {
        var5,
        displayState,
        var16,
        dropdownEnabled,
        var23
    })
    local function func5(arg1)
        local absoluteCanvasSizeY = arg1.AbsoluteCanvasSize.Y
        local absoluteWindowSizeY = arg1.AbsoluteWindowSize.Y
        local canvasPositionY = arg1.CanvasPosition.Y

        if absoluteWindowSizeY == 0 or absoluteCanvasSizeY == 0 or displayState ~= EnumStreamNotificationsDisplayState.Default then
            return
        end

        if FFlagStreamNotificationImpressionLogging and var22.current then
            var22.current:fire()
        end

        if absoluteCanvasSizeY - absoluteWindowSizeY - constants.LoadingMoreNotifications.TriggerDistance <= canvasPositionY
            and var15.current == EnumStreamNotificationsLoadingMoreState.Default
        then
            var11()
        end
    end

    if FFlagNotificationStreamPromptsHandlerEnabled then
        local createElement = React.createElement
        local str1 = "Frame"
        local tbl2 = {
            Size = UDim2.fromScale(1, 1),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1
        }
        local tbl3 = {
            Layout = React.createElement("UIListLayout", {
                FillDirection = Enum.FillDirection.Vertical,
                SortOrder = Enum.SortOrder.LayoutOrder,
                HorizontalAlignment = Enum.HorizontalAlignment.Center
            }),
            PromptsBanner = 0,
            Content = 0
        }
        local createElement2 = React.createElement
        local str2 = "Frame"
        local tbl4 = {
            LayoutOrder = 0,
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1
        }
        local tbl5 = {
            Banner = React.createElement(StreamPromptsBannerSlot.get(), {
                clientAttributes = clientAttributes,
                bottomPadding = if dropdownEnabled then constants.Dropdown.CardGap else constants.DefaultPadding
            })
        }
        tbl3.PromptsBanner = createElement2(str2, tbl4, tbl5)

        tbl3.Content = React.createElement(
            "Frame",
            {
                LayoutOrder = 1,
                Size = UDim2.new(1, 0, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundTransparency = 1
            },
            {
                UIFlexItem = React.createElement("UIFlexItem", { FlexMode = Enum.UIFlexMode.Fill }),
                Notifications = var29
            }
        )
        var29 = createElement(str1, tbl2, tbl3)
    end

    local num2 = if UserInputService.BottomBarSize then UserInputService.BottomBarSize.Y else 0
    local var30 = if GuiService:GetSafeZoneOffsets() then GuiService:GetSafeZoneOffsets().bottom else 0
    local num3 = if tbl1.isSmallScreen then math.max(num2, var30) else 0

    if dropdownEnabled then
        local createElement = React.createElement
        local tbl2 = {
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            LayoutOrder = 2,
            ClipsDescendants = true
        }

        local tbl3 = {
            MetaActionsOpen = React.createElement("TextButton", {
                Size = UDim2.new(1, 0, 1, 0),
                Position = UDim2.new(0.5, 0, 0.5, 0),
                AnchorPoint = Vector2.new(0.5, 0.5),
                Visible = displayState == EnumStreamNotificationsDisplayState.MetaActions,
                BackgroundTransparency = var2.Theme.Overlay.Transparency,
                BackgroundColor3 = var2.Theme.Overlay.Color,
                Text = "",
                AutoButtonColor = false,
                ZIndex = 2,
                [React.Event.Activated] = var13,
                BorderSizePixel = 0,
                Selectable = false
            }, { var28 }),
            NotificationsList = React.createElement("ScrollingFrame", {
                Size = UDim2.new(
                    1,
                    0,
                    0,
                    (tbl1.dropdownHeight or constants.Dropdown.MaxHeight) - constants.Dropdown.HeaderMinHeight - constants.Dropdown.HeaderBodyGap
                ),
                CanvasSize = UDim2.new(1, 0, 0, 0),
                BackgroundTransparency = 1,
                ScrollBarThickness = constants.Dropdown.ScrollBarThickness,
                BorderSizePixel = 0,
                VerticalScrollBarInset = Enum.ScrollBarInset.None,
                VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Right,
                ScrollBarImageColor3 = var2.Theme.UIEmphasis.Color,
                AutomaticCanvasSize = Enum.AutomaticSize.Y,
                ElasticBehavior = Enum.ElasticBehavior.Always,
                ScrollingEnabled = displayState == EnumStreamNotificationsDisplayState.Default,
                ScrollingDirection = Enum.ScrollingDirection.Y,
                [React.Change.CanvasPosition] = func5,
                Selectable = false
            }, var29)
        }
        return createElement("Frame", tbl2, tbl3)
    end

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        Size = UDim2.new(1, 0, 1, 0),
        Position = UDim2.new(0.5, 0, 0, 0),
        AnchorPoint = Vector2.new(0.5, 0),
        BackgroundTransparency = 1
    }
    local tbl3 = {
        MetaActionsOpen = React.createElement("TextButton", {
            Size = UDim2.new(1, 0, 1, 0),
            Position = UDim2.new(0.5, 0, 0.5, 0),
            AnchorPoint = Vector2.new(0.5, 0.5),
            Visible = displayState == EnumStreamNotificationsDisplayState.MetaActions,
            BackgroundTransparency = var2.Theme.Overlay.Transparency,
            BackgroundColor3 = var2.Theme.Overlay.Color,
            Text = "",
            AutoButtonColor = false,
            ZIndex = 2,
            [React.Event.Activated] = var13,
            BorderSizePixel = 0,
            Selectable = false
        }, { var28 }),
        NotificationsList = React.createElement("ScrollingFrame", {
            ref = if FFlagStreamNotificationImpressionLogging then parentRef else nil,
            Size = UDim2.new(1, 0, 1, -(yOffset + constants.DefaultPadding + num3)),
            CanvasSize = UDim2.new(1, 0, 1, -(yOffset + constants.DefaultPadding + num3)),
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 0, 0, yOffset),
            AnchorPoint = Vector2.new(0, 0),
            ScrollBarThickness = 4,
            BorderSizePixel = 0,
            VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar,
            VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Right,
            ScrollBarImageColor3 = var2.Theme.UIEmphasis.Color,
            AutomaticCanvasSize = Enum.AutomaticSize.XY,
            ElasticBehavior = Enum.ElasticBehavior.Always,
            ScrollingEnabled = displayState == EnumStreamNotificationsDisplayState.Default,
            ScrollingDirection = Enum.ScrollingDirection.Y,
            [React.Change.CanvasPosition] = func5,
            Selectable = false
        }, var29),
        ImpressionTracker = if FFlagStreamNotificationImpressionLogging then React.createElement(
            FrameBoundsImpressionsTracker,
            {
                parentRef = parentRef,
                pageContext = nil,
                impressionsTag = "StreamNotificationImpression",
                scrollViewPositionChangedSignal = var22.current,
                sendImpressions = sendImpressions
            }
        ) else nil
    }
    return createElement(str1, tbl2, tbl3)
end
