-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:31:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReporting = script:FindFirstAncestor("GenericAbuseReporting")
local GenericAbuseReportingParent = GenericAbuseReporting.Parent

local Foundation = require(GenericAbuseReportingParent.Foundation)
local React = require(GenericAbuseReportingParent.React)

local View = Foundation.View

local AbuseReportBeduiTypes = require(GenericAbuseReporting.Bedui.Provider.AbuseReportBeduiTypes)
local BeduiAnalytics = require(GenericAbuseReporting.Bedui.Utils.BeduiAnalytics)
local ComponentType = AbuseReportBeduiTypes.ComponentType
local Dropdown = require(GenericAbuseReporting.Bedui.Components.Dropdown)
local FreeComment = require(GenericAbuseReporting.Bedui.Components.FreeComment)
local Paragraph = require(GenericAbuseReporting.Bedui.Components.Paragraph)
local Selector = require(GenericAbuseReporting.Bedui.Components.Selector)
local sendAnalyticsEvent = BeduiAnalytics.sendAnalyticsEvent
local TelemetryEventType = BeduiAnalytics.TelemetryEventType
local useAnalyticsContext = require(GenericAbuseReporting.Bedui.Provider.useAnalyticsContext)
local WebViewLink = require(GenericAbuseReporting.Bedui.Components.WebViewLink)

local FFlagAddThumbnailSelectorReport = require(GenericAbuseReportingParent.SharedFlags).FFlagAddThumbnailSelectorReport

return React.memo(function(tbl1) -- name: SingleStepInnerContentRenderer
    local context = useAnalyticsContext()

    local var2 = React.useMemo(function()
        if tbl1.contentConfig == nil then
            return {}
        end

        local result = ({})
        if tbl1.contentConfig.type ~= "configurableComponentList" then
            return {}
        end

        for layoutOrder, component in ipairs(tbl1.contentConfig.configurableComponentList.components) do
            if component.componentType == ComponentType.Dropdown then
                local str1 = `{component.componentType}{layoutOrder}`
                result[str1] = React.createElement(Dropdown, {
                    component = component,
                    isErrorState = not (component.formDataKey == nil) and table.find(tbl1.formDataKeysWithError, component.formDataKey) ~= nil,
                    layoutOrder = layoutOrder
                })
            elseif component.componentType == ComponentType.FreeComment then
                local str1 = `{component.componentType}{layoutOrder}`
                result[str1] = React.createElement(FreeComment, {
                    component = component,
                    isErrorState = not (component.formDataKey == nil) and table.find(tbl1.formDataKeysWithError, component.formDataKey) ~= nil,
                    layoutOrder = layoutOrder
                })
            elseif component.componentType == ComponentType.Paragraph then
                result[`{component.componentType}{layoutOrder}`] = React.createElement(Paragraph, { component = component, layoutOrder = layoutOrder })
            elseif component.componentType == ComponentType.WebViewLink then
                result[`{component.componentType}{layoutOrder}`] = React.createElement(WebViewLink, { component = component, layoutOrder = layoutOrder })
            elseif FFlagAddThumbnailSelectorReport and component.componentType == ComponentType.Selector then
                local str1 = `{component.componentType}{layoutOrder}`
                result[str1] = React.createElement(Selector, {
                    abuseVector = context.abuseVector,
                    component = component,
                    isErrorState = not (component.formDataKey == nil) and table.find(tbl1.formDataKeysWithError, component.formDataKey) ~= nil,
                    layoutOrder = layoutOrder
                })
            else
                sendAnalyticsEvent({
                    eventType = TelemetryEventType.Error,
                    context = context,
                    meta = {
                        error = `SingleStepInnerContentRenderer - Unsupported component type: {component.componentType}`
                    }
                })
            end
        end
        return result
    end, {
        tbl1.contentConfig,
        tbl1.formDataKeysWithError,
        sendAnalyticsEvent,
        context
    })
    return React.createElement(View, { tag = "size-full-0 auto-y col gap-xxlarge" }, var2)
end)
