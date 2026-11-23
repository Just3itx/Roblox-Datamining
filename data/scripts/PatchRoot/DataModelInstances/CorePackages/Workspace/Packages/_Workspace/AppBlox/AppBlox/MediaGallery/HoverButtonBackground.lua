-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T06:30:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppBloxParent = script:FindFirstAncestor("AppBlox").Parent
local Roact = require(AppBloxParent.Roact)

local UIBlox = require(AppBloxParent.UIBlox)
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local validateImage = UIBlox.Core.ImageSet.Validator.validateImage
local withStyle = UIBlox.Core.Style.withStyle

local t = require(AppBloxParent.t)

local var1 = Roact.PureComponent:extend("HoverButtonBackground")

var1.validateProps = t.strictInterface(
    {
        sidePadding = t.optional(t.number),
        image = t.optional(validateImage),
        sliceCenter = t.optional(t.Rect)
    }
)
function var1.render(arg1)
    local var2

    if arg1.props.sidePadding then
        var2 = UDim2.new(arg1.props.sidePadding, UDim.new()) + UDim2.new(arg1.props.sidePadding, UDim.new())
    else
        var2 = UDim2.new()
    end
    return withStyle(function(arg2)
        local backgroundOnHover = arg2.Theme.BackgroundOnHover

        return Roact.createElement(
            ImageSetLabel,
            {
                Size = UDim2.fromScale(1, 1) + var2,
                AnchorPoint = Vector2.new(0.5, 0.5),
                Position = UDim2.fromScale(0.5, 0.5),
                BackgroundColor3 = if arg1.props.image then nil else backgroundOnHover.Color,
                BackgroundTransparency = if arg1.props.image then 1 else backgroundOnHover.Transparency,
                Image = arg1.props.image,
                ImageColor3 = backgroundOnHover.Color,
                ImageTransparency = backgroundOnHover.Transparency,
                ScaleType = Enum.ScaleType.Slice,
                SliceCenter = arg1.props.sliceCenter
            },
            {
                corner = if arg1.props.image then nil else Roact.createElement("UICorner", { CornerRadius = UDim.new(0, 8) })
            }
        )
    end)
end

return var1
