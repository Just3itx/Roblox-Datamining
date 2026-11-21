-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T13:40:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FlyoutSidePanelParent = script:FindFirstAncestor("FlyoutSidePanel").Parent
local React = require(FlyoutSidePanelParent.React)
local Foundation = require(FlyoutSidePanelParent.Foundation)
local useTokens = Foundation.Hooks.useTokens
local FoundationText = Foundation.Text
local Icon = Foundation.Icon
local IconSize = Foundation.Enums.IconSize
local StatusIndicator = Foundation.StatusIndicator
local StatusIndicatorVariant = Foundation.Enums.StatusIndicatorVariant
local Constants = require(script.Parent.Parent.Constants)
local getTestId = require(FlyoutSidePanelParent.RoactUtils).getTestId
local FFlagLuaAppAddTestIdsForArrow = require(FlyoutSidePanelParent.SharedFlags).FFlagLuaAppAddTestIdsForArrow

local function PrimaryNavigationItem(arg1)
    local var1 = useTokens()
    local createElement = React.createElement
    local view = Foundation.View
    local tbl1 = {
        tag = "size-full-0 auto-y",
        LayoutOrder = arg1.layoutOrder
    }
    local tbl2 = {
        PrimaryNavigationButton = React.createElement("TextButton", {
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            Text = "",
            [React.Event.Activated] = arg1.onActivated,
            [React.Tag] = if FFlagLuaAppAddTestIdsForArrow then getTestId("core-ui-flyout-nav-item", arg1.testId) else nil
        }, {
            UIListLayout = React.createElement("UIListLayout", {
                FillDirection = Enum.FillDirection.Horizontal,
                SortOrder = Enum.SortOrder.LayoutOrder,
                HorizontalAlignment = Enum.HorizontalAlignment.Left,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                Padding = UDim.new(0, var1.Gap.Small)
            }),
            IconContainer = if arg1.icon then React.createElement(
                Foundation.View,
                { tag = "auto-xy padding-small", LayoutOrder = 1 },
                {
                    Icon = React.createElement(Icon, { style = var1.Color.Content.Emphasis, name = arg1.icon, size = IconSize.Medium })
                }
            ) else nil,
            Text = if arg1.text then React.createElement(FoundationText, {
                LayoutOrder = 2,
                Text = arg1.text,
                tag = "auto-xy padding-y-small text-align-x-left text-truncate-end text-title-large text-wrap content-emphasis"
            }) else nil
        }),
        StatusIndicator = if arg1.notificationCount then React.createElement(StatusIndicator, {
            AnchorPoint = Vector2.new(1, 0.5),
            Position = UDim2.new(1, -var1.Gap.Medium, 0.5, 0),
            LayoutOrder = 3,
            value = arg1.notificationCount,
            variant = StatusIndicatorVariant.Emphasis,
            max = Constants.MAX_SHOWN_STATUS_INDICATOR_COUNT
        }) else nil
    }
    return createElement(view, tbl1, tbl2)
end

return PrimaryNavigationItem
