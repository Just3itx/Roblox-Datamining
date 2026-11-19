-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:31:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)
local Roact = InGameMenuDependencies.Roact
local UIBlox = InGameMenuDependencies.UIBlox
local t = InGameMenuDependencies.t

local withStyle = UIBlox.Core.Style.withStyle

local scriptParentParent = script.Parent.Parent
local FFlagLuaMenuPerfImprovements = require(scriptParentParent.Flags.FFlagLuaMenuPerfImprovements)

local Assets = require(scriptParentParent.Resources.Assets)

local ImageSetButton = UIBlox.Core.ImageSet.ImageSetButton

local var1 = Roact.PureComponent:extend("MoreButton")

var1.validateProps = t.strictInterface(
    {
        onActivated = t.callback,
        LayoutOrder = t.integer,
        userId = FFlagLuaMenuPerfImprovements and t.number or nil
    }
)
function var1.init(arg1)
    if FFlagLuaMenuPerfImprovements then
        function arg1.onActivated()
            arg1.props.onActivated(arg1.props.userId)
        end
    end
end

function var1.render(arg1)
    return withStyle(function(arg2)
        local onActivated = arg1.props.onActivated
        if FFlagLuaMenuPerfImprovements then
            onActivated = arg1.props.onActivated and arg1.onActivated or nil
        end
        return Roact.createElement(ImageSetButton, {
            Size = UDim2.new(0, 36, 0, 36),
            BackgroundTransparency = 1,
            Image = Assets.Images.MoreActions,
            ImageColor3 = arg2.Theme.IconEmphasis.Color,
            LayoutOrder = arg1.props.LayoutOrder,
            [Roact.Event.Activated] = onActivated
        })
    end)
end

return var1
