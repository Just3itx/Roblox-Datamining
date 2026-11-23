-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:01:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local Roact = require(AppChatParent.Roact)

local withStyle = require(AppChatParent.UIBlox).Style.withStyle
local ChatLoadingIndicator = require(script.Parent.ChatLoadingIndicator)

local FFlagAppIaScrollAway = require(AppChatParent.SharedFlags).FFlagAppIaScrollAway
local FFlagAppThemeHalloween2026ChatBackground = require(AppChat.Flags.FFlagAppThemeHalloween2026ChatBackground)

local var1 = Roact.PureComponent:extend("ChatLoadingContainer")

var1.defaultProps = {
    topBarHeight = 0,
    cellHeight = 64,
    cellWidth = 375,
    topPadding = if FFlagAppIaScrollAway then 0 else nil
}

function var1.render(arg1)
    local pageBackgroundTransparency = arg1.props.pageBackgroundTransparency
    return withStyle(function(arg2)
        return Roact.createElement("Frame", {
            Name = if FFlagAppThemeHalloween2026ChatBackground then "ChatLoadingContainer" else nil,
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundColor3 = arg2.Theme.BackgroundDefault.Color,
            BackgroundTransparency = if pageBackgroundTransparency ~= nil then pageBackgroundTransparency else arg2.Tokens.Color.None.Transparency,
            BorderSizePixel = 0,
            ClipsDescendants = true
        }, {
            UIListLayout = Roact.createElement("UIListLayout", {
                SortOrder = Enum.SortOrder.LayoutOrder,
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                FillDirection = Enum.FillDirection.Vertical
            }),
            UIPadding = if FFlagAppIaScrollAway and arg1.props.topPadding > 0 then Roact.createElement("UIPadding", { PaddingTop = UDim.new(0, arg1.props.topPadding) }) else nil,
            ChatLoadingFrame = Roact.createElement(
                "Frame",
                {
                    Size = UDim2.new(1, 0, 1, 0),
                    BackgroundTransparency = 1,
                    LayoutOrder = 2
                },
                {
                    ChatLoadingIndicator = Roact.createElement(ChatLoadingIndicator, {
                        cellHeight = arg1.props.cellHeight,
                        cellWidth = arg1.props.cellWidth,
                        pageBackgroundTransparency = pageBackgroundTransparency
                    })
                }
            )
        })
    end)
end
return var1
