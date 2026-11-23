-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:20:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local Cryo = require(AppChatParent.Cryo)
local Foundation = require(AppChatParent.Foundation)
local React = require(AppChatParent.React)
local UIBlox = require(AppChatParent.UIBlox)
local useCountdownBinding = require(AppChatParent.InterventionShared).Hooks.useCountdownBinding

local Images = UIBlox.App.ImageSet.Images
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local Interactable = UIBlox.Core.Control.Interactable

local tbl1 = {
    bodyText = "Chat Disabled",
    defaultCountdownString = "",
    onActivated = function() end,
    contentVerticalAlignment = Enum.VerticalAlignment.Top
}

local function ChatInputBoxDisabled(tbl2)
    local var1 = Cryo.Dictionary.union(tbl1, tbl2)
    local var2 = Foundation.Hooks.useTokens()
    local var3 = useCountdownBinding(var1.endTimestamp, var1.defaultCountdownString)
    local textYAlignment = if var1.contentVerticalAlignment == Enum.VerticalAlignment.Center then Enum.TextYAlignment.Center elseif var1.contentVerticalAlignment == Enum.VerticalAlignment.Bottom then Enum.TextYAlignment.Bottom else Enum.TextYAlignment.Top
    local createElement = React.createElement
    local var4 = Interactable
    local tbl3 = {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
        [React.Event.Activated] = var1.onActivated,
        ref = var1.navigationTargetRef
    }
    local tbl4 = {
        uiListLayout = React.createElement("UIListLayout", {
            Padding = UDim.new(0, var2.Gap.Small),
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            VerticalAlignment = var1.contentVerticalAlignment,
            SortOrder = Enum.SortOrder.LayoutOrder
        }),
        disabledText = React.createElement(Foundation.Text, {
            BackgroundTransparency = 1,
            Size = UDim2.new(0, 0, 1, 0),
            Text = var1.bodyText,
            fontStyle = Cryo.Dictionary.join(var2.Typography.BodyLarge, { FontSize = var1.contentSize }),
            TextSize = var1.contentSize,
            textStyle = var2.Color.System.Alert,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = textYAlignment,
            TextWrapped = false,
            TextTruncate = Enum.TextTruncate.AtEnd,
            tag = "fill",
            LayoutOrder = 1
        }),
        countdownText = 0,
        icon = 0
    }
    local element

    if var1.endTimestamp == nil then
        element = nil
    else
        element = React.createElement(Foundation.Text, {
            BackgroundTransparency = 1,
            AutomaticSize = Enum.AutomaticSize.X,
            Size = UDim2.new(0, 0, 1, 0),
            Text = var3,
            fontStyle = Cryo.Dictionary.join(var2.Typography.BodyLarge, { FontSize = var1.contentSize }),
            TextSize = var1.contentSize,
            textStyle = var2.Color.Content.Emphasis,
            TextXAlignment = Enum.TextXAlignment.Center,
            TextYAlignment = textYAlignment,
            TextWrapped = false,
            LayoutOrder = 2
        })
    end

    tbl4.countdownText = element

    tbl4.icon = React.createElement(ImageSetLabel, {
        Size = UDim2.new(0, var1.contentSize, 0, var1.contentSize),
        BackgroundTransparency = 1,
        ImageColor3 = var2.Color.System.Alert.Color3,
        ImageTransparency = var2.Color.System.Alert.Transparency,
        Image = Images["icons/status/error_large"],
        LayoutOrder = 3
    })
    return createElement(var4, tbl3, tbl4)
end

return ChatInputBoxDisabled
