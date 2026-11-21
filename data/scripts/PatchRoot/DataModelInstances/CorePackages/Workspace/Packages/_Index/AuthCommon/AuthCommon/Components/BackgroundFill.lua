-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:11:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommonParent = script:FindFirstAncestor("AuthCommon").Parent
local Foundation = require(AuthCommonParent.Foundation)
local Roact = require(AuthCommonParent.Roact)

local var1 = Roact.PureComponent:extend("BackgroundFill")

function var1.render(arg1)
    local image = arg1.props.Image

    return Roact.createElement(Foundation.Image, {
        Image = image,
        Size = UDim2.new(1, 0, 1, 0),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BorderSizePixel = 0,
        ScaleType = Enum.ScaleType.Crop
    })
end

return var1
