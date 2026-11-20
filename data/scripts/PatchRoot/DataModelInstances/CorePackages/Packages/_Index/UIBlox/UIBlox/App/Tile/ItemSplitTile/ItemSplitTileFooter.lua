-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:10:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent
local scriptParentParentParentParentParent = scriptParentParentParentParent.Parent

local Roact = require(scriptParentParentParentParentParent.Roact)
local t = require(scriptParentParentParentParentParent.t)
local Foundation = require(scriptParentParentParentParentParent.Foundation)
local normalizeFontFace = Foundation.Utility.normalizeFontFace

local withStyle = require(scriptParentParentParentParent.Core.Style.withStyle)
local Images = require(scriptParentParentParentParent.App.ImageSet.Images)

local Skeleton = Foundation.Skeleton
local ImageSetComponent = require(scriptParentParentParentParent.Core.ImageSet.ImageSetComponent)
local IconSize = require(scriptParentParentParent.ImageSet.Enum.IconSize)
local getIconSizeUDim2 = require(scriptParentParentParent.ImageSet.getIconSizeUDim2)

local var1 = Roact.PureComponent:extend("ItemSplitTileFooter")

var1.validateProps = t.strictInterface(
    {
        priceText = t.optional(t.string),
        isOwned = t.optional(t.boolean),
        layoutOrder = t.optional(t.number)
    }
)
function var1.render(arg1)
    local priceText = arg1.props.priceText
    local isOwned = arg1.props.isOwned
    local image = if isOwned then Images["icons/status/item/owned"] else Images["icons/common/robux_small"]

    return withStyle(function(arg2)
        local font = arg2.Font.Body.Font
        local textSize = arg2.Font.BaseSize * arg2.Font.Body.RelativeSize
        local theme = arg2.Theme

        local var3 = priceText and tonumber(priceText:sub(1, 1)) or priceText == "--"
        local var4 = priceText and (var3 or isOwned)
        local iconSizeUDim2 = getIconSizeUDim2(IconSize.Small)
        local xOffset = if var4 then iconSizeUDim2.Width.Offset + 4 else 0

        return Roact.createElement(
            "Frame",
            {
                Size = UDim2.new(1, 0, 0, textSize),
                BackgroundTransparency = 1,
                LayoutOrder = arg1.props.layoutOrder
            },
            {
                Shimmer = if priceText then nil else Roact.createElement(Skeleton, { Size = UDim2.new(0.8, 0, 0, textSize) }),
                Icon = var4
                    and Roact.createElement(ImageSetComponent.Label, {
                        BackgroundTransparency = 1,
                        Image = image,
                        ImageColor3 = theme.TextMuted.Color,
                        ImageTransparency = theme.TextMuted.Transparency,
                        Size = iconSizeUDim2,
                        Position = UDim2.new(0, 0, 0.5, 0),
                        AnchorPoint = Vector2.new(0, 0.5)
                    }),
                TextLabel = priceText
                    and Roact.createElement("TextLabel", {
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, xOffset, 0, 0),
                        Size = UDim2.new(1, -xOffset, 1, 0),
                        FontFace = normalizeFontFace(font),
                        TextColor3 = theme.TextMuted.Color,
                        TextTransparency = theme.TextMuted.Transparency,
                        TextSize = textSize,
                        Text = priceText,
                        TextTruncate = Enum.TextTruncate.AtEnd,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        TextYAlignment = Enum.TextYAlignment.Center
                    })
            }
        )
    end)
end
return var1
