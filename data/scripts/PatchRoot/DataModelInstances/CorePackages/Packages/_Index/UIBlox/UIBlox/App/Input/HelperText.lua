-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:40:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local React = require(scriptParentParentParentParent.React)
local normalizeFontFace = require(scriptParentParentParentParent.Foundation).Utility.normalizeFontFace

local useStyle = require(scriptParentParentParent.Core.Style.useStyle)

local function HelperText(tbl1)
    local var1 = useStyle()

    local captionSmall = var1.Tokens.Typography.CaptionSmall
    local var2 = if tbl1.error then var1.Tokens.Color.ActionAlert.Foreground else var1.Tokens.Color.Content.Default
    return React.createElement("TextLabel", {
        Text = tbl1.text,
        TextTransparency = var2.Transparency,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Top,
        TextWrapped = true,
        BackgroundTransparency = 1,
        TextColor3 = var2.Color3,
        FontFace = normalizeFontFace(captionSmall.Font),
        TextSize = captionSmall.FontSize,
        LineHeight = captionSmall.LineHeight,
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        LayoutOrder = tbl1.LayoutOrder
    })
end

return HelperText
