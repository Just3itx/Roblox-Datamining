-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:10:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local AppFonts = require(CorePackages.Workspace.Packages.Style).AppFonts
local scriptParentParent = script.Parent.Parent
local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)
local Colors = require(scriptParentParent.Colors)
local RobloxTranslator = require(CorePackages.Workspace.Packages.RobloxTranslator)

local var1 = Roact.PureComponent:extend("NoInventoryNotice")

function var1.render(arg1)
    local locale = arg1.props.locale
    local assets = arg1.props.assets
    local isLoaded = arg1.props.isLoaded

    local createElement = Roact.createElement
    local str1 = "Frame"
    local tbl1 = {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Visible = 0
    }
    if next(assets) ~= nil then
        isLoaded = false
    end

    tbl1.Visible = isLoaded
    return createElement(str1, tbl1, {
        UIListLayout = Roact.createElement("UIListLayout", {
            Padding = UDim.new(0, 15),
            FillDirection = Enum.FillDirection.Vertical,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder,
            VerticalAlignment = Enum.VerticalAlignment.Center
        }),
        NotWearingImage = Roact.createElement(
            "ImageLabel",
            {
                AnchorPoint = Vector2.new(0.5, 0),
                BackgroundTransparency = 1,
                Size = UDim2.new(0.25, 0, 0.25, 0),
                LayoutOrder = 1,
                Image = "rbxasset://textures/ui/InspectMenu/ico_isnt-wearing.png",
                ImageColor3 = Colors.White
            },
            {
                UIAspectRatioConstraint = Roact.createElement("UIAspectRatioConstraint", { AspectRatio = 1 })
            }
        ),
        NotWearingText = Roact.createElement(
            "TextLabel",
            {
                BackgroundTransparency = 1,
                Size = UDim2.new(0.8, 0, 0.3, 0),
                LayoutOrder = 2,
                Font = AppFonts.default:getDefault(),
                Text = RobloxTranslator:FormatByKeyForLocale("InGame.InspectMenu.Description.NoInventoryNotice", locale),
                TextScaled = true,
                TextColor3 = Colors.White,
                TextSize = 20,
                TextXAlignment = Enum.TextXAlignment.Center,
                TextYAlignment = Enum.TextYAlignment.Top,
                TextWrapped = true
            },
            {
                UITextSizeConstraint = Roact.createElement("UITextSizeConstraint", { MaxTextSize = 20 })
            }
        )
    })
end

return RoactRodux.UNSTABLE_connect2(function(arg1, _)
    return {
        assets = arg1.assets,
        locale = arg1.locale,
        isLoaded = arg1.isLoaded
    }
end)(var1)
