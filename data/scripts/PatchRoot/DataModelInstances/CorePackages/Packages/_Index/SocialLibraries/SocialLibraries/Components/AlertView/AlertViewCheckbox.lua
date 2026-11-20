-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:41:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialLibraries = script:FindFirstAncestor("SocialLibraries")
local dependencies = require(SocialLibraries.dependencies)
local Roact = dependencies.Roact
local UIBlox = dependencies.UIBlox
local CheckIcon = require(script.Parent.CheckIcon)
local normalizeFontFace = dependencies.Foundation.Utility.normalizeFontFace

local var1 = Roact.Component:extend("AlertViewCheckbox")

var1.defaultProps = {
    Text = "",
    LayoutOrder = 0,
    onActivated = function() end,
    checked = false
}

function var1.render(arg1)
    return UIBlox.Style.withStyle(function(arg2)
        return Roact.createElement(
            "Frame",
            {
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                LayoutOrder = arg1.props.LayoutOrder,
                Size = UDim2.new(1, 0, 0, 35)
            },
            {
                List = Roact.createElement("UIListLayout", {
                    FillDirection = Enum.FillDirection.Horizontal,
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    VerticalAlignment = Enum.VerticalAlignment.Center,
                    Padding = UDim.new(0, 10)
                }),
                Checkbox = Roact.createElement(CheckIcon, {
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    LayoutOrder = 1,
                    checked = arg1.props.checked,
                    onActivated = arg1.props.onActivated
                }),
                Label = Roact.createElement("TextLabel", {
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    LayoutOrder = 2,
                    Size = UDim2.new(0.7, 0, 1, 0),
                    Text = arg1.props.Text,
                    TextColor3 = arg1.props.TextColor3 or arg2.Theme.TextDefault.Color,
                    TextSize = arg1.props.TextSize or arg2.Font.Body.RelativeSize * arg2.Font.BaseSize,
                    FontFace = normalizeFontFace(arg1.props.Font or arg2.Font.CaptionSubHeader.Font),
                    TextXAlignment = Enum.TextXAlignment.Left
                })
            }
        )
    end)
end
return var1
