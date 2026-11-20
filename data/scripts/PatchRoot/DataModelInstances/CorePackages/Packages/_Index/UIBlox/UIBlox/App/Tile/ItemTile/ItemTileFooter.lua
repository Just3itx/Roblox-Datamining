-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:10:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent
local scriptParentParentParentParentParent = scriptParentParentParentParent.Parent

local Roact = require(scriptParentParentParentParentParent.Roact)
local t = require(scriptParentParentParentParentParent.t)
local Foundation = require(scriptParentParentParentParentParent.Foundation)
local normalizeFontFace = Foundation.Utility.normalizeFontFace

local withStyle = require(scriptParentParentParentParent.Core.Style.withStyle)
local Images = require(scriptParentParentParentParent.App.ImageSet.Images)

local Skeleton = Foundation.Skeleton
local ImageSetComponent = require(scriptParentParentParentParent.Core.ImageSet.ImageSetComponent)

local var1 = Roact.PureComponent:extend("ItemTileFooter")

var1.validateProps = t.strictInterface({ priceText = t.optional(t.string), isOwned = t.optional(t.boolean) })

function var1.render(arg1)
    local priceText = arg1.props.priceText
    local isOwned = arg1.props.isOwned

    local iconsCommonRobuxSmall = Images["icons/common/robux_small"]
    if isOwned then
        iconsCommonRobuxSmall = Images["icons/status/item/owned"]
    end
    return withStyle(function(arg2)
        local font = arg2.Font.SubHeader1.Font
        local textSize = arg2.Font.BaseSize * arg2.Font.SubHeader1.RelativeSize
        local theme = arg2.Theme

        local var2 = iconsCommonRobuxSmall.ImageRectSize / Images.ImagesResolutionScale

        local var3 = priceText and tonumber(priceText:sub(1, 1))
        local var4 = priceText and (var3 or isOwned)

        local var5 = if var4 then var2.X + 4 else 0

        return Roact.createElement("Frame", {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1
        }, {
            Shimmer = not priceText and Roact.createElement(Skeleton, { Size = UDim2.new(0.8, 0, 0, textSize) }),
            icon = var4
                and Roact.createElement(ImageSetComponent.Label, {
                    BackgroundTransparency = 1,
                    Image = iconsCommonRobuxSmall,
                    ImageColor3 = theme.IconEmphasis.Color,
                    ImageTransparency = theme.IconEmphasis.Transparency,
                    Size = UDim2.new(0, var2.X, 0, var2.Y)
                }),
            TextLabel = priceText
                and Roact.createElement("TextLabel", {
                    AnchorPoint = Vector2.new(1, 0),
                    BackgroundTransparency = 1,
                    Position = UDim2.new(1, 0, 0, 0),
                    Size = UDim2.new(1, -var5, 1, 0),
                    FontFace = normalizeFontFace(font),
                    TextColor3 = theme.SecondaryContent.Color,
                    TextTransparency = theme.SecondaryContent.Transparency,
                    TextSize = textSize,
                    Text = priceText,
                    TextTruncate = Enum.TextTruncate.AtEnd,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextYAlignment = Enum.TextYAlignment.Top
                })
        })
    end)
end

return var1
