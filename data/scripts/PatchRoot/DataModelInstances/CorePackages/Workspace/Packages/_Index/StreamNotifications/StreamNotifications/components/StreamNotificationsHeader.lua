-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T23:21:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local StreamNotifications = script:FindFirstAncestor("StreamNotifications")
local StreamNotificationsParent = StreamNotifications.Parent
local constants = require(StreamNotifications.constants)

local useLocalization = require(StreamNotificationsParent.Localization).Hooks.useLocalization

local React = require(StreamNotificationsParent.React)
local useDispatch = require(StreamNotificationsParent.RoactUtils).Hooks.RoactRodux.useDispatch
local UIBlox = require(StreamNotificationsParent.UIBlox)
local Foundation = require(StreamNotificationsParent.Foundation)
local useStyle = UIBlox.Core.Style.useStyle
local useTokens = Foundation.Hooks.useTokens
local normalizeFontFace = Foundation.Utility.normalizeFontFace
local IconButton = UIBlox.App.Button.IconButton
local IconSize = UIBlox.App.ImageSet.Enum.IconSize
local UserInputService = game:GetService("UserInputService")

local EventStream = require(StreamNotifications.analytics.analyticsService).EventStream
local NotificationHelper = require(StreamNotificationsParent.NotificationsCommon).NotificationHelper
local analyticsConstants = require(StreamNotifications.analytics.analyticsConstants)

local StreamNotificationDropdownExperimentation = require(StreamNotifications.StreamNotificationDropdownExperimentation)
local StreamNotificationSettingsExperimentation = require(StreamNotifications.StreamNotificationSettingsExperimentation)
local StreamNotificationSettingsActivation = require(StreamNotifications.StreamNotificationSettingsActivation)
local FFlagStreamNotificationUXSettingsHeader = require(StreamNotificationsParent.SharedFlags).FFlagStreamNotificationUXSettingsHeader

local function getSettingsButtonSize(num1: number, num2: number): number -- Luacid: Inlined by compiler; 5 call sites recovered
    return num1 - num2 * 2
end

return function(tbl1)
    local var1 = useStyle()
    local var2 = useTokens()
    local fontFace = normalizeFontFace(var2.Typography.HeadingSmall.Font)
    local fontSize = var2.Typography.HeadingSmall.FontSize
    local num1 = if UserInputService.StatusBarSize then if tbl1.isSmallScreen then UserInputService.StatusBarSize.Y else 0 else 0

    local var4 = useLocalization({ headerText = constants.Text.HeaderKey })

    local dropdownEnabled = StreamNotificationDropdownExperimentation.getDropdownEnabled()
    local settingsGearEnabled, onSettingsActivated

    if FFlagStreamNotificationUXSettingsHeader then
        local var5 = useDispatch()
        settingsGearEnabled = StreamNotificationSettingsExperimentation.getSettingsGearEnabled()
        onSettingsActivated = StreamNotificationSettingsActivation.createOnSettingsActivated(
            settingsGearEnabled,
            dropdownEnabled,
            tbl1.displayStream,
            var5
        )
    else
        settingsGearEnabled = false

        onSettingsActivated = function() end
    end

    if dropdownEnabled then
        local headerMinHeight = constants.Dropdown.HeaderMinHeight
        local settingsButtonSize = getSettingsButtonSize(headerMinHeight, constants.DefaultPadding)
        return React.createElement(
            "Frame",
            {
                Size = UDim2.new(1, 0, 0, headerMinHeight),
                BackgroundTransparency = 1,
                LayoutOrder = 1
            },
            {
                HeaderText = React.createElement("TextLabel", {
                    Text = var4 and var4.headerText,
                    FontFace = fontFace,
                    TextSize = fontSize,
                    TextColor3 = var1.Theme.TextEmphasis.Color,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextYAlignment = Enum.TextYAlignment.Center,
                    Size = UDim2.new(1, -(if settingsGearEnabled then settingsButtonSize else 0), 1, 0),
                    BackgroundTransparency = 1
                }),
                SettingsButton = if FFlagStreamNotificationUXSettingsHeader and settingsGearEnabled then React.createElement(
                    IconButton,
                    {
                        anchorPoint = Vector2.new(1, 0.5),
                        iconSize = IconSize.Medium,
                        icon = constants.Modal.SettingsIcon,
                        position = UDim2.new(1, 0, 0.5, 0),
                        size = UDim2.fromOffset(settingsButtonSize, settingsButtonSize),
                        onActivated = onSettingsActivated
                    }
                ) else nil
            }
        )
    end

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        Size = UDim2.new(1, 0, 0, constants.Modal.HeaderHeight + num1),
        BackgroundTransparency = 1
    }
    local tbl3 = { HeaderFrame = 0 }
    local createElement2 = React.createElement
    local str2 = "Frame"
    local tbl4 = {
        Size = UDim2.new(1, 0, 0, constants.Modal.HeaderHeight),
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 0, 1, 0),
        AnchorPoint = Vector2.new(0, 1)
    }
    local tbl5 = { CloseModal = 0, HeaderText = 0, SettingsButton = 0 }
    local createElement3 = React.createElement
    local var5 = IconButton
    local tbl6 = {
        anchorPoint = Vector2.new(0, 0),
        iconSize = IconSize.Medium,
        icon = if tbl1.isSmallScreen then constants.Modal.BackIcon else constants.Modal.CloseIcon,
        layoutOrder = 1,
        size = UDim2.new(
            0,
            getSettingsButtonSize(constants.Modal.HeaderHeight, constants.Modal.Padding),
            0,
            (getSettingsButtonSize(constants.Modal.HeaderHeight, constants.Modal.Padding))
        ),
        position = UDim2.fromOffset(constants.Modal.Padding, constants.Modal.Padding),
        onActivated = 0
    }

    function tbl6.onActivated()
        tbl1.displayStream(false)
        NotificationHelper.fireEvent(
            EventStream,
            analyticsConstants.Context.click,
            analyticsConstants.EventNames.closeContent,
            {
                closeMethod = analyticsConstants.CloseMethod.closeIcon
            }
        )
    end

    tbl5.CloseModal = createElement3(var5, tbl6)

    tbl5.HeaderText = React.createElement("TextLabel", {
        Text = var4 and var4.headerText,
        FontFace = fontFace,
        TextSize = fontSize,
        TextColor3 = var1.Theme.TextEmphasis.Color,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(1, 0, 0, constants.Modal.HeaderHeight),
        BackgroundTransparency = 1
    })
    local element

    if FFlagStreamNotificationUXSettingsHeader and settingsGearEnabled then
        element = React.createElement(IconButton, {
            anchorPoint = Vector2.new(1, 0),
            iconSize = IconSize.Medium,
            icon = constants.Modal.SettingsIcon,
            position = UDim2.new(1, -constants.Modal.Padding, 0, constants.Modal.Padding),
            size = UDim2.fromOffset(
                getSettingsButtonSize(constants.Modal.HeaderHeight, constants.Modal.Padding),
                (getSettingsButtonSize(constants.Modal.HeaderHeight, constants.Modal.Padding))
            ),
            onActivated = onSettingsActivated
        })
    else
        element = nil
    end

    tbl5.SettingsButton = element
    tbl3.HeaderFrame = createElement2(str2, tbl4, tbl5)
    return createElement(str1, tbl2, tbl3)
end
