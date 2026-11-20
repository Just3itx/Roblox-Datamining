-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:01:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent
local scriptParentParentParentParentParent = scriptParentParentParentParent.Parent

local Roact = require(scriptParentParentParentParentParent.Roact)
local t = require(scriptParentParentParentParentParent.t)

local Images = require(scriptParentParentParentParent.App.ImageSet.Images)
local ImageSetComponent = require(scriptParentParentParentParent.Core.ImageSet.ImageSetComponent)
local withStyle = require(scriptParentParentParentParent.Core.Style.withStyle)

local var1 = Roact.PureComponent:extend("TileUnselectedOverlay")

local squirclesHollow = Images["squircles/hollow"]

var1.validateProps = t.strictInterface({ ZIndex = t.optional(t.integer) })

function var1.render(arg1)
    local zIndex = arg1.props.ZIndex

    return withStyle(function(arg2)
        local tokens = arg2.Tokens

        return Roact.createElement(
            "Frame",
            {
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Size = UDim2.new(1, 0, 1, 0),
                ZIndex = zIndex
            },
            {
                SelectionImage = Roact.createElement(ImageSetComponent.Label, {
                    AnchorPoint = Vector2.new(1, 0),
                    BackgroundTransparency = 1,
                    Image = squirclesHollow,
                    Position = UDim2.new(1, -tokens.Size.Size_200, 0, tokens.Size.Size_200),
                    Size = UDim2.fromOffset(24, 24)
                })
            }
        )
    end)
end
return var1
