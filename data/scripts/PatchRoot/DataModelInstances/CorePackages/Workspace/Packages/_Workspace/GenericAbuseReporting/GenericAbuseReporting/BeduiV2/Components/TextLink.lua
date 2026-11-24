-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:41:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReportingParent = script:FindFirstAncestor("GenericAbuseReporting").Parent

local Foundation = require(GenericAbuseReportingParent.Foundation)
local React = require(GenericAbuseReportingParent.React)

local ControlState = Foundation.Enums.ControlState
local getIconRichText = Foundation.Utility.getIconRichText
local IconName = Foundation.Enums.IconName
local FoundationText = Foundation.Text

return React.memo(function(tbl1) -- name: TextLink
    local var1, var2 = React.useState(false)
    local iconRichText = getIconRichText(IconName.ArrowUpRightFromSquare)

    local onStateChanged = React.useCallback(function(hover)
        var2(hover == ControlState.Hover)
    end, {})

    return React.createElement(FoundationText, {
        Text = if var1 then `<u>{tbl1.text}</u> {iconRichText}` else `{tbl1.text} {iconRichText}`,
        RichText = true,
        onActivated = tbl1.onActivated,
        onStateChanged = onStateChanged,
        tag = tbl1.tag or "auto-xy text-body-medium text-wrap text-align-x-left radius-small content-emphasis",
        LayoutOrder = tbl1.layoutOrder
    })
end)
