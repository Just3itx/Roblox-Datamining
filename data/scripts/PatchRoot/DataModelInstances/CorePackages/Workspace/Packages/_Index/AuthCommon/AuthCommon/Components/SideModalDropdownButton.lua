-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:20:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommonParent = script:FindFirstAncestor("AuthCommon").Parent

local React = require(AuthCommonParent.React)
local Foundation = require(AuthCommonParent.Foundation)
local Icon = Foundation.Icon
local FoundationText = Foundation.Text
local View = Foundation.View
local ControlState = Foundation.Enums.ControlState
local IconSize = Foundation.Enums.IconSize
local useTokens = Foundation.Hooks.useTokens

local function SideModalDropdown(tbl1)
    local var1 = useTokens()
    local var2, var3 = React.useState(false)
    local onStateChanged = React.useCallback(function(hover)
        if hover == ControlState.Hover then
            var3(true)
            return
        end
        var3(false)
    end, { var3 })

    local height = tbl1.height or 40

    local xScale = if tbl1.fixSizeToParent then 1 else 0

    local createElement = React.createElement
    local var5 = View
    local tbl2 = {
        Size = UDim2.new(xScale, 0, 0, height),
        tag = {
            ["auto-x"] = not tbl1.fixSizeToParent,
            ["radius-medium"] = true,
            ["align-x-left"] = true,
            ["align-y-center"] = true,
            ["padding-xxsmall"] = true,
            ["bg-shift-100"] = true
        },
        onStateChanged = onStateChanged,
        onActivated = tbl1.onActivated,
        backgroundStyle = tbl1.backgroundColorToken
    }
    local tbl3 = {
        UIStroke = React.createElement("UIStroke", {
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
            Color = if tbl1.isDropdownError then var1.Color.System.Alert.Color3 else var1.Color.Stroke.Default.Color3,
            Transparency = if tbl1.isDropdownError then var1.Color.System.Alert.Transparency elseif var2 then var1.Color.Stroke.Emphasis.Transparency else var1.Color.Stroke.Default.Transparency,
            Thickness = var1.Stroke.Standard
        }),
        UIListLayout = React.createElement("UIListLayout", {
            HorizontalFlex = Enum.UIFlexAlignment.SpaceBetween,
            FillDirection = Enum.FillDirection.Horizontal,
            SortOrder = Enum.SortOrder.LayoutOrder,
            VerticalAlignment = Enum.VerticalAlignment.Center
        }),
        Text = React.createElement(FoundationText, {
            Text = tbl1.text or "",
            TextXAlignment = Enum.TextXAlignment.Left,
            Size = UDim2.new(1, -40, 1, 0),
            tag = "text-truncate-split padding-left-small",
            LayoutOrder = 0
        }),
        IconContainer = React.createElement(View, {
            tag = "auto-xy padding-right-small",
            LayoutOrder = 1
        }, {
            Icon = React.createElement(Icon, { name = "icons/actions/truncationExpand", size = IconSize.Medium, LayoutOrder = 1 })
        })
    }
    return createElement(var5, tbl2, tbl3)
end

return SideModalDropdown
