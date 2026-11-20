-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:30:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent
local scriptParentParentParentParentParent = scriptParentParentParentParent.Parent

local React = require(scriptParentParentParentParentParent.React)
local Cryo = require(scriptParentParentParentParentParent.Cryo)

local _StyleTypes = require(scriptParentParentParentParent.App.Style.StyleTypes)
local _validateFontInfo = require(scriptParentParentParentParent.Core.Style.Validator.validateFontInfo)
local _validateColorInfo = require(scriptParentParentParentParent.Core.Style.Validator.validateColorInfo)
local useStyle = require(scriptParentParentParentParent.Core.Style.useStyle)
local GetTextSize = require(scriptParentParentParentParent.Core.Text.GetTextSize)
local GetFontFromFontStyle = require(scriptParentParentParentParent.Core.Text.GetFontFromFontStyle)

local Emoji = scriptParentParentParentParent.Core.Emoji
local Emoji2 = require(Emoji.Emoji)
local Emoji3 = require(Emoji.Enum.Emoji)

local GenericTextLabel = require(scriptParentParentParentParent.Core.Text.GenericTextLabel.GenericTextLabel)

local tbl1 = {
    maxSize = Vector2.new(10000, 10000),
    fluidSizing = false
}

local function EmojiTextLabel(tbl2)
    tbl2 = Cryo.Dictionary.join(tbl1, tbl2)

    local var1 = useStyle()
    local var2 = Emoji3.isEnumValue(tbl2.emoji)
    local baseSize = var1.Font.BaseSize
    local colorStyle = tbl2.colorStyle

    local fontStyle = tbl2.fontStyle
    local textFont = GetFontFromFontStyle(fontStyle)
    local var3 = if fontStyle.RelativeSize then baseSize * fontStyle.RelativeSize else fontStyle.FontSize
    local maxSize = tbl2.maxSize

    local textSize = GetTextSize(tbl2.Text, var3, textFont, maxSize)
    local xOffset = math.min(textSize.X, maxSize.X - var3)

    local var4 = Cryo.Dictionary.join(tbl2, {
        emoji = Cryo.None,
        emojiOnActivated = Cryo.None,
        colorStyle = colorStyle,
        Size = UDim2.fromOffset(xOffset, textSize.Y)
    })

    return React.createElement(GenericTextLabel, var4, {
        Emoji = var2
            and React.createElement(Emoji2, {
                emoji = tbl2.emoji,
                onActivated = tbl2.emojiOnActivated,
                textFont = textFont,
                textSize = var3,
                Position = UDim2.fromScale(1, 0)
            })
    })
end

return EmojiTextLabel
