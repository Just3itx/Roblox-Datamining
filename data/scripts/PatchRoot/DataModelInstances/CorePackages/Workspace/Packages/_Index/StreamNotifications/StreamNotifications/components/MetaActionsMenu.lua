-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T23:21:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local StreamNotifications = script:FindFirstAncestor("StreamNotifications")
local StreamNotificationsParent = StreamNotifications.Parent
local constants = require(StreamNotifications.constants)
local React = require(StreamNotificationsParent.React)
local NotificationsCommon = require(StreamNotificationsParent.NotificationsCommon)
local NotificationCardProvider = NotificationsCommon.NotificationCardProvider
local NotificationCard = NotificationsCommon.NotificationCard
local NotificationHelper = NotificationsCommon.NotificationHelper
local constants2 = NotificationsCommon.constants
local FocusNavigationUtils = require(StreamNotificationsParent.FocusNavigationUtils)
local FocusNavigableSurfaceWrapper = FocusNavigationUtils.FocusNavigableSurfaceWrapper
local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum
local FocusNavigationEventNameEnum = FocusNavigationUtils.FocusNavigationEventNameEnum
local _ReactFocusNavigation = require(StreamNotificationsParent.ReactFocusNavigation)
local InputHandlers = require(StreamNotificationsParent.InputHandlers)

local marshalStreamNotificationData = NotificationHelper.marshalStreamNotificationData
local EnumStreamNotificationsDisplayState = require(StreamNotifications.EnumStreamNotificationsDisplayState)

local UIBlox = require(StreamNotificationsParent.UIBlox)
local useStyle = UIBlox.Core.Style.useStyle
local IconButton = UIBlox.App.Button.IconButton
local IconSize = UIBlox.App.ImageSet.Enum.IconSize
local BaseMenu = UIBlox.App.Menu.BaseMenu
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel

return function(tbl1)
    local var1 = useStyle()
    local activeNotification = tbl1.activeNotification
    local displayState = tbl1.displayState
    local isSmallScreen = tbl1.isSmallScreen
    local handleActions = tbl1.handleActions
    local closeNotificationDisplay = tbl1.closeNotificationDisplay

    local ref = React.useRef(nil)

    if displayState ~= EnumStreamNotificationsDisplayState.MetaActions then
        return nil
    end
    local var3 = marshalStreamNotificationData(activeNotification)
    local buttonProps = {}

    if var3 then
        for _, value in ipairs(var3.state.visualItems.metaAction) do
            local tbl3 = {
                icon = constants.MetaActions.ActionIcons[value.actionIcon] or constants.MetaActions.ActionIcons.default,
                text = value.label.text,
                onActivated = 0
            }

            function tbl3.onActivated()
                if handleActions then
                    handleActions(value, activeNotification)
                end
            end

            table.insert(buttonProps, tbl3)
        end
    end

    local tbl3 = {
        UICorner = React.createElement(
            "UICorner",
            {
                CornerRadius = if isSmallScreen then UDim.new(0, 0) else UDim.new(0, constants.Modal.CornerRadius)
            }
        ),
        MetaActions = React.createElement("Frame", {
            ref = ref,
            AutomaticSize = Enum.AutomaticSize.Y,
            Size = UDim2.fromScale(1, 0),
            Position = UDim2.new(0.5, 0, 0.5, 0),
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundTransparency = 1
        }, {
            UIPadding = React.createElement("UIPadding", {
                PaddingTop = UDim.new(0, constants.Modal.Padding),
                PaddingLeft = UDim.new(0, constants.Modal.Padding),
                PaddingRight = UDim.new(0, constants.Modal.Padding),
                PaddingBottom = UDim.new(0, constants.Modal.Padding)
            }),
            React.createElement("UIListLayout", {
                FillDirection = Enum.FillDirection.Vertical,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, constants.DefaultPadding)
            }),
            CardAndClose = React.createElement(
                "Frame",
                {
                    AutomaticSize = Enum.AutomaticSize.Y,
                    Size = UDim2.fromScale(1, 0),
                    BackgroundTransparency = 1,
                    LayoutOrder = 1
                },
                {
                    ActiveCard = React.createElement(
                        NotificationCardProvider,
                        {
                            notificationPayload = activeNotification,
                            state = var3 and var3.state,
                            isCompact = false,
                            readOnly = false,
                            openMetaActions = nil,
                            handleActions = handleActions
                        },
                        {
                            NotificationCard = React.createElement(NotificationCard, { isHover = false, layoutOrder = 1 })
                        }
                    ),
                    CloseButtonFrame = React.createElement("Frame", {
                        Size = UDim2.fromOffset(constants.MetaActions.CloseButtonFrameSize, constants.MetaActions.CloseButtonFrameSize),
                        BackgroundTransparency = 1,
                        BorderSizePixel = 0,
                        AnchorPoint = Vector2.new(1, 0),
                        Position = UDim2.new(1, -constants2.Padding.DefaultCardPadding, 0, constants2.Padding.DefaultCardPadding)
                    }, {
                        CloseIcon = React.createElement(ImageSetLabel, {
                            LayoutOrder = 2,
                            AnchorPoint = Vector2.new(0.5, 0.5),
                            Position = UDim2.fromScale(0.5, 0.5),
                            Size = UDim2.fromOffset(constants.MetaActions.CloseIconSize, constants.MetaActions.CloseIconSize),
                            BackgroundTransparency = 1,
                            BorderSizePixel = 0,
                            Image = constants.Modal.CloseIcon,
                            ImageColor3 = var1.Theme.UIEmphasis.Color
                        }),
                        CloseButton = React.createElement(IconButton, {
                            iconSize = IconSize.Small,
                            size = UDim2.fromOffset(constants.MetaActions.CloseButtonSize, constants.MetaActions.CloseButtonSize),
                            layoutOrder = 1,
                            anchorPoint = Vector2.new(0.5, 0.5),
                            position = UDim2.new(0.5, 0, 0.5, 0),
                            onActivated = closeNotificationDisplay
                        })
                    })
                }
            ),
            Menu = React.createElement(BaseMenu, { buttonProps = buttonProps, width = UDim.new(1, 0), layoutOrder = 2 })
        })
    }

    local createElement = React.createElement
    local var4 = FocusNavigableSurfaceWrapper

    local tbl4 = {
        surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.ContextualMenu,
        isIsolated = true,
        frameProps = { ref = ref },
        customEventHandlers = {
            [FocusNavigationEventNameEnum.NavigateBack] = {
                handler = InputHandlers.onRelease(function(arg1)
                    closeNotificationDisplay()
                    arg1:cancel()
                end)
            }
        }
    }

    return createElement(var4, tbl4, tbl3)
end
