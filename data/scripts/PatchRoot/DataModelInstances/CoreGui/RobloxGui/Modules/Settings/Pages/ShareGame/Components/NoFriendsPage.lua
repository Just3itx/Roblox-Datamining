-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:21:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")

local ShareGame = RobloxGui.Modules.Settings.Pages.ShareGame

local Roact = require(CorePackages.Packages.Roact)
local Constants = require(ShareGame.Constants)

local ShareGameIcons = require(ShareGame.Spritesheets.ShareGameIcons)
local frame = ShareGameIcons:GetFrame("friends")
local Image = ShareGameIcons:GetImagePath()
local Theme = require(RobloxGui.Modules.Settings.Theme)

local var1 = require(ShareGame.getTranslator)()

local var2 = Roact.PureComponent:extend("NoFriendsPage")

function var2.render(arg1)
    local layoutOrder = arg1.props.LayoutOrder
    local zIndex = arg1.props.ZIndex
    local propsPosition = arg1.props.Position

    local num1 = 0
    local function incrementLayoutOrder(): number -- Luacid: Inlined by compiler; 4 call sites recovered
        num1 += 1
        return num1
    end

    return Roact.createElement("Frame", {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
        LayoutOrder = layoutOrder,
        ZIndex = zIndex,
        Position = propsPosition
    }, {
        listLayout = Roact.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder
        }),
        friendsIcon = Roact.createElement("ImageLabel", {
            BackgroundTransparency = 1,
            Image = Image,
            ImageRectOffset = frame.offset,
            ImageRectSize = frame.size,
            Size = UDim2.new(0, 72, 0, 72),
            LayoutOrder = incrementLayoutOrder(),
            ZIndex = zIndex
        }),
        iconToSubtitleSpacer = Roact.createElement(
            "Frame",
            {
                BackgroundTransparency = 1,
                Size = UDim2.new(0, 0, 0, 34),
                LayoutOrder = incrementLayoutOrder(),
                ZIndex = zIndex
            }
        ),
        subtitle = Roact.createElement("TextLabel", {
            BackgroundTransparency = 1,
            Text = var1:FormatByKey("Feature.SettingsHub.Label.NoFriendsScreen"),
            TextColor3 = Constants.Color.GRAY5,
            TextTransparency = 0.22,
            TextSize = Theme.textSize(21),
            TextWrapped = true,
            Font = Theme.font(Enum.Font.SourceSans),
            LayoutOrder = incrementLayoutOrder(),
            Size = UDim2.new(0, 280, 0, 42),
            TextYAlignment = Enum.TextYAlignment.Top,
            ZIndex = zIndex
        }),
        bottomSpacer = Roact.createElement(
            "Frame",
            {
                BackgroundTransparency = 1,
                Size = UDim2.new(0, 0, 0, 120),
                LayoutOrder = incrementLayoutOrder(),
                ZIndex = zIndex
            }
        )
    })
end
return var2
