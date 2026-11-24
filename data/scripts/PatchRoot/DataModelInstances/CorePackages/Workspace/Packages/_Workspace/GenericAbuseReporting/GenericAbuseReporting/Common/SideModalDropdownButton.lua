-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:51:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReportingParent = script:FindFirstAncestor("GenericAbuseReporting").Parent

local React = require(GenericAbuseReportingParent.React)
local Foundation = require(GenericAbuseReportingParent.Foundation)
local Icon = Foundation.Icon
local FoundationText = Foundation.Text
local View = Foundation.View
local ControlState = Foundation.Enums.ControlState
local IconSize = Foundation.Enums.IconSize
local useTokens = Foundation.Hooks.useTokens
local useLocalization = require(GenericAbuseReportingParent.Localization).Hooks.useLocalization

local FFlagPrefillPreciseSelectionChoices = require(GenericAbuseReportingParent.SharedFlags).FFlagPrefillPreciseSelectionChoices

local function SideModalDropdown(tbl1)
    local var1 = useTokens()
    local var2, var3 = React.useState(false)
    local var4 = useLocalization({ ChooseOne = "Feature.ReportAbuse.Label.ChooseOne" })

    local onStateChanged = React.useCallback(function(hover)
        if hover == ControlState.Hover then
            var3(true)
            return
        end
        var3(false)
    end, { var3 })

    local createElement = React.createElement
    local var6 = View
    local tbl2 = {
        Size = if FFlagPrefillPreciseSelectionChoices then UDim2.new(1, 0, 0, 48) else UDim2.new(0, 0, 0, 48),
        tag = "auto-x radius-medium align-x-left align-y-center padding-xxsmall bg-shift-100",
        onStateChanged = onStateChanged,
        onActivated = tbl1.onActivated,
        LayoutOrder = if FFlagPrefillPreciseSelectionChoices then tbl1.layoutOrder else nil
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
            Text = tbl1.text or var4.ChooseOne,
            TextXAlignment = Enum.TextXAlignment.Left,
            Size = UDim2.new(1, -44, 1, 0),
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
    return createElement(var6, tbl2, tbl3)
end

return SideModalDropdown
