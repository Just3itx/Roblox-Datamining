-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T23:21:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local StreamNotifications = script:FindFirstAncestor("StreamNotifications")
local StreamNotificationsParent = StreamNotifications.Parent
local constants = require(StreamNotifications.constants)
local React = require(StreamNotificationsParent.React)
local Foundation = require(StreamNotificationsParent.Foundation)
local useLocalization = require(StreamNotificationsParent.Localization).Hooks.useLocalization

local useStyle = require(StreamNotificationsParent.UIBlox).Core.Style.useStyle
local useTokens = Foundation.Hooks.useTokens
local normalizeFontFace = Foundation.Utility.normalizeFontFace

return function()
    local var1 = useStyle()
    local var2 = useTokens()
    local fontFace = normalizeFontFace(var2.Typography.TitleLarge.Font)
    local fontSize = var2.Typography.TitleLarge.FontSize
    local var4 = useLocalization({ emptyText = constants.Text.EmptyKey })

    return React.createElement("Frame", {
        AutomaticSize = Enum.AutomaticSize.XY,
        Position = UDim2.new(0.5, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 1
    }, {
        UIListLayout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            SortOrder = Enum.SortOrder.LayoutOrder,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            Padding = UDim.new(0, constants.DefaultPadding)
        }),
        React.createElement("TextLabel", {
            Text = var4 and var4.emptyText,
            LayoutOrder = 2,
            FontFace = fontFace,
            TextSize = fontSize,
            BackgroundTransparency = 1,
            TextColor3 = var1.Theme.TextDefault.Color,
            Size = UDim2.new(1, 0, 0, constants.EmptyNotifications.LabelHeight)
        })
    })
end
