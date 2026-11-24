-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T16:01:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReporting = script:FindFirstAncestor("GenericAbuseReporting")
local GenericAbuseReportingParent = GenericAbuseReporting.Parent

local React = require(GenericAbuseReportingParent.React)
local SharedFlags = require(GenericAbuseReportingParent.SharedFlags)

local AbuseReportAnalyticsProvider = require(GenericAbuseReporting.BeduiV2.Analytics.AbuseReportAnalyticsContext).AbuseReportAnalyticsProvider
local AbuseReportInline = require(GenericAbuseReporting.BeduiV2.Components.AbuseReportInline)
local _AbuseSheetFlowTypes = require(GenericAbuseReporting.BeduiV2.Hooks.AbuseSheetFlow.AbuseSheetFlowTypes)
local _AbuseVector = require(GenericAbuseReporting.Enums.AbuseVector)
local ArTranslationProvider = require(GenericAbuseReporting.BeduiV2.Utils.Translate.arTranslation).ArTranslationProvider
local LayoutSlots = require(GenericAbuseReporting.BeduiV2.Components.LayoutSlots)
local LoaderContext = require(GenericAbuseReporting.BeduiV2.Loaders.LoaderContext)
local useAbuseSheetFlow = require(GenericAbuseReporting.BeduiV2.Hooks.AbuseSheetFlow.useAbuseSheetFlow)
local voiceSpeakingSignals = require(GenericAbuseReporting.BeduiV2.Utils.Signals.voiceSpeakingSignals)

local inlineSlots = LayoutSlots.inlineSlots
local LayoutSlotsProvider = LayoutSlots.LayoutSlotsProvider
local OverlaidControlsProvider = LayoutSlots.OverlaidControlsProvider
local LoaderProvider = LoaderContext.LoaderProvider

local FFlagAbuseReportInExpPlayerListV3 = SharedFlags.FFlagAbuseReportInExpPlayerListV3
local FFlagAbuseReportVoiceMute = SharedFlags.FFlagAbuseReportVoiceMute

local function AbuseReportContentInExp(tbl1)
    local abuseReportFlow = useAbuseSheetFlow(tbl1.rawConfig, {
        abuseVector = tbl1.abuseVector,
        analyticsTargetId = tbl1.targetId,
        onClose = tbl1.onClose,
        open = true,
        onCustomSubmit = tbl1.onCustomSubmit,
        clientActionHandlers = tbl1.clientActionHandlers,
        onFinish = tbl1.onFinish,
        attemptTrigger = tbl1.attemptTrigger,
        inlineAlertController = tbl1.inlineAlertController
    })

    React.useEffect(function()
        if not abuseReportFlow then
            tbl1.onResolveError()
        end
    end, { abuseReportFlow, tbl1.onResolveError })

    if not abuseReportFlow then
        return nil
    end

    local element = React.createElement(
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
                LayoutSlotsProvider,
                { slots = inlineSlots },
                React.createElement(
                    OverlaidControlsProvider,
                    {
                        value = tbl1.shouldUseOverlaidControls
                    },
                    React.createElement(
                        LoaderProvider,
                        {
                            loaders = tbl1.loaders,
                            open = true
                        },
                        React.createElement(
                            AbuseReportInline,
                            {
                                abuseReportFlow = abuseReportFlow,
                                shouldUseOverlaidControls = tbl1.shouldUseOverlaidControls
                            }
                        )
                    )
                )
            )
        )
    )
    if FFlagAbuseReportInExpPlayerListV3 or FFlagAbuseReportVoiceMute then
        return React.createElement(
            voiceSpeakingSignals.VoiceChatServiceManagerContext.Provider,
            {
                value = tbl1.voiceChatServiceManager
            },
            element
        )
    end

    return element
end

return AbuseReportContentInExp
