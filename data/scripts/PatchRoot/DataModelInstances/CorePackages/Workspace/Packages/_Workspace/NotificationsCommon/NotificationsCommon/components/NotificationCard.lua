-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T00:20:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent
local context = scriptParentParent.context
local dependencies = require(scriptParentParent.dependencies)
local React = dependencies.React
local UIBlox = dependencies.UIBlox
local NotificationContentFrame = require(scriptParent.NotificationContentFrame)
local useStyle = UIBlox.Core.Style.useStyle
local constants = require(scriptParentParent.constants)
local useNotificationCardData = require(context.useNotificationCardData)

local DefaultCardPadding = constants.Padding.DefaultCardPadding
local DefaultContentPadding = constants.DefaultContentPadding
local DefaultCardCornerRadius = constants.DefaultCardCornerRadius

return function(tbl1)
    local var1 = useNotificationCardData()
    local cardSize = var1.cardSize
    local backgroundTransparency = if var1.cardTransparency then var1.cardTransparency else constants.CardTransparency.Default
    local offset = if cardSize and cardSize.cardPadding then cardSize.cardPadding else DefaultCardPadding
    local var3 = useStyle()

    return React.createElement("Frame", {
        Size = UDim2.new(1, 0, 0, 0),
        BackgroundColor3 = var3.Theme.BackgroundUIDefault.Color,
        BackgroundTransparency = backgroundTransparency,
        BorderSizePixel = 0,
        AutomaticSize = Enum.AutomaticSize.Y,
        LayoutOrder = tbl1.layoutOrder
    }, {
        UICorner = React.createElement("UICorner", { CornerRadius = DefaultCardCornerRadius }),
        UIListLayout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            Padding = UDim.new(0, DefaultContentPadding),
            SortOrder = Enum.SortOrder.LayoutOrder,
            VerticalAlignment = Enum.VerticalAlignment.Center
        }),
        UIPadding = React.createElement("UIPadding", {
            PaddingBottom = UDim.new(0, offset),
            PaddingLeft = UDim.new(0, offset),
            PaddingRight = UDim.new(0, offset),
            PaddingTop = UDim.new(0, offset)
        }),
        NotificationContentFrame = React.createElement(NotificationContentFrame)
    })
end
