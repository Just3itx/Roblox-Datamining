-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:40:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local Translator = require(scriptParentParentParent.Translations.Translator)
local React = require(scriptParentParentParentParent.React)
local normalizeFontFace = require(scriptParentParentParentParent.Foundation).Utility.normalizeFontFace

local useStyle = require(scriptParentParentParent.Core.Style.useStyle)

local function labelText(inputLabel: string, none: boolean?) -- Luacid: Inlined by compiler; 1 call site recovered
    if none == nil or none == React.None then
        return inputLabel
    elseif none then
        return inputLabel .. "*"
    end

    return (Translator:FormatByKey("CommonUI.Controls.Input.Optional", { inputLabel = inputLabel }))
end

local function InputLabel(tbl1)
    local var1 = useStyle()

    local bodySmall = var1.Tokens.Typography.BodySmall
    local default = var1.Tokens.Color.Content.Default

    return React.createElement("TextLabel", {
        Text = labelText(tbl1.text, tbl1.required),
        TextTransparency = default.Transparency,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Top,
        TextWrapped = true,
        BackgroundTransparency = 1,
        TextColor3 = default.Color3,
        FontFace = normalizeFontFace(bodySmall.Font),
        TextSize = bodySmall.FontSize,
        LineHeight = bodySmall.LineHeight,
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        LayoutOrder = tbl1.LayoutOrder
    })
end

return InputLabel
