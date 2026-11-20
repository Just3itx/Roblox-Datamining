-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:21:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Roact = require(CorePackages.Packages.Roact)

local var1 = Roact.PureComponent:extend("IconButton")

function var1.render(arg1)
    local visible = arg1.props.visible
    local anchorPoint = arg1.props.anchorPoint
    local position = arg1.props.position
    local size = arg1.props.size
    local zIndex = arg1.props.zIndex
    local onClick = arg1.props.onClick

    local horizontalAlignment = arg1.props.iconHorizontalAlignment or Enum.HorizontalAlignment.Center
    local verticalAlignment = arg1.props.iconVerticalAlignment or Enum.VerticalAlignment.Center
    local iconSpritePath = arg1.props.iconSpritePath
    local iconSpriteFrame = arg1.props.iconSpriteFrame

    local horizontalInset = arg1.props.horizontalInset or 12
    local num1 = 0
    local num2 = 1

    if horizontalAlignment == Enum.HorizontalAlignment.Center then
        horizontalInset = 0
    elseif horizontalAlignment == Enum.HorizontalAlignment.Left then
        position = UDim2.new(position.X.Scale, position.X.Offset - horizontalInset, position.Y.Scale, position.Y.Offset)
    elseif horizontalAlignment == Enum.HorizontalAlignment.Right then
        position = UDim2.new(position.X.Scale, position.X.Offset + horizontalInset, position.Y.Scale, position.Y.Offset)
        num1 = 1
        num2 = 0
    end

    local uDim2 = UDim2.new(size.X.Scale, size.X.Offset + horizontalInset, size.Y.Scale, size.Y.Offset)

    return Roact.createElement("ImageButton", {
        Visible = visible,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        AnchorPoint = anchorPoint,
        Position = position,
        Size = uDim2,
        ZIndex = zIndex,
        [Roact.Event.Activated] = onClick
    }, {
        IconLayout = Roact.createElement("UIListLayout", {
            HorizontalAlignment = horizontalAlignment,
            VerticalAlignment = verticalAlignment,
            FillDirection = Enum.FillDirection.Horizontal,
            SortOrder = Enum.SortOrder.LayoutOrder
        }),
        Offset = Roact.createElement("Frame", { BorderSizePixel = 0, LayoutOrder = num1, Size = UDim2.new(0, horizontalInset, 0, 0) }),
        BackIcon = Roact.createElement("ImageLabel", {
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Size = UDim2.new(0, iconSpriteFrame.size.X, 0, iconSpriteFrame.size.Y),
            Image = iconSpritePath,
            ImageRectOffset = iconSpriteFrame.offset,
            ImageRectSize = iconSpriteFrame.size,
            ZIndex = zIndex,
            LayoutOrder = num2
        })
    })
end

return var1
