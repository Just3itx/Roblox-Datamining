-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T23:11:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ItemDetailsParent = script:FindFirstAncestor("ItemDetails").Parent

local React = require(ItemDetailsParent.React)
local Focusable = require(ItemDetailsParent.RoactGamepad).Focusable
local VerifiedBadges = require(ItemDetailsParent.VerifiedBadges)

local UIBlox = require(ItemDetailsParent.UIBlox)
local Foundation = require(ItemDetailsParent.Foundation)
local Skeleton = Foundation.Skeleton
local normalizeFontFace = Foundation.Utility.normalizeFontFace

local useStyle = UIBlox.Core.Style.useStyle
local useSelectionCursor = UIBlox.App.SelectionImage.useSelectionCursor
local CursorKind = UIBlox.App.SelectionImage.CursorKind
local Images = UIBlox.App.ImageSet.Images
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel

local iconsNavigationPushRight_small = Images["icons/navigation/pushRight_small"] or "LuaApp/icons/GameDetails/navigation/pushRight_small"

local vector2 = Vector2.new(14, 14)

local uDim2 = UDim2.new(0.3, 0, 0.8, 0)

return (React.forwardRef(function(tbl1, ref)
    local layoutOrder = tbl1.LayoutOrder
    local infoName = tbl1.infoName
    local infoData = tbl1.infoData
    local onActivate = tbl1.onActivate
    local hasVerifiedBadge = tbl1.hasVerifiedBadge
    local isLoading = tbl1.isLoading

    local var1 = useStyle()
    local theme = var1.Theme
    local font = var1.Font

    local var2 = useSelectionCursor(CursorKind.RoundedRect)

    local textEmphasisColor = theme.TextEmphasis.Color
    local var3 = font.BaseSize * font.Body.RelativeSize
    local num1 = -11 - vector2.X
    local bool1 = ref ~= nil
    local var4 = if bool1 then Focusable.ImageButton else "ImageButton"

    local bool2 = not (isLoading or hasVerifiedBadge)
    local var5 = not isLoading and hasVerifiedBadge

    local createElement = React.createElement
    local tbl2 = {
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        LayoutOrder = layoutOrder,
        Size = UDim2.new(1, 0, 0, if tbl1.hideDivider then 52 else 53),
        [React.Event.Activated] = onActivate,
        NextSelectionUp = tbl1.NextSelectionUp,
        NextSelectionDown = tbl1.NextSelectionDown,
        NextSelectionLeft = tbl1.NextSelectionLeft,
        NextSelectionRight = tbl1.NextSelectionRight,
        ref = ref,
        SelectionImageObject = bool1 and var2 or nil,
        Selectable = tbl1.Selectable
    }
    local tbl3 = { Container = 0, Divider = 0 }
    local createElement2 = React.createElement
    local str1 = "Frame"
    local tbl4 = {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, if tbl1.hideDivider then 0 else -1)
    }
    local tbl5 = {
        InfoNameTextLabel = React.createElement("TextLabel", {
            BackgroundTransparency = 1,
            FontFace = normalizeFontFace(var1.Tokens.Typography.BodyLarge.Font),
            Size = UDim2.new(0.5, 0, 1, 0),
            Text = infoName,
            TextColor3 = theme.TextDefault.Color,
            TextSize = var3,
            TextTruncate = Enum.TextTruncate.AtEnd,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Center
        }),
        InfoDataWithEmoji = 0,
        InfoDataTextLabel = 0,
        LoadingShimmer = 0,
        LinkIcon = 0
    }

    if var5 then
        local createElement3 = React.createElement
        local emojiWrapper = VerifiedBadges.EmojiWrapper
        local tbl6 = {
            emoji = VerifiedBadges.emoji.verified,
            font = if onActivate then font.Header2.Font else font.Body.Font,
            anchorPoint = Vector2.new(1, 0),
            position = UDim2.new(1, if onActivate then num1 else 0, 0, 0),
            size = UDim2.new(0.5, 0, 1, 0),
            automaticSize = Enum.AutomaticSize.None,
            horizontalAlignment = Enum.HorizontalAlignment.Right,
            verticalAlignment = Enum.VerticalAlignment.Center
        }
        local tbl7 = {
            InfoDataTextLabel = React.createElement("TextLabel", {
                BackgroundTransparency = 1,
                FontFace = normalizeFontFace(if onActivate then var1.Tokens.Typography.TitleLarge.Font else var1.Tokens.Typography.BodyLarge.Font),
                Size = UDim2.new(0, 0, 1, 0),
                Text = infoData,
                TextColor3 = if onActivate then theme.TextEmphasis.Color else theme.TextDefault.Color,
                TextSize = var3,
                TextTruncate = Enum.TextTruncate.AtEnd,
                TextScaled = tbl1.TextScaled,
                AutomaticSize = Enum.AutomaticSize.X,
                TextXAlignment = Enum.TextXAlignment.Left
            })
        }
        var5 = createElement3(emojiWrapper, tbl6, tbl7)
    end

    tbl5.InfoDataWithEmoji = var5

    if bool2 then
        bool2 = React.createElement(
            "TextLabel",
            {
                AnchorPoint = Vector2.new(1, 0),
                Position = UDim2.new(1, if onActivate then num1 else 0, 0, 0),
                BackgroundTransparency = 1,
                FontFace = normalizeFontFace(if onActivate then var1.Tokens.Typography.TitleLarge.Font else var1.Tokens.Typography.BodyLarge.Font),
                Size = UDim2.new(0.5, 0, 1, 0),
                Text = infoData,
                TextColor3 = if onActivate then theme.TextEmphasis.Color else theme.TextDefault.Color,
                TextSize = var3,
                TextTruncate = Enum.TextTruncate.AtEnd,
                TextScaled = tbl1.TextScaled,
                TextXAlignment = Enum.TextXAlignment.Right,
                TextYAlignment = Enum.TextYAlignment.Center
            },
            {
                TextSizeConstraint = tbl1.TextScaled and React.createElement("UITextSizeConstraint", { MaxTextSize = var3 })
            }
        )
    end

    tbl5.InfoDataTextLabel = bool2

    tbl5.LoadingShimmer = isLoading
        and React.createElement(Skeleton, { AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, 0, 0.5, 0), Size = uDim2 })

    tbl5.LinkIcon = onActivate
        and React.createElement(ImageSetLabel, {
            AnchorPoint = Vector2.new(1, 0.5),
            Position = UDim2.new(1, 0, 0.5, 0),
            Size = UDim2.fromOffset(vector2.X, vector2.Y),
            Image = iconsNavigationPushRight_small,
            ImageColor3 = textEmphasisColor,
            BorderSizePixel = 0,
            BackgroundTransparency = 1
        })
    tbl3.Container = createElement2(str1, tbl4, tbl5)

    tbl3.Divider = not tbl1.hideDivider
        and React.createElement("Frame", {
            BackgroundColor3 = theme.Divider.Color,
            BackgroundTransparency = theme.Divider.Transparency,
            BorderSizePixel = 0,
            Size = UDim2.new(1, 0, 0, 1),
            Position = UDim2.new(0, 0, 1, -1)
        })
    return createElement(var4, tbl2, tbl3)
end))
