-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:50:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialLibraries = script:FindFirstAncestor("SocialLibraries")
local Roact = require(SocialLibraries.dependencies).Roact

local CallbackInputBox = require(script.Parent.CallbackInputBox)
local var1 = Roact.PureComponent:extend("CallbackInputBoxWithIcon")

var1.defaultProps = {
    backgroundTransparency = 0,
    backgroundColor3 = Color3.new(1, 1, 1),
    borderColor = nil,
    borderThickness = 0,
    borderTransparency = 1,
    cornerRadius = 0,
    iconCellWidth = 60,
    iconSize = 24,
    iconColor3 = Color3.new(1, 1, 1),
    iconTransparency = 0,
    iconImage = "rbxasset://textures/ui/LuaChat/icons/ic-search.png",
    inputTextFont = Enum.Font.BuilderSans,
    inputTextColor3 = Color3.new(1, 0, 1),
    inputTextSize = 14,
    inputTextYAlignment = Enum.TextYAlignment.Center,
    inputTextXAlignment = Enum.TextXAlignment.Left,
    inputTextTransparency = 0,
    placeholderTextTransparency = 0.6,
    placeholderTextColor3 = Color3.new(1, 0, 0),
    placeholderText = "Test placeholder text",
    clearIconColor3 = Color3.new(1, 1, 0),
    clearIcon = "rbxasset://textures/ui/LuaChat/icons/ic-close-white.png",
    clearButtonDisabled = nil,
    textChangedCallback = nil
}

function var1.render(arg1)
    local iconCellWidth = arg1.props.iconCellWidth
    local iconSize = arg1.props.iconSize

    return Roact.createElement("Frame", {
        BackgroundTransparency = arg1.props.backgroundTransparency,
        BackgroundColor3 = arg1.props.backgroundColor3,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 1, 0)
    }, {
        UIStroke = Roact.createElement(
            "UIStroke",
            {
                Thickness = arg1.props.borderThickness,
                Color = arg1.props.borderColor,
                Transparency = arg1.props.borderTransparency
            }
        ),
        UICorner = Roact.createElement("UICorner", { CornerRadius = UDim.new(0, arg1.props.cornerRadius) }),
        layout = Roact.createElement("UIListLayout", {
            VerticalAlignment = Enum.VerticalAlignment.Center,
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            FillDirection = Enum.FillDirection.Horizontal,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, iconCellWidth / 4)
        }),
        padding = Roact.createElement("UIPadding", { PaddingLeft = UDim.new(0, iconCellWidth / 4) }),
        icon = Roact.createElement("ImageLabel", {
            BackgroundTransparency = 1,
            Size = UDim2.new(0, iconSize, 0, iconSize),
            ImageColor3 = arg1.props.iconColor3,
            ImageTransparency = arg1.props.iconTransparency,
            Image = arg1.props.iconImage,
            LayoutOrder = 1
        }),
        inputBoxContainer = Roact.createElement(
            "Frame",
            {
                BackgroundTransparency = 1,
                Size = UDim2.new(1, -iconSize - iconCellWidth / 4, 1, 0),
                LayoutOrder = 2
            },
            {
                padding = Roact.createElement("UIPadding", { PaddingRight = UDim.new(0, iconCellWidth / 4) }),
                inputBox = Roact.createElement(CallbackInputBox, arg1.props)
            }
        )
    })
end
return var1
