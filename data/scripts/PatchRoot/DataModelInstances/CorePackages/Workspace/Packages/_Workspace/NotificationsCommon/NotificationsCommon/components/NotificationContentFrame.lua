-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T00:20:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local NotificationsCommon = script:FindFirstAncestor("NotificationsCommon")
local NotificationsCommonParent = NotificationsCommon.Parent
local components = NotificationsCommon.components
local context = NotificationsCommon.context
local dependencies = require(NotificationsCommon.dependencies)
local NotificationStyledText = require(components.NotificationStyledText)
local NotificationThumbnail = require(components.NotificationThumbnail)
local _type = require(NotificationsCommon.type)
local React = dependencies.React
local UIBlox = dependencies.UIBlox
local Foundation = require(NotificationsCommonParent.Foundation)
local useStyle = UIBlox.Core.Style.useStyle
local useTokens = Foundation.Hooks.useTokens
local normalizeFontFace = Foundation.Utility.normalizeFontFace
local constants = require(NotificationsCommon.constants)
local useNotificationCardState = require(context.useNotificationCardState)
local useNotificationCardData = require(context.useNotificationCardData)
local NotificationActionsFrame = require(components.NotificationActionsFrame)

local IconButton = UIBlox.App.Button.IconButton
local Images = UIBlox.App.ImageSet.Images
local IconSize = UIBlox.App.ImageSet.Enum.IconSize
local iconsCommonOverflow = Images["icons/common/overflow"]

local DefaultContentPadding = constants.DefaultContentPadding
local DefaultTextContentPadding = constants.DefaultTextContentPadding
local MetaActionsWidth = constants.MetaActionsWidth
local TimestampWidth = constants.TimestampWidth
local TimestampHeight = constants.TimestampHeight

