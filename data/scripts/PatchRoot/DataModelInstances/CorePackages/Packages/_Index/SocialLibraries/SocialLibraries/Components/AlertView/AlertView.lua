-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:41:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialLibraries = script:FindFirstAncestor("SocialLibraries")
local dependencies = require(SocialLibraries.dependencies)
local Roact = dependencies.Roact
local UIBlox = dependencies.UIBlox
local FitFrameVertical = require(script.Parent.Parent.FitFrameVertical)

local var1 = Roact.Component:extend("AlertView")

var1.defaultProps = {
    Visible = false,
    width = UDim.new(0.5, 0),
    contentPaddingLeft = 12,
    contentPaddingRight = 12,
    contentPaddingTop = 12,
    contentPaddingBottom = 12
}

function var1.render(arg1)
    return UIBlox.Style.withStyle(function(arg2)
        return Roact.createElement(FitFrameVertical, {
            Visible = arg1.props.Visible,
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundColor3 = arg2.Theme.BackgroundUIDefault.Color,
            Position = UDim2.new(0.5, 0, 0.5, 0),
            width = arg1.props.width
        }, {
            InnerFrame = Roact.createElement(FitFrameVertical, {
                margin = {
                    top = arg1.props.contentPaddingTop,
                    bottom = arg1.props.contentPaddingBottom,
                    left = arg1.props.contentPaddingLeft,
                    right = arg1.props.contentPaddingRight
                },
                width = UDim.new(1, 0),
                BackgroundTransparency = 1,
                HorizontalAlignment = Enum.HorizontalAlignment.Center
            }, arg1.props[Roact.Children])
        })
    end)
end

return var1
