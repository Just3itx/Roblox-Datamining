-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T06:31:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppBloxParent = script:FindFirstAncestor("AppBlox").Parent
local Roact = require(AppBloxParent.Roact)
local UIBlox = require(AppBloxParent.UIBlox)
local t = require(AppBloxParent.t)

local withStyle = UIBlox.Core.Style.withStyle
local getIconSize = UIBlox.App.ImageSet.getIconSize
local IconSize = UIBlox.App.ImageSet.Enum.IconSize
local Interactable = UIBlox.Core.Control.Interactable
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel

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
            Icon = Roact.createElement(ImageSetLabel, {
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
