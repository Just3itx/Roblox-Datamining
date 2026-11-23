-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T05:11:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local Roact = require(scriptParentParent.Roact)

local var1 = require(scriptParentParent.RobloxTranslator):FormatByKey("Feature.NativeAds.Label.Ad")

local UIBlox = require(scriptParentParent.UIBlox)
local ImageSetButton = UIBlox.Core.ImageSet.ImageSetButton

local Images = UIBlox.App.ImageSet.Images
local iconsMenuMore_on = Images["icons/menu/more_on"]
local iconsMenuMore_off = Images["icons/menu/more_off"]

local var2 = Roact.Component:extend("AdLabel")

function var2.render(arg1)
    local createElement = Roact.createElement
    local tbl1 = {
        Position = UDim2.fromScale(0.995, 0.995),
        BackgroundColor3 = Color3.new(0, 0, 0),
        BorderSizePixel = 0,
        AnchorPoint = Vector2.new(1, 1),
        Size = UDim2.fromScale(0.11447368421, 0.10108771929),
        Visible = arg1.props.Visible
    }
    local tbl2 = {
        Label = Roact.createElement("TextLabel", {
            LayoutOrder = 1,
            Text = var1,
            TextColor3 = Color3.new(1, 1, 1),
            BackgroundTransparency = 1,
            Font = Enum.Font.Gotham,
            TextSize = 100,
            TextScaled = true,
            TextWrapped = false,
            Position = UDim2.fromScale(0.134084726, 0.5),
            AnchorPoint = Vector2.new(0, 0.5),
            Size = UDim2.fromScale(0.40808394869, 0.77610536218)
        }),
        MenuButton = Roact.createElement(ImageSetButton, {
            LayoutOrder = 2,
            Image = arg1.props.isMenuOpen and iconsMenuMore_on or iconsMenuMore_off,
            BackgroundTransparency = 1,
            Size = UDim2.fromScale(0.4, 0),
            Position = UDim2.fromScale(0.76, 0.5),
            AnchorPoint = Vector2.new(0.5, 0.5),
            [Roact.Event.Activated] = arg1.props.onActivated
        }, {
            UIAspectRatioConstraint = Roact.createElement("UIAspectRatioConstraint", { AspectRatio = 1, AspectType = Enum.AspectType.ScaleWithParentSize })
        })
    }
    return createElement("Frame", tbl1, tbl2)
end

return var2
