-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:31:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent
local scriptParentParentParentParentParent = scriptParentParentParentParent.Parent

local Roact = require(scriptParentParentParentParentParent.Roact)
local t = require(scriptParentParentParentParentParent.t)
local withStyle = require(scriptParentParentParentParent.Core.Style.withStyle)

local Core = scriptParentParentParentParent.Core
local getIconSize = require(scriptParentParentParent.ImageSet.getIconSize)
local IconSize = require(scriptParentParentParent.ImageSet.Enum.IconSize)
local Interactable = require(Core.Control.Interactable)
local ImageSetComponent = require(Core.ImageSet.ImageSetComponent)

local var1 = Roact.PureComponent:extend("ScrollButton")

var1.validateProps = t.strictInterface({ icon = t.table, callback = t.callback })

function var1.render(arg1)
    return withStyle(function(arg2)
        local createElement = Roact.createElement
        local var2 = Interactable
        local tbl1 = {
            AutoButtonColor = false,
            Size = UDim2.fromScale(1, 1),
            BackgroundColor3 = arg2.Theme.BackgroundUIContrast.Color,
            BackgroundTransparency = arg2.Theme.BackgroundUIContrast.Transparency,
            BorderSizePixel = 0,
            [Roact.Event.Activated] = arg1.props.callback
        }
        function tbl1.onStateChanged() end

        return createElement(var2, tbl1, {
            Icon = Roact.createElement(ImageSetComponent.Label, {
                Size = UDim2.fromOffset(getIconSize(IconSize.Medium), getIconSize(IconSize.Medium)),
                Position = UDim2.fromScale(0.5, 0.5),
                AnchorPoint = Vector2.new(0.5, 0.5),
                BackgroundTransparency = 1,
                Image = arg1.props.icon,
                ImageColor3 = arg2.Theme.IconEmphasis.Color,
                ImageTransparency = arg2.Theme.IconEmphasis.Transparency
            })
        })
    end)
end

return var1
