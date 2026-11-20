-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:40:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent
local Core = scriptParentParentParent.Core
local scriptParentParentParentParent = scriptParentParentParent.Parent

local React = require(scriptParentParentParentParent.React)
local normalizeFontFace = require(scriptParentParentParentParent.Foundation).Utility.normalizeFontFace

local Images = require(scriptParentParent.ImageSet.Images)

local ImageSetComponent = require(Core.ImageSet.ImageSetComponent)
local useStyle = require(Core.Style.useStyle)
local _Fonts = require(scriptParentParent.Style.Fonts)

local function renderStatItem(tbl1: {AutomaticSize: Enum.AutomaticSize, BackgroundTransparency: number, LayoutOrder: number, Size: UDim2}, str1: string, text, arg1)
    local tokens = arg1.Tokens
    local font = arg1.Font
    local textSize = font.BaseSize * font.Body.RelativeSize
    local maxTextSize = textSize + tokens.Size.Size_200

    local size50 = tokens.Size.Size_50
    local size400 = tokens.Size.Size_400
    local default = tokens.Color.Content.Default
    local default2 = tokens.Color.Content.Default

    return React.createElement("Frame", tbl1, {
        UIListLayout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Horizontal,
            SortOrder = Enum.SortOrder.LayoutOrder,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            Padding = UDim.new(0, size50)
        }),
        Icon = React.createElement(ImageSetComponent.Label, {
            Size = UDim2.fromOffset(size400, size400),
            Image = Images[str1],
            BackgroundTransparency = 1,
            ImageTransparency = default.Transparency,
            ImageColor3 = default.Color3,
            LayoutOrder = 1,
            AnchorPoint = Vector2.new(0, 0.5)
        }),
        Label = React.createElement("TextLabel", {
            Size = UDim2.fromScale(0, 0),
            AutomaticSize = Enum.AutomaticSize.XY,
            BackgroundTransparency = 1,
            Text = text,
            FontFace = normalizeFontFace(font.Body.Font),
            TextSize = textSize,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Center,
            TextTruncate = Enum.TextTruncate.AtEnd,
            TextWrapped = false,
            TextColor3 = default2.Color3,
            TextTransparency = default2.Transparency,
            LayoutOrder = 2
        }, {
            UISizeConstraint = React.createElement("UISizeConstraint", { MaxSize = Vector2.new(tokens.Size.Size_1400, math.huge) }),
            UiTextSizeConstraint = React.createElement("UITextSizeConstraint", { MaxTextSize = maxTextSize })
        })
    })
end

local function StatGroup(tbl1)
    local var1 = useStyle()

    local size200 = var1.Tokens.Size.Size_200

    return React.createElement(
        "Frame",
        {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            AutomaticSize = Enum.AutomaticSize.X
        },
        {
            UIListLayout = React.createElement("UIListLayout", {
                FillDirection = Enum.FillDirection.Horizontal,
                SortOrder = Enum.SortOrder.LayoutOrder,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                Padding = UDim.new(0, size200)
            }),
            RatingStats = renderStatItem(
                {
                    Size = UDim2.fromScale(0, 0),
                    AutomaticSize = Enum.AutomaticSize.XY,
                    BackgroundTransparency = 1,
                    LayoutOrder = 1
                },
                "icons/status/games/rating_small",
                tbl1.ratingText,
                var1
            ),
            PlayingStats = if tbl1.playingText == nil then nil else renderStatItem(
                {
                    Size = UDim2.fromScale(0, 0),
                    AutomaticSize = Enum.AutomaticSize.XY,
                    BackgroundTransparency = 1,
                    LayoutOrder = 2
                },
                "icons/status/games/people-playing_small",
                tbl1.playingText,
                var1
            )
        }
    )
end

return StatGroup
