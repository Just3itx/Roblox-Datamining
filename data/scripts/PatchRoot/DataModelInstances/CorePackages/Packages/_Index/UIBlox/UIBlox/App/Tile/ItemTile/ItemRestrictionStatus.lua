-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:10:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParentParent = scriptParentParent.Parent.Parent
local scriptParentParentParentParentParent = scriptParentParentParentParent.Parent

local Roact = require(scriptParentParentParentParentParent.Roact)
local t = require(scriptParentParentParentParentParent.t)
local normalizeFontFace = require(scriptParentParentParentParentParent.Foundation).Utility.normalizeFontFace
local withStyle = require(scriptParentParentParentParent.Core.Style.withStyle)

local GetTextSize = require(scriptParentParentParentParent.Core.Text.GetTextSize)
local Images = require(scriptParentParentParentParent.App.ImageSet.Images)
local ImageSetComponent = require(scriptParentParentParentParent.Core.ImageSet.ImageSetComponent)

local ItemTileEnums = require(scriptParentParent.Enum.ItemTileEnums)

local var1 = Roact.PureComponent:extend("ItemRestrictionStatus")

local vector2 = Vector2.new(50, 20)
local vector2_2 = Vector2.new(8, 8)

var1.validateProps = t.strictInterface(
    {
        restrictionTypes = t.map(ItemTileEnums.Restriction.isEnumValue, t.boolean),
        restrictionInfo = t.optional(t.table)
    }
)
local function getAdditionalText(restrictionTypes, restrictionInfo) -- Luacid: Inlined by compiler; 1 call site recovered
    local str1 = if restrictionTypes[ItemTileEnums.Restriction.LimitedUnique] then "#" else ""

    if restrictionTypes[ItemTileEnums.Restriction.Collectible] then
        return "#"
    end

    if restrictionInfo and restrictionInfo.limitedSerialNumber then
        str1 ..= " " .. restrictionInfo.limitedSerialNumber
    end

    return str1
end

local function getRestrictionIcon(restrictionTypes) -- Luacid: Inlined by compiler; 1 call site recovered
    if restrictionTypes[ItemTileEnums.Restriction.Collectible] then
        return Images["icons/status/item/limited"]
    end

    if restrictionTypes[ItemTileEnums.Restriction.Limited] or restrictionTypes[ItemTileEnums.Restriction.LimitedUnique] then
        return Images["icons/status/item/limited"]
    end

    return nil
end

function var1.render(arg1)
    return withStyle(function(arg2)
        local theme = arg2.Theme
        local font = arg2.Font
        local tokens = arg2.Tokens

        local restrictionInfo = arg1.props.restrictionInfo
        local restrictionTypes = arg1.props.restrictionTypes
        local additionalText = getAdditionalText(restrictionTypes, restrictionInfo)
        local font2 = font.CaptionHeader.Font
        local var2 = font.BaseSize * font.CaptionHeader.RelativeSize
        local textSize = GetTextSize(additionalText, var2, font2, vector2)
        local image = getRestrictionIcon(restrictionTypes)
        local var3 = image and image.ImageRectSize / Images.ImagesResolutionScale or Vector2.new(0, 0)

        local xOffset = var3.X + textSize.X + vector2_2.X
        local yOffset = math.max(var3.Y, textSize.Y) + vector2_2.Y

        return Roact.createElement(ImageSetComponent.Label, {
            AnchorPoint = Vector2.new(0, 1),
            BackgroundTransparency = 1,
            Image = Images["component_assets/circle_17"],
            ImageColor3 = theme.UIDefault.Color,
            ImageTransparency = theme.UIDefault.Transparency,
            ScaleType = Enum.ScaleType.Slice,
            SliceCenter = Rect.new(8, 8, 9, 9),
            Position = UDim2.new(0, tokens.Size.Size_200, 1, -tokens.Size.Size_200),
            Size = UDim2.new(0, xOffset, 0, yOffset)
        }, {
            Icon = image
                and Roact.createElement(ImageSetComponent.Label, {
                    AnchorPoint = Vector2.new(0, 0.5),
                    BackgroundTransparency = 1,
                    Image = image,
                    ImageColor3 = theme.IconEmphasis.Color,
                    ImageTransparency = theme.IconEmphasis.Transparency,
                    Position = UDim2.new(0, vector2_2.X / 2, 0.5, 0),
                    Size = UDim2.new(0, var3.X, 0, var3.Y)
                }),
            Text = Roact.createElement("TextLabel", {
                BackgroundTransparency = 1,
                FontFace = normalizeFontFace(font2),
                TextSize = var2,
                Text = additionalText,
                TextColor3 = theme.TextMuted.Color,
                TextTransparency = theme.TextMuted.TextTransparency,
                TextTruncate = Enum.TextTruncate.AtEnd,
                TextXAlignment = Enum.TextXAlignment.Center,
                TextYAlignment = Enum.TextYAlignment.Center,
                Position = UDim2.new(0, var3.X, 0, 0),
                Size = UDim2.new(0, textSize.X + 10, 1, 0)
            })
        })
    end)
end

return var1
