-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:01:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent
local scriptParentParentParentParentParent = scriptParentParentParentParent.Parent

local Roact = require(scriptParentParentParentParentParent.Roact)
local t = require(scriptParentParentParentParentParent.t)
local Foundation = require(scriptParentParentParentParentParent.Foundation)
local withStyle = require(scriptParentParentParentParent.Core.Style.withStyle)

local Images = require(scriptParentParentParentParent.App.ImageSet.Images)
local Skeleton = Foundation.Skeleton
local ImageTextLabel = require(scriptParentParentParentParent.Core.Text.ImageTextLabel.ImageTextLabel)
local EmojiTextLabel = require(scriptParentParentParentParent.Core.Text.EmojiTextLabel.EmojiTextLabel)
local Emoji = require(scriptParentParentParentParent.Core.Emoji.Enum.Emoji)
local validateFontInfo = require(scriptParentParentParentParent.Core.Style.Validator.validateFontInfo)
local validateTypographyInfo = require(scriptParentParentParentParent.Core.Style.Validator.validateTypographyInfo)

local var1 = Roact.PureComponent:extend("ItemTileName")

var1.validateProps = t.strictInterface({
    LayoutOrder = t.optional(t.integer),
    maxHeight = t.intersection(t.number, t.numberMin(0)),
    maxWidth = t.intersection(t.number, t.numberMin(0)),
    name = t.optional(t.string),
    titleIcon = t.optional(t.table),
    nameTextColor = t.optional(t.Color3),
    nameTextTransparency = t.optional(t.number),
    richText = t.optional(t.boolean),
    hasVerifiedBadge = t.optional(t.boolean),
    useMaxHeight = t.optional(t.boolean),
    fluidSizing = t.optional(t.boolean),
    titleFontStyle = t.optional(t.union(validateFontInfo, validateTypographyInfo)),
    horizontalAlignment = t.optional(t.enum(Enum.HorizontalAlignment))
})

function var1.render(arg1)
    local layoutOrder = arg1.props.LayoutOrder
    local maxHeight = arg1.props.maxHeight
    local maxWidth = arg1.props.maxWidth
    local name = arg1.props.name
    local titleIcon = arg1.props.titleIcon
    local useMaxHeight = arg1.props.useMaxHeight
    local fluidSizing = arg1.props.fluidSizing
    local hasVerifiedBadge = arg1.props.hasVerifiedBadge
    local richText = arg1.props.richText
    local center = if arg1.props.horizontalAlignment == Enum.HorizontalAlignment.Center then Enum.TextXAlignment.Center else nil

    return withStyle(function(arg2)
        local theme = arg2.Theme
        local font = arg2.Font

        local fontStyle = arg1.props.titleFontStyle or font.Header2
        local yOffset = if fontStyle.RelativeSize then font.BaseSize * fontStyle.RelativeSize else fontStyle.FontSize

        if name == nil then
            return Roact.createElement(
                "Frame",
                {
                    BackgroundTransparency = 1,
                    LayoutOrder = layoutOrder,
                    Size = UDim2.new(0, maxWidth, 0, maxHeight)
                },
                {
                    FirstLine = Roact.createElement(Skeleton, { Size = UDim2.new(1, 0, 0, yOffset) }),
                    SecondLine = Roact.createElement(Skeleton, { Position = UDim2.fromOffset(0, yOffset + 4), Size = UDim2.new(0.4, 0, 0, yOffset) })
                }
            )
        end

        local vector2 = Vector2.new(maxWidth, maxHeight)

        local colorStyle = {
            Color = arg1.props.nameTextColor or theme.TextEmphasis.Color,
            Transparency = arg1.props.nameTextTransparency or theme.TextEmphasis.Transparency
        }

        if hasVerifiedBadge then
            return Roact.createElement(EmojiTextLabel, {
                RichText = richText,
                maxSize = vector2,
                fluidSizing = fluidSizing,
                emoji = Emoji.Verified,
                fontStyle = fontStyle,
                colorStyle = colorStyle,
                Text = name,
                TextTruncate = Enum.TextTruncate.SplitWord,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextYAlignment = Enum.TextYAlignment.Top,
                LayoutOrder = layoutOrder
            })
        end

        local var3 = titleIcon and titleIcon.ImageRectSize / Images.ImagesResolutionScale or Vector2.new(0, 0)

        return Roact.createElement(ImageTextLabel, {
            imageProps = titleIcon
                and {
                    BackgroundTransparency = 1,
                    Image = titleIcon,
                    ImageColor3 = theme.IconEmphasis.Color,
                    ImageTransparency = theme.IconEmphasis.Transparency,
                    Size = UDim2.new(0, var3.X, 0, var3.Y),
                    AnchorPoint = Vector2.new(0, 0),
                    Position = UDim2.new(0, 0, 0, 0)
                }
                or nil,
            genericTextLabelProps = {
                fluidSizing = fluidSizing,
                fontStyle = fontStyle,
                colorStyle = colorStyle,
                Text = name,
                TextTruncate = Enum.TextTruncate.SplitWord,
                RichText = richText,
                TextXAlignment = center
            },
            frameProps = { BackgroundTransparency = 1, LayoutOrder = layoutOrder },
            maxSize = vector2,
            padding = 4,
            useMaxHeight = useMaxHeight
        })
    end)
end

return var1
