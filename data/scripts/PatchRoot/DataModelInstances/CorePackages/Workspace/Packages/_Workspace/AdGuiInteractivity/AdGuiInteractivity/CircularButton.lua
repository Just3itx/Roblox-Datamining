-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T05:11:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local Roact = require(scriptParentParent.Roact)

local ImageSetLabel = require(scriptParentParent.UIBlox).Core.ImageSet.ImageSetLabel

local var1 = Roact.Component:extend("CircularButton")

function var1.render(arg1)
    local var2 = if typeof(arg1.props.Transparency) == "table" then arg1.props.Transparency:map(function(arg2)
        return arg2 < 1 and arg1.props.Visible
    end) else arg1.props.Visible and arg1.props.Transparency < 1

    return Roact.createElement("TextButton", {
        Size = UDim2.fromScale(arg1.props.HorizontalScale, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        Position = arg1.props.Position,
        AnchorPoint = arg1.props.AnchorPoint,
        BackgroundColor3 = Color3.fromRGB(17, 18, 19),
        Transparency = arg1.props.Transparency,
        Text = "",
        Visible = var2,
        AutoButtonColor = arg1.props.AutoButtonColor,
        [Roact.Event.Activated] = arg1.props.onActivated
    }, {
        UIAspectRatioConstraint = Roact.createElement("UIAspectRatioConstraint", { AspectRatio = 1, AspectType = Enum.AspectType.ScaleWithParentSize }),
        UICorner = Roact.createElement("UICorner", { CornerRadius = UDim.new(0.5, 0) }),
        ImageLabel = Roact.createElement(ImageSetLabel, {
            BackgroundTransparency = 1,
            Size = arg1.props.ImageSize,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale(0.5, 0.5),
            Image = arg1.props.Image,
            ImageTransparency = arg1.props.Transparency
        })
    })
end

return var1
