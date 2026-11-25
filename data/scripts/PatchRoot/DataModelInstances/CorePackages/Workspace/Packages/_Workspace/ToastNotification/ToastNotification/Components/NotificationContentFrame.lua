-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T19:31:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent
local context = scriptParentParent.context
local dependencies = require(scriptParentParent.dependencies)
local NotificationStyledText = require(scriptParent.NotificationStyledText)
local NotificationThumbnail = require(scriptParent.NotificationThumbnail)
local ToastHoldButton = require(scriptParent.ToastHoldButton)
local type = require(scriptParentParent.type)
local UIBlox = dependencies.UIBlox
local useStyle = UIBlox.Core.Style.useStyle
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local Interactable = UIBlox.Core.Control.Interactable
local constants = require(scriptParentParent.constants)
local useNotificationCardState = require(context.useNotificationCardState)
local useNotificationCardData = require(context.useNotificationCardData)

local scriptParentParentParent = scriptParentParent.Parent
local React = require(scriptParentParentParent.React)
local Foundation = require(scriptParentParentParent.Foundation)
local useTokens = Foundation.Hooks.useTokens
local normalizeFontFace = Foundation.Utility.normalizeFontFace

local DefaultContentPadding = constants.DefaultContentPadding
local DefaultTextContentPadding = constants.DefaultTextContentPadding
local vector2 = Vector2.new(36, 36)

local utils = scriptParentParent.utils
local isUserThumbnail = require(utils.toastNotificationHelper).isUserThumbnail

return function(tbl1)
    local var1 = useStyle()
    local var2 = useTokens()
    local fontSize = var2.Typography.CaptionLarge.FontSize
    local fontSize2 = var2.Typography.BodySmall.FontSize
    local cardSize = useNotificationCardData().cardSize
    local thumbnail

    if isUserThumbnail then
        local var3 = useNotificationCardState("thumbnail")

        thumbnail = React.useMemo(function()
            local bool1 = false
            if var3 then
                for _, value in var3 do
                    if not isUserThumbnail(value) then
                        bool1 = true
                        break
                    end
                end
            end

            if bool1 then
                return cardSize and cardSize.thumbnail or constants.CardSizeDefault.thumbnail
            end

            return var1.Tokens.Size.Size_1000
        end, { var3, var1.Tokens.Size.Size_1000, cardSize })
    else
        thumbnail = cardSize and cardSize.thumbnail or constants.CardSizeDefault.thumbnail
    end

    local size700 = var1.Tokens.Size.Size_700
    local var3 = useNotificationCardState("textBody")

    local var4 = var3 and var3[1]
    local var5 = var4
        and var4.title
        and {
            Text = var4.title,
            MaxSize = Vector2.new(math.huge, fontSize * 2),
            Size = UDim2.new(1, 0, 0, 0),
            TextSize = fontSize,
            AutomaticSize = Enum.AutomaticSize.Y,
            TextXAlignment = Enum.TextXAlignment.Left,
            LayoutOrder = 1,
            FontFace = normalizeFontFace(var2.Typography.CaptionLarge.Font),
            TextColor3 = var1.Theme.TextEmphasis.Color
        }
    local var6 = var4
        and var4.label
        and {
            Text = var4.label,
            MaxSize = Vector2.new(math.huge, fontSize2 * 2),
            Size = UDim2.new(1, 0, 0, 0),
            TextSize = fontSize2,
            AutomaticSize = Enum.AutomaticSize.Y,
            TextXAlignment = Enum.TextXAlignment.Left,
            LayoutOrder = 2,
            FontFace = normalizeFontFace(var2.Typography.BodySmall.Font)
        }

    local var7 = useNotificationCardData()
    cardSize = var7.cardSize
    local handleActions = var7.handleActions
    local var8 = useNotificationCardState("singleMetaAction")
    local var9 = var8 and var8[1]

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        AutomaticSize = Enum.AutomaticSize.Y,
        LayoutOrder = 1,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 0)
    }
    local tbl3 = {
        UIListLayout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Horizontal,
            SortOrder = Enum.SortOrder.LayoutOrder,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            Padding = UDim.new(0, DefaultContentPadding)
        }),
        ThumbnailTextContainer = 0,
        SingleMetaAction = 0
    }
    local createElement2 = React.createElement
    local str2 = "Frame"
    local tbl4 = {
        AutomaticSize = Enum.AutomaticSize.Y,
        LayoutOrder = 1,
        BackgroundTransparency = 1,
        Size = if var9 then UDim2.new(1, -(DefaultContentPadding + vector2.X), 0, 0) else UDim2.new(1, 0, 0, 0)
    }

    local tbl5 = {
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
        ToastTextFrame = React.createElement("Frame", {
            BackgroundTransparency = 1,
            LayoutOrder = 2,
            AutomaticSize = Enum.AutomaticSize.Y,
            Size = if tbl1.showHoldButton then UDim2.new(1, -(thumbnail + DefaultContentPadding * 2 + size700), 0, 0) else UDim2.new(1, -(thumbnail + DefaultContentPadding), 0, 0)
        }, {
            UIPadding = React.createElement("UIPadding", { PaddingTop = UDim.new(0, 2) }),
            UIListLayout = React.createElement("UIListLayout", {
                FillDirection = Enum.FillDirection.Vertical,
                SortOrder = Enum.SortOrder.LayoutOrder,
                VerticalAlignment = Enum.VerticalAlignment.Top,
                Padding = UDim.new(0, DefaultTextContentPadding)
            }),
            ToastTitle = var5 and React.createElement(NotificationStyledText, var5),
            ToastSubtitle = var6 and React.createElement(NotificationStyledText, var6)
        }),
        ToastHoldButton = React.createElement(ToastHoldButton, {
            iconSize = size700,
            visible = tbl1.showHoldButton,
            layoutOrder = 3,
            iconTransparency = if tbl1.shouldAutoFocus then 0.5 else 0,
            progress = tbl1.holdProgress
        })
    }
    tbl3.ThumbnailTextContainer = createElement2(str2, tbl4, tbl5)
    local var10

    if var9 then
        local createElement3 = React.createElement
        local var11 = Interactable
        local tbl6 = {
            AutoButtonColor = false,
            BackgroundColor3 = var1.Theme.UIMuted.Color,
            BackgroundTransparency = 0.9,
            LayoutOrder = 2,
            onStateChanged = function() end
        }

        tbl6[React.Event.Activated] = function()
            if handleActions then
                handleActions(var9)
            end
        end
        tbl6.Size = UDim2.fromOffset(vector2.X, vector2.Y)
        var10 = createElement3(var11, tbl6, {
            UICorner = React.createElement("UICorner", { CornerRadius = UDim.new(1, 0) }),
            Icon = React.createElement(ImageSetLabel, {
                AnchorPoint = Vector2.new(0.5, 0.5),
                BackgroundTransparency = 1,
                Image = type.MetaActionIcons[var9.actionIcon],
                ImageColor3 = var1.Theme.IconEmphasis.Color,
                Position = UDim2.fromScale(0.5, 0.5),
                Size = UDim2.fromOffset(28, 28)
            })
        })
    else
        var10 = nil
    end

    tbl3.SingleMetaAction = var10
    return createElement(str1, tbl2, tbl3)
end
