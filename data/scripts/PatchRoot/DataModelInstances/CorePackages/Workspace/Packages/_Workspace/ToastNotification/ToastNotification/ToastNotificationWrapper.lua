-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T19:40:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local GuiService = game:GetService("GuiService")
local HttpService = game:GetService("HttpService")
local UserGameSettings = UserSettings():GetService("UserGameSettings")
local ThirdPartyUserService = game:GetService("ThirdPartyUserService")

local TouchEnabled = UserInputService.TouchEnabled

local scriptParent = script.Parent
local Components = scriptParent.Components
local context = scriptParent.context
local utils = scriptParent.utils
local Logger = require(scriptParent.Logger)
local toastNotificationHelper = require(utils.toastNotificationHelper)
local toastNotificationSessionizationHelper = require(utils.toastNotificationSessionizationHelper)
local scriptParentParent = scriptParent.Parent
local NotificationsCommon = require(scriptParentParent.NotificationsCommon)
local React = require(scriptParentParent.React)
local UIBlox = require(scriptParentParent.UIBlox)
local Cryo = require(scriptParentParent.Cryo)
local IsVRAppBuild = require(scriptParentParent.AppCommonLib).IsVRAppBuild
local isTenFootInterface = require(scriptParentParent.AppCommonLib).isTenFootInterface
local Responsive = require(scriptParentParent.Responsive)
local usePreferredInput = Responsive.usePreferredInput
local useIsSpatial = Responsive.useIsSpatial
local ReactOtter = require(scriptParentParent.ReactOtter)

local LifecycleEvents = require(script.Parent.utils.LifecycleEvents)
local ToastNotificationProtocol = require(scriptParentParent.ToastNotificationsProtocol).ToastNotificationProtocol
local Images = UIBlox.App.ImageSet.Images
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local useStyle = UIBlox.Core.Style.useStyle
local SharedFlags = require(scriptParentParent.SharedFlags)

local analyticsService = require(scriptParent.analytics.analyticsService)

local NotificationCardProvider = require(context.NotificationCardProvider)
local NotificationCard = require(Components.NotificationCard)
local ToastNotificationSnoozeMenu = require(Components.ToastNotificationSnoozeMenu)
local DeeplinkConfirmationModal = NotificationsCommon.DeeplinkConfirmationModal
local SwipeDetectionWrapper = require(Components.SwipeDetectionWrapper)
local ToastVRWrapper = require(Components.ToastVRWrapper)
local ClientNotificationWrapper = require(Components.ClientNotificationWrapper)
local useKeyCodeHold = require(Components.useKeyCodeHold)
local type = require(scriptParent.type)
local constants = require(scriptParent.constants)
local JoinExperience = NotificationsCommon.JoinExperience
local FFlagNotificationDeeplinkTapListenersEnabled = NotificationsCommon.FFlagNotificationDeeplinkTapListenersEnabled
local DeeplinkTapListeners = if FFlagNotificationDeeplinkTapListenersEnabled then NotificationsCommon.DeeplinkTapListeners else nil
local SpringAnimatedItem = UIBlox.Utility.SpringAnimatedItem
local iconsNavigationClose = Images["icons/navigation/close"]

local GetFFlagEnableChatNewMessage = SharedFlags.GetFFlagEnableChatNewMessage
local engineFeature = game:GetEngineFeature("ClientToastNotificationsEnabled")

local bool1 = game:DefineFastFlag("EnableClientToastNotificationsReducedMotion", false)
local bool2 = game:DefineFastFlag("EnableNotificationsToastTTLFix", false)

local default = require(scriptParent.ToastNotificationSnoozeManager).default
local GetFStringPCGDKFilteredNotificationTypes = SharedFlags.GetFStringPCGDKFilteredNotificationTypes
local function GetIsFriendCommunicationRestricted(): boolean | ThirdPartyUserService -- Luacid: Inlined by compiler; 1 call site recovered
    return ThirdPartyUserService
        and ThirdPartyUserService:IsChatRestrictionSupported()
        and ThirdPartyUserService.FriendCommunicationRestrictionStatus ~= Enum.ChatRestrictionStatus.NotRestricted
end

local GetFFlagFilterSecurityAlertsVRToastEnabled = SharedFlags.GetFFlagFilterSecurityAlertsVRToastEnabled

local bool3 = game:DefineFastFlag("EnableDisplayLoggingForToastsFix", false)

