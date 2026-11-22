-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T23:21:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local StreamNotifications = script:FindFirstAncestor("StreamNotifications")
local StreamNotificationsParent = StreamNotifications.Parent
local React = require(StreamNotificationsParent.React)
local constants = require(StreamNotifications.constants)
local ReactOtter = require(StreamNotificationsParent.ReactOtter)
local SharedFlags = require(StreamNotificationsParent.SharedFlags)

local UIBlox = require(StreamNotificationsParent.UIBlox)
local useStyle = UIBlox.Core.Style.useStyle
local DarkTheme = UIBlox.App.Style.Themes.DarkTheme

local StreamNotificationDropdownExperimentation = require(StreamNotifications.StreamNotificationDropdownExperimentation)
local NotificationsCommon = require(StreamNotificationsParent.NotificationsCommon)
local NotificationCard = NotificationsCommon.NotificationCard
local NotificationHelper = NotificationsCommon.NotificationHelper
local NotificationCardProvider = NotificationsCommon.NotificationCardProvider
local marshalStreamNotificationData = NotificationHelper.marshalStreamNotificationData

local useImpressionsTagger = require(StreamNotificationsParent.Impressions).useImpressionsTagger

local FFlagStreamNotificationImpressionLogging = SharedFlags.FFlagStreamNotificationImpressionLogging

local tbl1 = { stiffness = 207, damping = 24, mass = 1 }

return function(tbl2)
    local var1 = useStyle()
    local dropdownEnabled = StreamNotificationDropdownExperimentation.getDropdownEnabled()
    local var2 = marshalStreamNotificationData(tbl2.notification)
    local ref = React.useRef(nil)

    local var4, var5 = React.useState(0)
    local var6, var7 = ReactOtter.useAnimatedBinding({
        dismissHeight = 1,
        transparency = 1,
        collapsedHeight = if tbl2.collapsed then 0 else 1,
        collapsedWidth = if tbl2.collapsed then 1 else 0
    }, function()
        if tbl2.notification.dismiss then
            tbl2.finishDismissNotification(tbl2.notification.id)
        end
    end)

    React.useEffect(function()
        var7({
            dismissHeight = ReactOtter.spring(if tbl2.notification.dismiss then 0 else 1, tbl1),
            transparency = ReactOtter.spring(if tbl2.notification.dismiss then 0 else 1, tbl1),
            collapsedHeight = ReactOtter.spring(if tbl2.collapsed then 0 else 1, tbl1),
            collapsedWidth = ReactOtter.spring(if tbl2.collapsed then 1 else 0, tbl1)
        })
    end, { tbl2.notification.dismiss, tbl2.collapsed })

    local function func1(arg1)
        if tbl2.onHeightChange then
            tbl2.onHeightChange(tbl2.layoutOrder, arg1.AbsoluteSize.Y)
        end
    end

    local function func2(arg1)
        if tbl2.notification.dismiss ~= true then
            local var8 = arg1.AbsoluteSize.Y + (if dropdownEnabled then 0 else constants.DefaultPadding)
            var5(var8)
        end
    end

    local num1 = 0
    local num2 = 0
    if not dropdownEnabled then
        num1 = constants.DefaultPadding * 2
        if tbl2.layoutOrder == 2 then
            num2 = constants.DefaultPadding * 2
        elseif tbl2.layoutOrder == 3 then
            num2 = constants.DefaultPadding * 4
        elseif tbl2.layoutOrder >= 4 then
            num2 = constants.DefaultPadding * 6
        end
    end

    if FFlagStreamNotificationImpressionLogging then
        useImpressionsTagger(ref, tbl2.impressionsTag, tbl2.impressionIndex)
    end

    local createElement = React.createElement
    local str1 = "Frame"

    local tbl3 = {
        ref = ref,
        Size = var6:map(function(tbl3): UDim2
            if tbl2.layoutOrder == 1 and tbl2.collapsed then
                return UDim2.new(
                    1,
                    -(num1 + num2 * tbl3.collapsedWidth),
                    0,
                    tbl3.collapsedHeight * tbl3.dismissHeight * var4 + (if dropdownEnabled then 0 else constants.DefaultPadding)
                )
            end
            return UDim2.new(1, -(num1 + num2 * tbl3.collapsedWidth), 0, tbl3.collapsedHeight * tbl3.dismissHeight * var4)
        end),
        BackgroundTransparency = 1,
        ClipsDescendants = not not (tbl2.layoutOrder ~= 1 and tbl2.collapsed),
        LayoutOrder = tbl2.layoutOrder or 1,
        ZIndex = if tbl2.layoutOrder then -tbl2.layoutOrder else 1
    }

    local tbl4 = { DismissFrame = 0 }
    local createElement2 = React.createElement
    local str2 = "Frame"

    local tbl5 = {
        Size = var6:map(function(tbl5): UDim2
            return UDim2.new(1, 0, 0, tbl5.dismissHeight * var4)
        end),
        BackgroundTransparency = 1,
        ClipsDescendants = true,
        LayoutOrder = tbl2.layoutOrder,
        [React.Change.AbsoluteSize] = func1
    }

    local tbl6 = { FadeFrame = 0, InnerFrame = 0 }
    local createElement3 = React.createElement
    local str3 = "Frame"

    local tbl7 = {
        AutomaticSize = Enum.AutomaticSize.Y,
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundColor3 = if var1.theme == DarkTheme then var1.Theme.Overlay.Color else var1.Theme.BackgroundMuted.Color,
        BackgroundTransparency = var6:map(function(arg1)
            return arg1.transparency
        end),
        ZIndex = 2,
        Position = UDim2.fromScale(0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0)
    }

    tbl6.FadeFrame = createElement3(str3, tbl7, {})
    tbl6.InnerFrame = React.createElement("Frame", {
        AutomaticSize = Enum.AutomaticSize.Y,
        Size = UDim2.new(1, 0, 0, 0),
        BackgroundTransparency = 1,
        ZIndex = 1,
        Position = UDim2.fromScale(0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0),
        [React.Change.AbsoluteSize] = func2
    }, { React.createElement(
            NotificationCardProvider,
            {
                notificationPayload = tbl2.notification,
                state = var2.state,
                isCompact = false,
                readOnly = not not tbl2.collapsed,
                handleActions = tbl2.handleActions,
                openMetaActions = tbl2.openMetaActions
            },
            {
                NotificationCard = React.createElement(NotificationCard, { isHover = false, layoutOrder = tbl2.layoutOrder })
            }
        ) })
    tbl4.DismissFrame = createElement2(str2, tbl5, tbl6)
    return createElement(str1, tbl3, tbl4)
end
