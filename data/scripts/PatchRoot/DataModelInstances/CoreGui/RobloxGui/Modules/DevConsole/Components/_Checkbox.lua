-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:20:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local TextService = game:GetService("TextService")
local Roact = require(CorePackages.Packages.Roact)

local Constants = require(script.Parent.Parent.Constants)
local CheckboxInnerPadding = Constants.UtilityBarFormatting.CheckboxInnerPadding

local var1 = Roact.Component:extend("Checkbox")

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
    local check, num1

    if isSelected then
        check = Constants.Image.Check
        num1 = 0
    else
        selectedColor = unselectedColor
        check = ""
        num1 = 1
    end

    local textSizeX = TextService:GetTextSize(name, fontSize, font, Vector2.new(0, frameHeight)).X

    local createElement = Roact.createElement
    local tbl1 = {
        Size = UDim2.new(0, checkboxHeight + textSizeX + CheckboxInnerPadding * 2, 0, frameHeight),
        BackgroundTransparency = 1,
        LayoutOrder = layoutOrder
    }
    tbl1[Roact.Event.Activated] = function(_)
        onCheckboxClicked(name, not isSelected)
    end

    return createElement("ImageButton", tbl1, {
        Icon = Roact.createElement("ImageLabel", {
            Image = check,
            Size = UDim2.new(0, checkboxHeight, 0, checkboxHeight),
            Position = UDim2.new(0, 0, 0.5, -checkboxHeight / 2),
            BackgroundColor3 = selectedColor,
            BackgroundTransparency = 0,
            BorderColor3 = Constants.Color.Text,
            BorderSizePixel = num1
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
