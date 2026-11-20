-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:01:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent
local scriptParentParentParentParentParent = scriptParentParentParentParent.Parent

local Roact = require(scriptParentParentParentParentParent.Roact)
local t = require(scriptParentParentParentParentParent.t)
local normalizeFontFace = require(scriptParentParentParentParentParent.Foundation).Utility.normalizeFontFace
local withStyle = require(scriptParentParentParentParent.Core.Style.withStyle)

local var1 = Roact.PureComponent:extend("TileBanner")

var1.validateProps = t.strictInterface({ bannerText = t.string })

function var1.render(arg1)
    local bannerText = arg1.props.bannerText

    return withStyle(function(arg2)
        local font = arg2.Font
        local theme = arg2.Theme

        local yOffset = 6 + font.CaptionBody.RelativeSize * font.BaseSize

        return Roact.createElement("Frame", {
            BackgroundColor3 = theme.SystemPrimaryDefault.Color,
            BackgroundTransparency = theme.SystemPrimaryDefault.Transparency,
            BorderSizePixel = 0,
            Size = UDim2.new(1, 0, 0, yOffset)
        }, {
            TextLabel = Roact.createElement("TextLabel", {
                BackgroundTransparency = 1,
                FontFace = normalizeFontFace(font.CaptionBody.Font),
                TextSize = font.CaptionBody.RelativeSize * font.BaseSize,
                Text = bannerText,
                TextColor3 = theme.SystemPrimaryContent.Color,
                TextTransparency = theme.SystemPrimaryContent.Transparency,
                TextTruncate = Enum.TextTruncate.AtEnd,
                TextXAlignment = Enum.TextXAlignment.Center,
                Size = UDim2.new(1, 0, 1, 0)
            })
        })
    end)
end

return var1
