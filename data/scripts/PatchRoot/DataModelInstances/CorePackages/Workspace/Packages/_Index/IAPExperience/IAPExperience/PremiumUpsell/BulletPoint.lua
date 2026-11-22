-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:11:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local UIBlox = require(scriptParentParentParent.UIBlox)
local Roact = require(scriptParentParentParent.Roact)
local Foundation = require(scriptParentParentParent.Foundation)
local GetTextSize = require(scriptParentParentParent.Style).GetTextSize
local normalizeFontFace = Foundation.Utility.normalizeFontFace

local Images = UIBlox.App.ImageSet.Images
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local withStyle = UIBlox.Style.withStyle
local IconSize = UIBlox.App.Constant.IconSize

local xOffset = IconSize.Small + 16

return function(tbl1)
    return withStyle(function(arg1)
        local theme = arg1.Theme
        local font = arg1.Font

        local text = tbl1.text
        local textSize = font.Body.RelativeSize * font.BaseSize
        local var2 = if text ~= nil then GetTextSize(
            text,
            textSize,
            arg1.Tokens.Typography.BodyLarge.Font,
            Vector2.new(tbl1.width - xOffset, 10000),
            { addTemporaryPadding = false }
        ) else Vector2.new(0, 0)
        return Roact.createElement(
            "Frame",
            {
                Size = UDim2.new(1, 0, 0, var2.Y),
                BackgroundTransparency = 1,
                LayoutOrder = tbl1.layoutOrder
            },
            {
                Bullet = Roact.createElement(ImageSetLabel, {
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, 2, 0, 2),
                    Size = UDim2.new(0, IconSize.Small, 0, IconSize.Small),
                    ScaleType = Enum.ScaleType.Stretch,
                    Image = Images["icons/status/success_small"],
                    ImageColor3 = theme.IconDefault.Color,
                    ImageTransparency = theme.IconDefault.Transparency
                }),
                Text = Roact.createElement("TextLabel", {
                    Position = UDim2.new(0, xOffset, 0, 0),
                    Size = UDim2.new(1, -xOffset, 0, var2.Y),
                    BackgroundTransparency = 1,
                    Text = text,
                    TextSize = textSize,
                    TextColor3 = theme.TextDefault.Color,
                    TextTransparency = theme.TextDefault.Transparency,
                    FontFace = normalizeFontFace(arg1.Tokens.Typography.BodyLarge.Font),
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextWrapped = true,
                    LayoutOrder = tbl1.layoutOrder
                })
            }
        )
    end)
end
