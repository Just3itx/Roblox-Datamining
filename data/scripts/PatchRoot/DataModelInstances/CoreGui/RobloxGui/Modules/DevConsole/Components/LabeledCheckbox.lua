-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:30:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local TextService = game:GetService("TextService")
local Roact = require(CorePackages.Packages.Roact)

local Constants = require(script.Parent.Parent.Constants)
local Checkbox = require(script.Parent.Checkbox)
local CheckboxInnerPadding = Constants.UtilityBarFormatting.CheckboxInnerPadding

local var1 = Roact.Component:extend("LabeledCheckbox")

function var1.render(arg1)
    local checkboxHeight = arg1.props.checkboxHeight
    local frameHeight = arg1.props.frameHeight
    local layoutOrder = arg1.props.layoutOrder

    local name = arg1.props.name
    local font = arg1.props.font
    local fontSize = arg1.props.fontSize

    local isSelected = arg1.props.isSelected
    local selectedColor = arg1.props.selectedColor
    local unselectedColor = arg1.props.unselectedColor
    local onCheckboxClicked = arg1.props.onCheckboxClicked

    local textSizeX = TextService:GetTextSize(name, fontSize, font, Vector2.new(0, frameHeight)).X

    return Roact.createElement("Frame", {
        Size = UDim2.new(0, checkboxHeight + textSizeX + CheckboxInnerPadding * 2, 0, frameHeight),
        BackgroundTransparency = 1,
        LayoutOrder = layoutOrder
    }, {
        Checkbox = Roact.createElement(Checkbox, {
            Name = name,
            IsSelected = isSelected,
            SelectedColor = selectedColor,
            UnselectedColor = unselectedColor,
            Size = UDim2.new(0, checkboxHeight, 0, checkboxHeight),
            Position = UDim2.new(0, 0, 0.5, -checkboxHeight / 2),
            OnSelectedStateChanged = onCheckboxClicked
        }),
        Text = Roact.createElement("TextLabel", {
            Text = name,
            TextColor3 = Constants.Color.Text,
            TextXAlignment = Enum.TextXAlignment.Left,
            Font = font,
            TextSize = fontSize,
            Size = UDim2.new(1, -frameHeight, 1, 0),
            Position = UDim2.new(0, checkboxHeight + CheckboxInnerPadding, 0, 0),
            BackgroundTransparency = 1
        })
    })
end

return var1
