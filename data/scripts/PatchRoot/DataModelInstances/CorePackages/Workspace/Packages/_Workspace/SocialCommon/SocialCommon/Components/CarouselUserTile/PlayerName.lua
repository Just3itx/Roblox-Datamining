-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T15:11:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialCommonParent = script:FindFirstAncestor("SocialCommon").Parent
local React = require(SocialCommonParent.React)
local Cryo = require(SocialCommonParent.Cryo)

local UIBlox = require(SocialCommonParent.UIBlox)
local GetTextSize = require(SocialCommonParent.Style).GetTextSize
local StyledTextLabel = UIBlox.App.Text.StyledTextLabel
local useStyle = UIBlox.Core.Style.useStyle

local tbl1 = {
    width = require(script.Parent.Constants).TILE_SIZE
}

return function(tbl2)
    local var1 = Cryo.Dictionary.join(tbl1, tbl2)
    local var2 = useStyle()

    local theme = var2.Theme
    local font = var2.Font

    local yOffset = React.useMemo(function()
        return GetTextSize(
            var1.name,
            font.BaseSize * font.CaptionHeader.RelativeSize,
            var2.Tokens.Typography.CaptionLarge.Font,
            Vector2.new(10000, 10000)
        ).Y
    end, { var1.name, font.BaseSize * font.CaptionHeader.RelativeSize, var2.Tokens.Typography.CaptionLarge.Font })

    return React.createElement(StyledTextLabel, {
        layoutOrder = var1.layoutOrder,
        text = var1.name,
        fontStyle = font.CaptionHeader,
        colorStyle = theme.TextEmphasis,
        size = UDim2.fromOffset(var1.width, yOffset),
        textTruncate = Enum.TextTruncate.AtEnd,
        textXAlignment = Enum.TextXAlignment.Left,
        textYAlignment = Enum.TextYAlignment.Center,
        lineHeight = 1,
        fluidSizing = false,
        richText = true
    })
end
