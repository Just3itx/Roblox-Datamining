-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:01:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent
local scriptParentParentParentParentParent = scriptParentParentParentParent.Parent

local Roact = require(scriptParentParentParentParentParent.Roact)
local t = require(scriptParentParentParentParentParent.t)
local withStyle = require(scriptParentParentParentParent.Core.Style.withStyle)

local Images = require(scriptParentParentParentParent.App.ImageSet.Images)
local ImageSetComponent = require(scriptParentParentParentParent.Core.ImageSet.ImageSetComponent)

local var1 = Roact.PureComponent:extend("TileSelectionOverlay")

var1.validateProps = t.strictInterface({ ZIndex = t.optional(t.integer), cornerRadius = t.optional(t.UDim) })

var1.defaultProps = {
    cornerRadius = UDim.new(0, 0)
}

function var1.render(arg1)
    local zIndex = arg1.props.ZIndex
    local cornerRadius = arg1.props.cornerRadius

    local iconsActionsSelectOn = Images["icons/actions/selectOn"]
    local var2 = iconsActionsSelectOn.ImageRectSize / Images.ImagesResolutionScale

    return withStyle(function(arg2)
        local theme = arg2.Theme
        local tokens = arg2.Tokens

        return Roact.createElement("Frame", {
            BackgroundColor3 = theme.Overlay.Color,
            BackgroundTransparency = theme.Overlay.Transparency,
            BorderSizePixel = 0,
            Size = UDim2.new(1, 0, 1, 0),
            ZIndex = zIndex
        }, {
            SelectionImage = Roact.createElement(ImageSetComponent.Label, {
                AnchorPoint = Vector2.new(1, 0),
                BackgroundTransparency = 1,
                Image = iconsActionsSelectOn,
                Position = UDim2.new(1, -tokens.Size.Size_50, 0, tokens.Size.Size_50),
                Size = UDim2.new(0, var2.X, 0, var2.Y)
            }),
            UICorner = if cornerRadius == UDim.new(0, 0) then nil else Roact.createElement("UICorner", { CornerRadius = cornerRadius }) or nil
        })
    end)
end

return var1
