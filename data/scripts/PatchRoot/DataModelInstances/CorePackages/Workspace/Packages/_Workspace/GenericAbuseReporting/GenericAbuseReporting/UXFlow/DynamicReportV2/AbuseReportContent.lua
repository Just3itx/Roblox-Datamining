-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T16:01:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReporting = script:FindFirstAncestor("GenericAbuseReporting")
local GenericAbuseReportingParent = GenericAbuseReporting.Parent

local React = require(GenericAbuseReportingParent.React)

local FFlagEnableInlineSurveyOnUserReport = require(GenericAbuseReportingParent.SharedFlags).FFlagEnableInlineSurveyOnUserReport

local AbuseReportAnalyticsProvider = require(GenericAbuseReporting.BeduiV2.Analytics.AbuseReportAnalyticsContext).AbuseReportAnalyticsProvider
local AbuseReportDialog = require(GenericAbuseReporting.BeduiV2.Components.AbuseReportDialog)
local _AbuseSheetFlowTypes = require(GenericAbuseReporting.BeduiV2.Hooks.AbuseSheetFlow.AbuseSheetFlowTypes)
local _AbuseVector = require(GenericAbuseReporting.Enums.AbuseVector)
local ArTranslationProvider = require(GenericAbuseReporting.BeduiV2.Utils.Translate.arTranslation).ArTranslationProvider
local LayoutSlots = require(GenericAbuseReporting.BeduiV2.Components.LayoutSlots)
local LoaderContext = require(GenericAbuseReporting.BeduiV2.Loaders.LoaderContext)
local useAbuseSheetFlow = require(GenericAbuseReporting.BeduiV2.Hooks.AbuseSheetFlow.useAbuseSheetFlow)

local LayoutSlotsProvider = LayoutSlots.LayoutSlotsProvider
local LoaderProvider = LoaderContext.LoaderProvider
local sheetSlots = LayoutSlots.sheetSlots

return (React.forwardRef(function(tbl1, arg1)
    local abuseReportFlow = useAbuseSheetFlow(tbl1.rawConfig, {
        abuseVector = tbl1.abuseVector,
        analyticsTargetId = tbl1.analyticsTargetId,
        onClose = tbl1.onClose,
        open = tbl1.open,
        onCustomSubmit = tbl1.onCustomSubmit,
        clientActionHandlers = tbl1.clientActionHandlers,
        onFinish = if FFlagEnableInlineSurveyOnUserReport then tbl1.onFinish else nil
    })

    React.useImperativeHandle(arg1, function()
        return {
            requestClose = function()
                if abuseReportFlow then
                    abuseReportFlow.onClose()
                end
            end
        }
    end, { abuseReportFlow })

    React.useEffect(function()
        if not abuseReportFlow then
            tbl1.onResolveError()
        end
    end, { abuseReportFlow, tbl1.onResolveError })

    if not abuseReportFlow then
        return nil
    end

    local element = React.createElement(AbuseReportDialog, {
        abuseVector = tbl1.abuseVector,
        onClose = tbl1.onClose,
        abuseReportFlow = abuseReportFlow,
        takeoverFocus = tbl1.takeoverFocus
    })

    return React.createElement(
        ArTranslationProvider,
        {
            translations = abuseReportFlow.config.translations
        },
        React.createElement(
            AbuseReportAnalyticsProvider,
            {
                analytics = abuseReportFlow.analytics
            },
            React.createElement(
                LoaderProvider,
                {
                    loaders = {},
                    open = tbl1.open
                },
                React.createElement(LayoutSlotsProvider, { slots = sheetSlots }, element)
            )
        )
    )
end))
