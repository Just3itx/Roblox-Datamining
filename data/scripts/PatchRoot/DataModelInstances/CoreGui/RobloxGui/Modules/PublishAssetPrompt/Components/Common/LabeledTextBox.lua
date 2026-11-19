-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:11:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local React = require(CorePackages.Packages.React)
local UIBlox = require(CorePackages.Packages.UIBlox)
local normalizeFontFace = require(CorePackages.Packages.Foundation).Utility.normalizeFontFace
local Cryo = require(CorePackages.Packages.Cryo)

local useStyle = UIBlox.Core.Style.useStyle

local scriptParent = script.Parent

local NameTextBox = require(scriptParent.NameTextBox)

local tbl1 = { textBoxHeight = 30, topPadding = 0 }

local function LabeledTextBox(tbl2)
    local var1 = Cryo.Dictionary.join(tbl1, tbl2)

    local var2 = useStyle()
    local font = var2.Font
    local baseSize = font.BaseSize
    local theme = var2.Theme

    local yOffset = 19 + var1.textBoxHeight + var1.topPadding

    local captionHeader = font.CaptionHeader
    local textDefaultColor = theme.TextDefault.Color

    return React.createElement(
        "Frame",
        {
            Size = UDim2.new(1, 0, 0, yOffset),
            BackgroundTransparency = 1,
            LayoutOrder = var1.LayoutOrder
        },
        {
            UIListLayout = React.createElement("UIListLayout", {
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                SortOrder = Enum.SortOrder.LayoutOrder,
                FillDirection = Enum.FillDirection.Vertical,
                Padding = UDim.new(0, 4)
            }),
            UIPadding = React.createElement("UIPadding", { PaddingTop = UDim.new(0, var1.topPadding) }),
            TextboxLabel = React.createElement("TextLabel", {
                Size = UDim2.new(1, 0, 0, 15),
                FontFace = normalizeFontFace(var2.Tokens.Typography.CaptionLarge.Font),
                Text = var1.labelText,
                TextSize = baseSize * captionHeader.RelativeSize,
                TextColor3 = textDefaultColor,
                BackgroundTransparency = 1,
                TextXAlignment = Enum.TextXAlignment.Left,
                LayoutOrder = 1
            }),
            Textbox = React.createElement(NameTextBox, {
                Size = UDim2.new(1, 0, 0, var1.textBoxHeight),
                maxLength = var1.maxLength,
                onNameUpdated = var1.onTextUpdated,
                defaultName = var1.defaultText,
                centerText = var1.centerText,
                nameTextBoxRef = var1.textBoxRef,
                LayoutOrder = 2,
                invalidInputText = var1.invalidInputText
            })
        }
    )
end
return LabeledTextBox
