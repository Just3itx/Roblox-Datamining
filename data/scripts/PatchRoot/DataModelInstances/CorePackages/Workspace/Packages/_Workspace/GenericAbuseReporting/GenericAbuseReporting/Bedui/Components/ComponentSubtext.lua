-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:30:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReportingParent = script:FindFirstAncestor("GenericAbuseReporting").Parent

local React = require(GenericAbuseReportingParent.React)
local Foundation = require(GenericAbuseReportingParent.Foundation)
local FoundationText = Foundation.Text
local useTokens = Foundation.Hooks.useTokens

return React.memo(function(tbl1) -- name: ComponentSubtext
    local var1 = useTokens()

    return React.createElement(FoundationText, {
        Text = tbl1.requirementMessage,
        textStyle = if tbl1.isOptional then var1.Color.Content.Muted else var1.Color.System.Alert,
        fontStyle = var1.Typography.CaptionMedium,
        tag = "auto-xy",
        Visible = not not (tbl1.isOptional or tbl1.isErrorState),
        LayoutOrder = tbl1.layoutOrder
    })
end)
