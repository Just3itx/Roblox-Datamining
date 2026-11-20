-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:50:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialLibraries = script:FindFirstAncestor("SocialLibraries")
local dependencies = require(SocialLibraries.dependencies)
local Roact = dependencies.Roact
local llama = dependencies.llama

local UIBlox = dependencies.UIBlox
local StyledTextLabel = UIBlox.App.Text.StyledTextLabel
local Style = UIBlox.Style

local _StyleTypes = require(script.Parent.StyleTypes)
local tbl1 = {
    width = require(script.Parent.Constants).TILE_SIZE
}

return function(tbl2)
    local var1 = llama.Dictionary.join(tbl1, tbl2)

    return Style.withStyle(function(arg1)
        local theme = arg1.Theme
        local font = arg1.Font
        local yOffset = font.BaseSize * font.CaptionHeader.RelativeSize

        return Roact.createElement(StyledTextLabel, {
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
            richText = false
        })
    end)
end