local IXPServiceWrapper = require(scriptParentParent.IXPServiceWrapper).IXPServiceWrapper
local FFlagFriendshipNotifsUseSendrExperiment = SharedFlags.FFlagFriendshipNotifsUseSendrExperiment

local str1 = game:DefineFastString("FriendshipNotifsUseSendrLayerName", "Notification.Toast")
local str2 = game:DefineFastString("FRRToastPositionVariantKey", "frrToastPositionVariant")

local bool4 = false
local var1 = nil
local var2 = nil

local function getFRRToastPositionVariant() -- Luacid: Inlined by compiler; 2 call sites recovered
    if FFlagFriendshipNotifsUseSendrExperiment and not bool4 then
        var1, var2 = pcall(function()
            bool4 = true
            return IXPServiceWrapper:GetLayerData(str1)
        end)
    end

    return if var1 and var2 then var2[str2] else nil
end

local springOptions = { frequency = 4, damping = 1 }

local getDeviceOrientation = toastNotificationHelper.getDeviceOrientation
local getNotificationSize = toastNotificationHelper.getNotificationSize
local marshalNotificationData = toastNotificationHelper.marshalNotificationData
local calculateToastPosition = toastNotificationHelper.calculateToastPosition
local isToastToRight = toastNotificationHelper.isToastToRight
local calculateTimeRemaining = toastNotificationHelper.calculateTimeRemaining

