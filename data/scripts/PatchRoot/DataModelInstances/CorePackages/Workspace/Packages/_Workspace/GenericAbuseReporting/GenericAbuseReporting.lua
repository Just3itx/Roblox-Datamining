-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:21:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local AbuseEntrypoint = require(script.Enums.AbuseEntrypoint)
local _AbuseSheetFlowTypes = require(script.BeduiV2.Hooks.AbuseSheetFlow.AbuseSheetFlowTypes)
local AbuseVector = require(script.Enums.AbuseVector)
local OpenDynamicAbuseReport = require(script.Thunks.OpenDynamicAbuseReport)

return {
    Components = {
        ReportCompleteDialog = require(script.Dialogs.ReportCompleteDialog),
        ReportFailedDialog = require(script.Dialogs.ReportFailedDialog)
    },
    Enums = {
        AbuseCategory = require(script.Enums.AbuseCategory),
        AbuseEntrypoint = AbuseEntrypoint,
        AbuseVector = AbuseVector
    },
    Thunks = { OpenDynamicAbuseReport = OpenDynamicAbuseReport },
    UXFlows = {
        DefaultTwoStepReportFlow = require(script.UXFlow.ReportWithReasonAndComment.AREntrypoint),
        DefaultReportDialog = require(script.UXFlow.ReportWithReasonAndComment.ReportWithReasonAndComment),
        DefaultDualDropdownDialog = require(script.UXFlow.DualDropdownReport.DualDropdownReport),
        DefaultDualDropdownDialogV2 = require(script.UXFlow.DualDropdownReport.DualDropdownReportV2),
        DynamicReportContainer = require(script.UXFlow.DynamicReport.DynamicReportContainer),
        DynamicReportInExpContainer = require(script.UXFlow.DynamicReportV2InExp.DynamicReportV2InExpContainer)
    },
    ["jest.config"] = script["jest.config"]
}
