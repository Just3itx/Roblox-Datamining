-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T16:01:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReporting = script:FindFirstAncestor("GenericAbuseReporting")
local GenericAbuseReportingParent = GenericAbuseReporting.Parent
local React = require(GenericAbuseReportingParent.React)
local AnalyticsProvider = require(GenericAbuseReporting.Analytics.AnalyticsProvider)
local LayerCollectorProvider = require(GenericAbuseReportingParent.UIBlox).Core.Layout.LayerCollector.LayerCollectorProvider
local LocalizationKeysProvider = require(GenericAbuseReporting.LocalizationKeys.LocalizationKeysProvider)
local FoundationProvider = require(GenericAbuseReportingParent.Foundation).FoundationProvider

local DualDropdownReport = require(script.Parent.DualDropdownReport)
local ReportCompleteDialog = require(GenericAbuseReporting.Dialogs.ReportCompleteDialog)
local ReportFailedDialog = require(GenericAbuseReporting.Dialogs.ReportFailedDialog)

local _submitAnalytics = require(GenericAbuseReporting.Analytics.submitAnalytics)
local useActiveDialog = require(script.Parent.useActiveDialog)

local function AREntrypoint(tbl1)
    local var1, var2 = useActiveDialog()

    local var3 = React.useCallback(function(str1: string, str2: string, str3: string)
        local var3 = if tbl1.onSubmitProps.hasNextSteps then tbl1.onSubmitProps.onProceedToNextStep(str1, str2, str3) else tbl1.onSubmitProps.onSubmit(str1, str2, str3)

        if var3 then
            var2("Complete")
        else
            var2("Error")
        end
        return var3
    end, { tbl1.onSubmitProps })

    local onDismiss = React.useCallback(function()
        var2("Form")
    end, {})

    local var4 = React.useCallback(function()
        if tbl1.onComplete then
            tbl1.onComplete()
        end
    end, { tbl1.onComplete })

    local createElement = React.createElement
    local var6 = LayerCollectorProvider
    local tbl2 = {}
    local tbl3 = { FoundationProvider = 0 }
    local createElement2 = React.createElement
    local var7 = FoundationProvider
    local tbl4 = { colorMode = "Dark" }

    local tbl5 = { analytics = 0 }
    local createElement3 = React.createElement
    local var8 = AnalyticsProvider
    local tbl6 = {
        onBeforeSubmitAnalytics = tbl1.onBeforeSubmitAnalytics,
        onSubmitAnalytics = tbl1.onSubmitAnalytics
    }
    local tbl7 = { localizationKeys = 0 }
    local createElement4 = React.createElement
    local var9 = LocalizationKeysProvider
    local tbl8 = {
        localizationKeys = tbl1.localizationKeys
    }
    local tbl9 = { submitDialog = 0, completeDialog = 0, errorDialog = 0 }
    local element

    if var1 == "Form" then
        element = React.createElement(DualDropdownReport, {
            analyticsContext = tbl1.analyticsContext,
            reportProblems = tbl1.reportProblems,
            reportSurfaces = tbl1.reportSurfaces,
            onSubmitProps = tbl1.onSubmitProps.hasNextSteps and {
                hasNextSteps = tbl1.onSubmitProps.hasNextSteps,
                onProceedToNextStep = var3
            }
                or {
                    hasNextSteps = tbl1.onSubmitProps.hasNextSteps,
                    onSubmit = var3
                },
            onCloseProps = tbl1.onCloseProps
        })
    else
        element = false
    end

    tbl9.submitDialog = element

    tbl9.completeDialog = var1 == "Complete" and React.createElement(ReportCompleteDialog, { onDismiss = var4 })

    tbl9.errorDialog = var1 == "Error" and React.createElement(ReportFailedDialog, { onDismiss = onDismiss })
    tbl7.localizationKeys = createElement4(var9, tbl8, tbl9)
    tbl5.analytics = createElement3(var8, tbl6, tbl7)
    tbl3.FoundationProvider = createElement2(var7, tbl4, tbl5)
    return createElement(var6, tbl2, tbl3)
end

return AREntrypoint