return function(tbl2)
    local bool5 = tbl2.renderLocation == type.RenderLocationEnum.CoreScript
    local var3 = toastNotificationHelper.isDesktopDevice()
    local var4 = if bool5 then constants.CardTopMargin.Experience else constants.CardTopMargin.App
    local default2 = ToastNotificationProtocol.default

    local function func1(): Vector2 -- Luacid: Inlined by compiler; 8 call sites recovered
        return workspace.CurrentCamera.ViewportSize
    end

    local function func2(bool6: boolean): boolean -- Luacid: Inlined by compiler; 4 call sites recovered
        return bool6 and func1().X < constants.CompactCardThreashold
    end

    local var5, var6 = React.useState(UserGameSettings.ReducedMotion)
    local var7, var8 = React.useState(getNotificationSize(bool5, func1().X))
    local var9, var10 = React.useState(getDeviceOrientation((func1())))

    local var11, var12 = React.useState(if FFlagFriendshipNotifsUseSendrExperiment then func1() else nil)
    local var13, var14 = React.useState(false)

    local notificationData, var16 = React.useState(nil)

    local var17, var18 = React.useState(nil)

    local animatedValues, var20 = React.useState(calculateToastPosition(false, isToastToRight(var9), var4, var5))

    local var21, var22 = React.useState(nil)
    local var23, var24 = React.useState(nil)
    local isCompact, var26 = React.useState(function(): boolean
        return bool5 and func2(true)
    end)

    local var27, var28 = React.useState(false)
    local isConfirmModalOpen, var30 = React.useState(false)
    local var31, var32 = React.useState(false)
    local var33 = React.useRef(false)
    local var34, onHover = React.useState(false)
    local var36, var37 = React.useState(false)
    local var38, onPause = React.useState(false)
    local var40, var41 = React.useState({})
    local var42 = useIsSpatial()

    local showHoldButton = usePreferredInput() == Responsive.Input.Directional

    local var43, var44 = React.useState(false)
    local shouldAutoFocus = var43
    local var46 = var44

    local var47 = React.useMemo(function()
        return not showHoldButton or shouldAutoFocus or notificationData == nil
    end, { showHoldButton, shouldAutoFocus, notificationData })

    React.useEffect(function()
        if not shouldAutoFocus then
            return
        end

        local connection = UserInputService.InputBegan:Connect(function(input: InputObject, gameProcessedEvent: boolean)
            if gameProcessedEvent then
                return
            end

            if input.KeyCode == Enum.KeyCode.ButtonB then
                var46(false)
            end
        end)

        return function()
            connection:Disconnect()
        end
    end, { shouldAutoFocus })

    local var48 = React.useCallback(function()
        var46(true)
    end, {})
    local var49 = useKeyCodeHold(
        Enum.KeyCode.ButtonSelect,
        constants.SIGNAL_HOLD_INTENT_SECONDS,
        constants.SIGNAL_HOLD_COMPLETE_SECONDS,
        var48,
        var47
    )

    local holdProgress = var49.holdProgress
    local holding = var49.holding

    local var50, var51 = React.useState(Instance.new("BindableEvent"))
    local var52 = useStyle()

    local function func3() -- Luacid: Inlined by compiler; 2 call sites recovered
        local viewportSize = workspace.CurrentCamera.ViewportSize
        local deviceOrientation = getDeviceOrientation(viewportSize)
        local notificationSize = getNotificationSize(bool5, viewportSize.X)
        var8(notificationSize)
        var26(bool5 and func2(true))
        var10(deviceOrientation)
    end

    local function func4(str3: string) -- Luacid: Inlined by compiler; 9 call sites recovered
        default2:dismissNotification(str3)
    end

    local isHover = var34 or var36
    local userId = if Players and Players.LocalPlayer then Players.LocalPlayer.UserId or nil else nil

    local function func5(actionType: string, recipientUserid: number?, arg1)
        if arg1 == nil then
            return
        end

        Logger:info("NotificationType: {} with event: {}", arg1.notificationType, actionType)

        local eventStream = analyticsService.EventStream

        toastNotificationSessionizationHelper(actionType)

        local timeToActionTimestamp = if arg1 and arg1.displayTimestamp then DateTime.now().UnixTimestampMillis - arg1.displayTimestamp else 0

        toastNotificationHelper.fireEvent(
            eventStream,
            Cryo.Dictionary.join({
                action_type = actionType,
                delivery_channel = constants.DeliveryChannel,
                notification_type = if arg1 then arg1.notificationType or nil else nil,
                notification_id = if arg1 then arg1.id or nil else nil,
                recipient_userid = recipientUserid or nil,
                recipient_universe_id = if bool5 then game and game.GameId else nil,
                client_destination = if bool5 then constants.Destinations.Experience else constants.Destinations.App,
                deliver_timestamp = if arg1 then arg1.deliverTimestamp or nil else nil,
                snoozed = if arg1 and arg1.notificationType then default:isSnoozedNotificationType(arg1.notificationType) else false,
                time_to_action_timestamp = timeToActionTimestamp,
                frr_toast_position_variant = if FFlagFriendshipNotifsUseSendrExperiment and arg1.notificationType == type.NotificationTypeEnum.FriendRequestReceived then getFRRToastPositionVariant() else nil
            }, not arg1 and {} or arg1.clientEventsPayload or {})
        )
    end

    React.useEffect(function()
        local connection = UserGameSettings.Changed:Connect(function(arg1)
            if arg1 ~= "ReducedMotion" then
                return
            end

            local success, result = pcall(function()
                return UserGameSettings[arg1]
            end)

            if success then
                var6(result)
            end
        end)

        return function()
            if connection then
                connection:Disconnect()
            end
        end
    end, { var6, UserGameSettings })

    local function closeCallback(bool7: boolean)
        if not bool7 then
            func5(type.ToastNotificationActionsEnum.ModalCancel, userId, notificationData)
            var30(false)
        end
        if var50 then
            func5(type.ToastNotificationActionsEnum.ModalConfirm, userId, notificationData)
            var50:Fire(bool7)
        end
    end

    local var54 = React.useCallback(function()
        if var21 then
            task.cancel(var21)
        end
        var22(nil)
    end, { var21 })

    local function func7(str3: string) -- Luacid: Inlined by compiler; 3 call sites recovered
        func4(str3)
        var18(nil)
        var54()
    end

    local function func8(arg1) -- Luacid: Inlined by compiler; 3 call sites recovered
        local timeOnScreenMs = arg1.state and arg1.state.timeOnScreenMs
        return (timeOnScreenMs and timeOnScreenMs / 1000 or constants.DefaultNotificationDisplayTime) + 1
    end

    local var55 = bool2 and function(notificationId: string, num1: number, arg1)
        var54()
        local var55 = task.delay(num1, function()
            if var33.current then
                var54()
                return
            end

            func5(type.ToastNotificationActionsEnum.Ignored, userId, arg1)
            if engineFeature and arg1 and arg1.luaNotifInfo then
                GuiService:DismissNotification(notificationId)
                return
            end
            func7(notificationId)
        end)

        var22(var55)
    end or React.useCallback(function(notificationId: string, num1: number, arg1)
        var54()
        local var55 = task.delay(num1, function()
            if var31 then
                return
            end

            func5(type.ToastNotificationActionsEnum.Ignored, userId, arg1)

            if engineFeature and arg1 and arg1.luaNotifInfo then
                GuiService:DismissNotification(notificationId)
                return
            end
            func7(notificationId)
        end)

        var22(var55)
    end, { var31 })

    local var56 = React.useCallback(function()
        if not notificationData or not var17 or var17.id ~= notificationData.id then
            return
        end

        if engineFeature and notificationData.luaNotifInfo then
            GuiService:DismissNotification(notificationData.id)
            return
        end
        func7(notificationData.id)
    end, { notificationData, var17 })

    local function func9() -- Luacid: Inlined by compiler; 1 call site recovered
        func5(type.ToastNotificationActionsEnum.Dismissed, userId, notificationData)
        var56()
        var37(false)
    end

    local var57 = React.useCallback(function()
        if not (bool5 and var50) then
            return true
        end

        var30(true)
        return var50.Event:Wait()
    end, { bool5, var50 })

    local function func10()
        if notificationData and var17 and not var21 then
            var55(notificationData.id, func8(notificationData), notificationData)
        end
    end

    local var58 = bool2 and function(bool7: boolean, ...)
        if bool7 then
            var54()
        elseif notificationData and var17 and not var21 then
            var55(notificationData.id, func8(notificationData), notificationData)
        end
    end or function(bool7: boolean, callback: (...any) -> (...any), callback2: (...any) -> (...any))
        if bool7 then
            callback()
            return
        end
        callback2()
    end

    local var59 = React.useCallback(function()
        for _, value in ipairs(var40) do
            task.cancel(value)
        end
    end, { var40 })

    React.useEffect(function()
        return function()
            var59()
        end
    end, { var59 })

    local var60 = React.useCallback(function(arg1, arg2, bool7: boolean?)
        if arg1.actionType == type.ActionTypeEnum.Dismiss then
            var56()
            return
        end

        if arg1.actionType ~= type.ActionTypeEnum.Deeplink then
            if arg1.actionType == type.ActionTypeEnum.VoltronBroadcast then
                local success, result = pcall(function()
                    return HttpService:JSONDecode(arg1.parameters)
                end)

                if success then
                    default2:voltronBroadcast(arg1.messageId, result)
                    return
                end
                Logger:warning("Invalid decoded payload for voltronBroadcast")
                return
            end

            if arg1.actionType == type.ActionTypeEnum.UpdateState
                and arg1.nextState ~= nil
                and arg1.nextState ~= ""
                and arg2
                and arg2.id
            then
                ToastNotificationProtocol:updateNotification(arg2.id, arg1.nextState)
            end

            return
        end

        if not var57() then
            return
        end
        if FFlagNotificationDeeplinkTapListenersEnabled and bool7 then
            DeeplinkTapListeners.notify({
                notificationType = arg2 and arg2.notificationType,
                notificationId = arg2 and arg2.id,
                url = arg1.path or "",
                source = "toast",
                isInExperience = bool5
            })
        end
        if not JoinExperience(arg1.path or "", bool5) then
            func5(type.ToastNotificationActionsEnum.DeeplinkFailed, userId, arg2)

            var56()
            return
        end

        var30(false)
        if arg2 then
            func4(arg2.id)
        end
    end, { var56, var57 })

    local var61 = React.useCallback(function(arg1)
        local function executeAllActions(actions) -- Luacid: Inlined by compiler; 2 call sites recovered
            for _, action in ipairs(actions) do
                var60(action, arg1)
            end
        end

        var59()
        if not arg1.timers then
            return
        end

        local tbl3 = {}
        for _, timer in pairs(arg1.timers) do
            local timeRemaining = calculateTimeRemaining(timer, arg1.notificationReceivedTimestampMs, arg1.displayTimestamp)

            if timeRemaining > 0 then
                table.insert(tbl3, (task.delay(timeRemaining / 1000, function()
                    executeAllActions(timer.actions)
                end)))
            else
                executeAllActions(timer.actions)
            end
        end

        if #tbl3 > 0 then
            var41(tbl3)
        end
    end, { var60, var59, calculateTimeRemaining })

    local handleActions = React.useCallback(function(visualItem)
        if var27 then
            return
        end
        var28(true)
        if visualItem.eventName then
            func5(visualItem.eventName, userId, notificationData)
        end

        if visualItem.actionEventParams and notificationData then
            LifecycleEvents:DispatchEvent(LifecycleEvents.ToastEvents.UserAction, notificationData.notificationType, {
                notificationData = notificationData,
                visualItem = visualItem,
                userActionType = "click",
                parameters = visualItem.actionEventParams
            })
        end

        if visualItem.actions and #visualItem.actions > 0 then
            for _, action in ipairs(visualItem.actions) do
                var60(action, notificationData, if FFlagNotificationDeeplinkTapListenersEnabled then true else nil)

                if action.actionType == type.ActionTypeEnum.Deeplink and var57() then
                    break
                end
            end
        end

        var28(false)
    end, {
        notificationData,
        var56,
        var27,
        var57
    })

    local function func11(arg1, str3: string)
        arg1.displayTimestamp = DateTime.now().UnixTimestampMillis

        if GetFStringPCGDKFilteredNotificationTypes()[arg1.notificationType] and GetIsFriendCommunicationRestricted() then
            func4(arg1.id)
            return
        end

        local actionType = if str3 == "update" then type.ToastNotificationActionsEnum.Update else type.ToastNotificationActionsEnum.Display

        if bool3 then
            if default:isSnoozedNotificationType(arg1.notificationType) then
                func4(arg1.id)
                return
            end
            func5(actionType, userId, arg1)
        else
            func5(actionType, userId, arg1)

            if default:isSnoozedNotificationType(arg1.notificationType) then
                func4(arg1.id)
                return
            end
        end

        var16(arg1)
        local var63 = func8(arg1)
        var55(arg1.id, var63, arg1)
        if str3 == "display" then
            var61(arg1)
        end
        if engineFeature and arg1 and arg1.luaNotifInfo then
            GuiService:OnNotificationDisplayed(arg1.id)
        end
        var24(nil)
    end

    local function func12(arg1, num1: number) -- Luacid: Inlined by compiler; 1 call site recovered
        if var23 then
            task.cancel(var23)
        end
        local var63 = task.delay(num1, function()
            func11(arg1, "display")
            LifecycleEvents:DispatchEvent(LifecycleEvents.ToastEvents.Display, arg1.notificationType, arg1)
        end)
        var24(var63)
    end

    local var63 = React.useCallback(function(arg1)
        if isTenFootInterface()
            and arg1
            and arg1.notificationType ~= nil
            and arg1.notificationType ~= type.NotificationTypeEnum.ClientNotification
        then
            return
        end

        if GetFFlagFilterSecurityAlertsVRToastEnabled()
            and var42
            and arg1
            and arg1.notificationType ~= nil
            and arg1.notificationType == type.NotificationTypeEnum.SecurityAlert
        then
            return
        end

        if arg1
            and arg1.notificationType == type.NotificationTypeEnum.ChatNewMessage
            and not GetFFlagEnableChatNewMessage()
            and arg1.content
            and arg1.content.id
        then
            func4(arg1.content.id)
            return
        end

        if arg1 and arg1.content and arg1.content.id ~= nil then
            local var63 = marshalNotificationData(arg1)
            var18(var63)
            LifecycleEvents:DispatchEvent(LifecycleEvents.ToastEvents.AttemptDisplay, var63.notificationType, var63)
        else
            var18(nil)
        end
    end, {})

    React.useEffect(function()
        if not var17 then
            return
        end

        if notificationData and notificationData.id == var17.id then
            func11(var17, "update")
            LifecycleEvents:DispatchEvent(LifecycleEvents.ToastEvents.Update, var17.notificationType, var17)
            return
        end

        local displayNotificationDelay = constants.DisplayNotificationDelay

        if var17.luaNotifInfo ~= nil then
            displayNotificationDelay = if notificationData then 1 / springOptions.frequency else 0
        end

        func12(var17, displayNotificationDelay)
    end, { var17 })

    React.useEffect(function()
        local bool7 = not not (var17 and notificationData and var17.id == notificationData.id)

        var14(bool7)
        if bool7 == false then
            var46(false)
        end
    end, { var17, notificationData })

    React.useEffect(function()
        local current = var13 and (var27 or var34 or var36 or var38 or shouldAutoFocus or holding)

        var32(current)

        if bool2 then
            var33.current = current
        end
    end, {
        var13,
        var27,
        var34,
        var36,
        var38,
        shouldAutoFocus,
        holding
    })

    React.useEffect(function()
        if bool2 then
            var58(var31)
            return
        end
        var58(var31, var54, func10)
    end, { var31 })

    local groupTransparency, var65 = ReactOtter.useAnimatedBinding(1, function()
        if not var13 then
            var16(nil)
            var59()
        end
    end)

    React.useEffect(function()
        var65(ReactOtter.spring(if var13 then 0 else 1, springOptions))
    end, { var13, var65 })

    local useEffect = React.useEffect
    local function func13()
        local toastPosition

        if FFlagFriendshipNotifsUseSendrExperiment then
            local var66 = if notificationData and notificationData.notificationType == type.NotificationTypeEnum.FriendRequestReceived then if getFRRToastPositionVariant() == "legacyBottomRight" then "legacyBottomRight" else nil else nil
            toastPosition = calculateToastPosition(var13, isToastToRight(var9), var4, var5, var66, var11)
        else
            toastPosition = calculateToastPosition(var13, isToastToRight(var9), var4, var5)
        end

        var20(toastPosition)
    end

    local var66 = if FFlagFriendshipNotifsUseSendrExperiment then notificationData else nil
    local var67 = if FFlagFriendshipNotifsUseSendrExperiment then var4 else nil
    local var68 = if FFlagFriendshipNotifsUseSendrExperiment then var11 else nil
    useEffect(func13, { var9, var13, var5, var66, var67, var68 })

    React.useEffect(function()
        func3()

        local connection = workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
            func3()

            if FFlagFriendshipNotifsUseSendrExperiment then
                var12(workspace.CurrentCamera.ViewportSize)
            end
        end)

        return function()
            if connection then
                connection:Disconnect()
            end
        end
    end, {})

    React.useEffect(function()
        return function()
            if var23 then
                task.cancel(var23)
            end
            if var21 then
                task.cancel(var21)
            end
            if var50 then
                var51(nil)
                var50:Fire(false)
                var50:Destroy()
            end
        end
    end, {})

    React.useEffect(function()
        task.delay(0, function()
            local tbl3 = bool5 and { type.ChannelListEnum.Experience, type.ChannelListEnum.Dual }
                or { type.ChannelListEnum.App, type.ChannelListEnum.Dual }

            if var3 then
                table.insert(tbl3, type.ChannelListEnum.Desktop)
            end

            default2:setupNotifications(tbl3)
        end)
    end, {})

    React.useEffect(function()
        local var69 = default2:listenToDisplayNotification(var63)
        return function()
            if var69 then
                var69:Disconnect()
            end
        end
    end, { var63 })

    local var69 = IsVRAppBuild()

    local var70 = var13 or not var69
    local var71 = isHover and not TouchEnabled and not var69 and var13

    local createElement = React.createElement
    local tbl3 = {
        ZIndex = 2,
        LayoutOrder = 1,
        AnchorPoint = Vector2.new(0, 0),
        Size = UDim2.new(0, constants.CardSizeDefault.closeButton, 0, constants.CardSizeDefault.closeButton),
        Position = UDim2.new(0, -10, 0, -10),
        BackgroundTransparency = var52.Theme.BackgroundUIDefault.Transparency,
        BackgroundColor3 = var52.Theme.BackgroundUIDefault.Color,
        Text = "",
        [React.Event.Activated] = func9
    }

    tbl3[React.Event.MouseEnter] = function()
        var37(true)
    end
    tbl3[React.Event.MouseLeave] = function()
        var37(false)
    end

    local element = createElement("TextButton", tbl3, {
        Border = React.createElement("UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = var52.Theme.UIDefault.Color }),
        UICorner = React.createElement("UICorner", { CornerRadius = constants.DefaultCardCloseButtonCornerRadius }),
        CloseButtonIcon = React.createElement(ImageSetLabel, {
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundTransparency = 1,
            Position = UDim2.new(0.5, 0, 0.5, 0),
            Size = UDim2.new(0, constants.CardSizeDefault.closeIcon, 0, constants.CardSizeDefault.closeIcon),
            Image = iconsNavigationClose,
            ImageColor3 = var52.Theme.SystemPrimaryDefault.Color
        })
    })

    local var72 = React.useMemo(function()
        local createElement2 = React.createElement
        local animatedFrame = SpringAnimatedItem.AnimatedFrame
        local tbl4 = {
            regularProps = 0,
            animatedValues = 0,
            springOptions = 0,
            mapValuesToProps = 0,
            onComplete = 0
        }
        local regularProps = {
            ClipsDescendants = false,
            Size = var7,
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            Active = true,
            Visible = var70 and notificationData ~= nil
        }

        regularProps[React.Event.MouseEnter] = function()
            func5(type.ToastNotificationActionsEnum.Hover, userId, notificationData)

            onHover(true)
        end
        regularProps[React.Event.MouseLeave] = function()
            onHover(false)
        end

        tbl4.regularProps = regularProps

        tbl4.animatedValues = animatedValues
        tbl4.springOptions = springOptions
        function tbl4.mapValuesToProps(arg1)
            return {
                Position = if var69 then UDim2.new(0.5, 0, 0.5, 0) else UDim2.new(arg1.positionX, arg1.positionXOffset, arg1.positionY, arg1.positionYOffset),
                AnchorPoint = if var69 then Vector2.new(0.5, 0.5) else Vector2.new(arg1.anchorX, arg1.anchorY)
            }
        end

        function tbl4.onComplete()
            if not var13 then
                var16(nil)
                var59()
            end
        end
        local tbl6 = { SwipeDetector = 0 }
        local createElement3 = React.createElement
        local var72 = SwipeDetectionWrapper

        local tbl7 = {
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            swipeEnabled = var13,
            swipeCallback = function(swipeDirection)
                if swipeDirection == Enum.SwipeDirection.Up or swipeDirection == Enum.SwipeDirection.Right then
                    func9()
                end
            end
        }
        local tbl8 = { NotificationProvider = 0 }
        local element2

        if engineFeature and notificationData and notificationData.luaNotifInfo and notificationData.id then
            element2 = React.createElement(ClientNotificationWrapper, {
                notificationInfo = notificationData.luaNotifInfo,
                notificationId = notificationData.id,
                onPause = onPause,
                onHover = onHover,
                transparency = if bool1 then groupTransparency else nil,
                width = var7.X
            }, {
                ToastCloseButton = if var71 then element else nil
            })
        else
            element2 = React.createElement(NotificationCardProvider, {
                state = notificationData and notificationData.state,
                isCompact = isCompact,
                handleActions = handleActions,
                notificationReceivedTimestampMs = notificationData and notificationData.notificationReceivedTimestampMs,
                timers = notificationData and notificationData.timers,
                displayTimestampMs = notificationData and notificationData.displayTimestamp
            }, {
                NotificationCardCanvasGroup = if notificationData then React.createElement("CanvasGroup", {
                    AutomaticSize = Enum.AutomaticSize.Y,
                    Size = var7,
                    BackgroundTransparency = 1,
                    GroupTransparency = groupTransparency,
                    LayoutOrder = 2
                }, {
                    NotificationCard = React.createElement(
                        NotificationCard,
                        {
                            isHover = isHover,
                            shouldAutoFocus = shouldAutoFocus,
                            showHoldButton = showHoldButton,
                            holdProgress = holdProgress
                        }
                    )
                }) else nil,
                ToastCloseButton = if var71 then element else nil
            })
        end

        tbl8.NotificationProvider = element2
        tbl6.SwipeDetector = createElement3(var72, tbl7, tbl8)
        return createElement2(animatedFrame, tbl4, tbl6)
    end, {
        constants,
        var52,
        notificationData,
        var70,
        var13,
        isCompact,
        var71,
        isHover,
        animatedValues,
        func9,
        onHover,
        var37,
        handleActions
    })

    if var69 then
        return React.createElement(ToastVRWrapper, {
            isConfirmModalOpen = isConfirmModalOpen,
            isToastOpen = var13,
            isCoreScript = bool5,
            ToastComponent = var72,
            ToastNotificationSnoozeMenu = React.createElement(ToastNotificationSnoozeMenu),
            ConfirmationModalComponent = React.createElement(DeeplinkConfirmationModal, { closeCallback = closeCallback, backgroundTransparency = 1 })
        })
    end

    return React.createElement(
        "ScreenGui",
        {
            DisplayOrder = tbl2.displayOrder,
            ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
            IgnoreGuiInset = true
        },
        {
            Toast = var72,
            ToastNotificationSnoozeMenu = React.createElement(ToastNotificationSnoozeMenu),
            DeeplinkConfirmationModal = isConfirmModalOpen and React.createElement(DeeplinkConfirmationModal, { closeCallback = closeCallback })
        }
    )
end
