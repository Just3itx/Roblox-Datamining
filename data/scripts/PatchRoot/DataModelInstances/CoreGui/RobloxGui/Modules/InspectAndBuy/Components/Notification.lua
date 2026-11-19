-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:10:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local scriptParentParent = script.Parent.Parent
local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)
local AppFonts = require(CorePackages.Workspace.Packages.Style).AppFonts
local Colors = require(scriptParentParent.Colors)
local RobloxTranslator = require(CorePackages.Workspace.Packages.RobloxTranslator)

local var1 = Roact.PureComponent:extend("Notification")

function var1.render(arg1)
    local locale = arg1.props.locale
    local noticeKey = arg1.props.noticeKey

    return Roact.createElement(
        "Frame",
        {
            Size = UDim2.new(1, -10, 0, 45),
            LayoutOrder = 0,
            BackgroundTransparency = 1,
            BorderSizePixel = 0
        },
        {
            UIListLayout = Roact.createElement("UIListLayout", {
                Padding = UDim.new(0, 10),
                FillDirection = Enum.FillDirection.Horizontal,
                SortOrder = Enum.SortOrder.LayoutOrder,
                VerticalAlignment = Enum.VerticalAlignment.Center
            }),
            ExclamationPoint = Roact.createElement("ImageLabel", {
                Size = UDim2.new(0, 16, 0, 16),
                BackgroundTransparency = 1,
                Image = "rbxasset://textures/ui/InspectMenu/ico_alert_tilt.png",
                ImageColor3 = Colors.White,
                LayoutOrder = 1
            }),
            PartOfBundleText = Roact.createElement(
                "TextLabel",
                {
                    Size = UDim2.new(1, -30, 1, 0),
                    TextColor3 = Colors.White,
                    BorderSizePixel = 0,
                    BackgroundTransparency = 1,
                    LayoutOrder = 2,
                    TextWrapped = true,
                    TextScaled = true,
                    TextSize = 12,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Font = AppFonts.default:getDefault(),
                    Text = RobloxTranslator:FormatByKeyForLocale(noticeKey, locale)
                },
                {
                    UITextSizeConstraint = Roact.createElement("UITextSizeConstraint", { MaxTextSize = 16 })
                }
            )
        }
    )
end

return RoactRodux.UNSTABLE_connect2(function(arg1, _)
    return {
        locale = arg1.locale
    }
end)(var1)
