-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T16:01:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReporting = script:FindFirstAncestor("GenericAbuseReporting")
local GenericAbuseReportingParent = GenericAbuseReporting.Parent
local React = require(GenericAbuseReportingParent.React)
local Frame = require(GenericAbuseReporting.Common.Frame)
local DualDropdownSubmitDialog = require(GenericAbuseReporting.Dialogs.DualDropdownSubmitDialog)
local DefaultLocalizationKeys = require(GenericAbuseReporting.LocalizationKeys.DefaultLocalizationKeys)

local OnFormLoaded = require(GenericAbuseReporting.Analytics.Actions.OnFormLoaded)
local useAnalyticsSubmitDispatch = require(GenericAbuseReporting.Analytics.useAnalyticsSubmitDispatch)
local useAnalyticsDispatch = require(GenericAbuseReporting.Analytics.useAnalyticsDispatch)

local function DualDropdownReport(tbl1)
    local var1 = useAnalyticsSubmitDispatch()
    local var2 = useAnalyticsDispatch()

    if tbl1.localizationKeys then
        tbl1.localizationKeys.formTitle = tbl1.localizationKeys.formTitle or DefaultLocalizationKeys.formTitle
        tbl1.localizationKeys.formSubmit = tbl1.localizationKeys.formSubmit or DefaultLocalizationKeys.formSubmit
    end

    React.useEffect(function()
        var2(
            OnFormLoaded(
                {
                    context = tbl1.analyticsContext,
                    place_id = game.PlaceId,
                    accumulated_time_ms = workspace:GetServerTimeNow() * 1000
                }
            )
        )
    end, { var2, tbl1.analyticsContext })

    local onSubmit = React.useCallback(function(str1: string, str2: string, str3: string)
        local var3 = if tbl1.onSubmitProps.hasNextSteps then tbl1.onSubmitProps.onProceedToNextStep(str1, str2, str3) else tbl1.onSubmitProps.onSubmit(str1, str2, str3)

        if var3 and not tbl1.onSubmitProps.hasNextSteps then
            var1("Submit")
        end
    end, { var1, tbl1.onSubmitProps })

    local onAbandon = React.useCallback(function()
        if not tbl1.onCloseProps then
            var1("Abandon")

            return
        end

        if tbl1.onCloseProps.hasPreviousSteps then
            tbl1.onCloseProps.onBackToPreviousStep()
            return
        end
        tbl1.onCloseProps.onAbandon()
        var1("Abandon")
    end, { var1, tbl1.onCloseProps })

    return React.createElement(Frame, {
        Size = UDim2.new(1, 0, 1, 0)
    }, {
        DualDropdownReport = React.createElement(DualDropdownSubmitDialog, {
            localizationKeys = tbl1.localizationKeys,
            reportProblems = tbl1.reportProblems,
            reportSurfaces = tbl1.reportSurfaces,
            onSubmit = onSubmit,
            onAbandon = onAbandon,
            footerContent = tbl1.footerContent
        })
    })
end

return DualDropdownReport
