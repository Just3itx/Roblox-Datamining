-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:31:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReporting = script:FindFirstAncestor("GenericAbuseReporting")
local GenericAbuseReportingParent = GenericAbuseReporting.Parent

local Foundation = require(GenericAbuseReportingParent.Foundation)
local React = require(GenericAbuseReportingParent.React)

local FoundationText = Foundation.Text
local useTokens = Foundation.Hooks.useTokens
local View = Foundation.View

local _AbuseReportBeduiTypes = require(GenericAbuseReporting.Bedui.Provider.AbuseReportBeduiTypes)
local SingleStepInnerContentRenderer = require(GenericAbuseReporting.Bedui.SingleStepInnerContentRenderer)

return React.memo(function(tbl1) -- name: SingleStepContainer
    local var1 = useTokens()

    local contentConfig = tbl1.contentConfig or tbl1.node.innerContentConfig

    local createElement = React.createElement
    local var3 = View
    local tbl2 = { tag = "size-full-0 auto-y col gap-medium" }

    local tbl3 = {
        Title = React.createElement(FoundationText, {
            Text = tbl1.node.title,
            fontStyle = var1.Typography.HeadingLarge,
            TextWrapped = true,
            TextXAlignment = Enum.TextXAlignment.Left,
            tag = "auto-xy padding-bottom-medium",
            LayoutOrder = 0
        }),
        Subtitle = 0,
        InnerContent = 0
    }
    local element

    if tbl1.node.subtitle and #tbl1.node.subtitle > 0 then
        element = React.createElement(FoundationText, {
            Text = tbl1.node.subtitle,
            fontStyle = var1.Typography.LabelLarge,
            TextWrapped = true,
            TextXAlignment = Enum.TextXAlignment.Left,
            tag = "auto-xy padding-bottom-medium",
            LayoutOrder = 1
        })
    else
        element = nil
    end

    tbl3.Subtitle = element

    tbl3.InnerContent = React.createElement(View, { tag = "size-full-0 auto-y", LayoutOrder = 2 }, {
        InnerContentRenderer = React.createElement(
            SingleStepInnerContentRenderer,
            {
                contentConfig = contentConfig,
                formDataKeysWithError = tbl1.formDataKeysWithError
            }
        )
    })
    return createElement(var3, tbl2, tbl3)
end)
