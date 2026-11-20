-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:21:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")

local ShareGame = RobloxGui.Modules.Settings.Pages.ShareGame

local Roact = require(CorePackages.Packages.Roact)
local Constants = require(ShareGame.Constants)
local Theme = require(RobloxGui.Modules.Settings.Theme)

local var1 = require(ShareGame.getTranslator)()

local var2 = Roact.PureComponent:extend("FriendsErrorPage")

function var2.render(arg1)
    local layoutOrder = arg1.props.LayoutOrder
    local zIndex = arg1.props.ZIndex

    local num1 = 0
    local function incrementLayoutOrder(): number -- Luacid: Inlined by compiler; 1 call site recovered
        num1 += 1
        return num1
    end

    return Roact.createElement(
        "Frame",
        {
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 1, 0),
            LayoutOrder = layoutOrder,
            ZIndex = zIndex
        },
        {
            listLayout = Roact.createElement("UIListLayout", {
                FillDirection = Enum.FillDirection.Vertical,
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                SortOrder = Enum.SortOrder.LayoutOrder
            }),
            subtitle = Roact.createElement("TextLabel", {
                BackgroundTransparency = 1,
                Text = var1:FormatByKey("Feature.SettingsHub.Label.LoadingFriendsListFailed"),
                TextColor3 = Constants.Color.GRAY5,
                TextTransparency = 0.22,
                TextSize = Theme.textSize(21),
                TextWrapped = true,
                Font = Theme.font(Enum.Font.SourceSans),
                LayoutOrder = incrementLayoutOrder(),
                Size = UDim2.new(0, 280, 0, 42),
                TextYAlignment = Enum.TextYAlignment.Top,
                ZIndex = zIndex
            })
        }
    )
end
return var2
