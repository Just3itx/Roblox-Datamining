-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:20:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")

local Roact = require(CorePackages.Packages.Roact)

local ShareGame = RobloxGui.Modules.Settings.Pages.ShareGame
local Constants = require(ShareGame.Constants)
local Theme = require(RobloxGui.Modules.Settings.Theme)

local Font = Theme.font(Enum.Font.SourceSans, "ConversationDetails")
local WHITE = Constants.Color.WHITE
local TextSize = Theme.textSize(19)

local var1 = Theme.font(Enum.Font.SourceSans, "ConversationDetails")
local GRAY3 = Constants.Color.GRAY3
local yOffset2 = Theme.textSize(16, "ConversationDetails")

local var2 = Theme.font(Enum.Font.SourceSans, "ConversationDetails")
local yOffset3 = Theme.textSize(16, "ConversationDetails")

local var4 = require(ShareGame.getTranslator)()

local var5 = Roact.PureComponent:extend("ConversationDetails")

function var5.render(arg1)
    local title = arg1.props.title
    local subtitle = arg1.props.subtitle
    local presence = arg1.props.presence
    local size = arg1.props.size
    local layoutOrder = arg1.props.layoutOrder
    local zIndex = arg1.props.zIndex
    local element = if subtitle == nil then nil else Roact.createElement("TextLabel", {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, yOffset2),
        Text = subtitle,
        Font = var1,
        TextColor3 = GRAY3,
        TextSize = yOffset2,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextWrapped = true,
        LayoutOrder = 1,
        ZIndex = zIndex
    })
    local element2

    if presence == nil then
        element2 = nil
    else
        element2 = Roact.createElement("TextLabel", {
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, yOffset3),
            Text = var4:FormatByKey(Constants.PresenceTextKey[presence]),
            Font = var2,
            TextColor3 = Constants.PresenceColors[presence],
            TextSize = yOffset3,
            TextXAlignment = Enum.TextXAlignment.Left,
            LayoutOrder = 2,
            ZIndex = zIndex
        })
    end

    return Roact.createElement(
        "Frame",
        { BackgroundTransparency = 1, Size = size, LayoutOrder = layoutOrder, ZIndex = zIndex },
        {
            UIListLayout = Roact.createElement("UIListLayout", {
                FillDirection = Enum.FillDirection.Vertical,
                HorizontalAlignment = Enum.HorizontalAlignment.Left,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, 2)
            }),
            Title = Roact.createElement("TextLabel", {
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 0, TextSize),
                Text = title or "",
                Font = Font,
                TextColor3 = WHITE,
                TextSize = TextSize,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextWrapped = true,
                LayoutOrder = 0,
                ZIndex = zIndex
            }),
            Subtitle = element,
            Presence = element2
        }
    )
end
return var5