return function()
    local var1 = useStyle()
    local var2 = useTokens()
    local fontSize = var2.Typography.CaptionLarge.FontSize
    local fontSize2 = var2.Typography.BodySmall.FontSize
    local var3 = useNotificationCardData()
    local cardSize = var3.cardSize
    local readOnly = var3.readOnly
    local thumbnail = cardSize and cardSize.thumbnail or constants.CardSizeDefault.thumbnail
    local openMetaActions = var3.openMetaActions
    local notificationPayload = var3.notificationPayload
    local handleActions = var3.handleActions

    local var4 = useNotificationCardState("textBody")
    local var5 = var4 and var4[1]

    local var6 = var5
        and var5.title
        and {
            Text = var5.title,
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            TextSize = fontSize,
            TextXAlignment = Enum.TextXAlignment.Left,
            LayoutOrder = 1,
            FontFace = normalizeFontFace(var2.Typography.CaptionLarge.Font),
            TextColor3 = var1.Theme.TextEmphasis.Color
        }

    local var7 = var5
        and var5.label
        and {
            Text = var5.label,
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            TextSize = fontSize2,
            TextXAlignment = Enum.TextXAlignment.Left,
            LayoutOrder = 2,
            FontFace = normalizeFontFace(var2.Typography.BodySmall.Font),
            TextColor3 = var1.Theme.TextEmphasis.Color
        }
    local xOffset = if readOnly then -DefaultTextContentPadding else -(MetaActionsWidth + DefaultTextContentPadding)
    local var8 = notificationPayload
        and notificationPayload.timestamp
        and {
            Text = {
                text = notificationPayload.timestamp
            },
            Size = UDim2.new(0, TimestampWidth + DefaultTextContentPadding, 0, TimestampHeight),
            TextSize = fontSize,
            AutomaticSize = Enum.AutomaticSize.Y,
            TextXAlignment = Enum.TextXAlignment.Right,
            AnchorPoint = Vector2.new(1, 0),
            Position = UDim2.new(1, xOffset, 0, 0),
            LayoutOrder = 2,
            FontFace = normalizeFontFace(var2.Typography.CaptionLarge.Font),
            TextColor3 = var1.Theme.TextEmphasis.Color,
            TextTransparency = 0
        }

    local createElement = React.createElement
    local str1 = "TextButton"
    local tbl1 = {
        Selectable = false,
        AutomaticSize = Enum.AutomaticSize.Y,
        LayoutOrder = 1,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 0),
        Text = "",
        AutoButtonColor = false,
        BorderSizePixel = 0
    }

    tbl1[React.Event.Activated] = function()
        if handleActions and var5 and notificationPayload then
            handleActions(var5, notificationPayload)
        end
    end
    local tbl2 = {
        UIListLayout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Horizontal,
            SortOrder = Enum.SortOrder.LayoutOrder,
            VerticalAlignment = Enum.VerticalAlignment.Top,
            Padding = UDim.new(0, DefaultContentPadding)
        }),
        NotificationThumbnailFrame = React.createElement(
            "Frame",
            {
                BackgroundTransparency = 1,
                LayoutOrder = 1,
                AutomaticSize = Enum.AutomaticSize.Y,
                Size = UDim2.new(0, thumbnail, 0, thumbnail)
            },
            {
                NotificationThumbnail = React.createElement(NotificationThumbnail)
            }
        ),
        ContentFrame = 0
    }
    local createElement2 = React.createElement
    local str2 = "Frame"
    local tbl3 = {
        BackgroundTransparency = 1,
        LayoutOrder = 2,
        AutomaticSize = Enum.AutomaticSize.Y,
        Size = UDim2.new(1, -(thumbnail + DefaultContentPadding), 0, 0)
    }
    local tbl4 = {
        UIListLayout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            SortOrder = Enum.SortOrder.LayoutOrder,
            VerticalAlignment = Enum.VerticalAlignment.Top,
            Padding = UDim.new(0, DefaultTextContentPadding)
        }),
        NotificationsBody = 0,
        NotificationActionsFrame = 0
    }
    local createElement3 = React.createElement
    local str3 = "Frame"
    local tbl5 = {
        Size = UDim2.new(1, 0, 0, constants.MetaActionsHeight),
        AutomaticSize = Enum.AutomaticSize.Y,
        LayoutOrder = 1,
        BackgroundTransparency = 1
    }

    local tbl6 = {
        NotificationsText = React.createElement("Frame", {
            BackgroundTransparency = 1,
            Size = UDim2.new(
                1,
                if readOnly then -(TimestampWidth + DefaultTextContentPadding) else -(MetaActionsWidth + TimestampWidth + DefaultTextContentPadding * 2),
                0,
                0
            ),
            AutomaticSize = Enum.AutomaticSize.Y
        }, {
            UIPadding = React.createElement("UIPadding", { PaddingTop = UDim.new(0, DefaultTextContentPadding) }),
            UIListLayout = React.createElement("UIListLayout", {
                FillDirection = Enum.FillDirection.Vertical,
                SortOrder = Enum.SortOrder.LayoutOrder,
                VerticalAlignment = Enum.VerticalAlignment.Top,
                Padding = UDim.new(0, DefaultTextContentPadding)
            }),
            Title = if var6 then React.createElement(NotificationStyledText, var6) else nil,
            Subtitle = if var7 then React.createElement(NotificationStyledText, var7) else nil
        }),
        Timestamp = if var8 then React.createElement(NotificationStyledText, var8) else nil,
        MetaActionsButton = if openMetaActions and not readOnly then React.createElement(IconButton, {
            anchorPoint = Vector2.new(1, 0),
            position = UDim2.new(1, 0, 0, 0),
            size = UDim2.fromOffset(0, 0),
            iconSize = IconSize.Medium,
            icon = iconsCommonOverflow,
            layoutOrder = 3,
            onActivated = function()
                openMetaActions(notificationPayload)
            end
        }) else nil
    }

    tbl4.NotificationsBody = createElement3(str3, tbl5, tbl6)

    tbl4.NotificationActionsFrame = if readOnly then nil else React.createElement(NotificationActionsFrame)
    tbl2.ContentFrame = createElement2(str2, tbl3, tbl4)
    return createElement(str1, tbl1, tbl2)
end
