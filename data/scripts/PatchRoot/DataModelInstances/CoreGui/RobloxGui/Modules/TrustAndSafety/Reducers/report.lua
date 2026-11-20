-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:20:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local Cryo = require(CorePackages.Packages.Cryo)
local Rodux = require(CorePackages.Packages.Rodux)

local scriptParentParent = script.Parent.Parent

local OpenReportMenu = require(scriptParentParent.Actions.OpenReportMenu)
local CloseReportMenu = require(scriptParentParent.Actions.CloseReportMenu)
local _OpenReportDialog = require(scriptParentParent.Actions.OpenReportDialog)
local _OpenCategoryMenu = require(scriptParentParent.Actions.OpenCategoryMenu)
local SelectReportCategory = require(scriptParentParent.Actions.SelectReportCategory)
local OpenReportSentDialog = require(scriptParentParent.Actions.OpenReportSentDialog)
local _CloseReportSentDialog = require(scriptParentParent.Actions.CloseReportSentDialog)
local SelectReportListing = require(scriptParentParent.Actions.SelectReportListing)
local SetVoiceReportingFlow = require(scriptParentParent.Actions.SetVoiceReportingFlow)
local BeginReportFlow = require(scriptParentParent.Actions.BeginReportFlow)
local EndReportFlow = require(scriptParentParent.Actions.EndReportFlow)
local NavigateBack = require(scriptParentParent.Actions.NavigateBack)
local Constants = require(scriptParentParent.Resources.Constants)

local createReducer = Rodux.createReducer
local tbl1 = {
    currentPage = Constants.Page.None,
    history = {},
    voiceReportingFlowEnabled = true,
    reportType = Constants.ReportType.Any,
    beginningReportType = Constants.ReportType.Any,
    reportCategory = Constants.Category.None,
    targetPlayer = nil,
    beginningTimestamp = 0,
    sortedUserIds = {}
}
local tbl2 = {}
tbl2[EndReportFlow.name] = function(arg1, _)
    return Cryo.Dictionary.join(
        arg1,
        {
            history = {},
            currentPage = Constants.Page.None,
            targetPlayer = Cryo.None,
            reportType = Constants.ReportType.Any
        }
    )
end

tbl2[BeginReportFlow.name] = function(arg1, arg2)
    local tbl3 = {
        reportCategory = Constants.Category.None,
        beginningTimestamp = workspace:GetServerTimeNow(),
        sortedUserIds = {},
        history = { Constants.Page.None }
    }
    if arg2.reportType == Constants.ReportType.Place then
        return Cryo.Dictionary.join(arg1, tbl3, {
            reportType = arg2.reportType,
            beginningReportType = arg2.reportType,
            currentPage = Constants.Page.ReportForm,
            targetPlayer = Cryo.None
        })
    elseif arg2.reportType == Constants.ReportType.Player then
        return Cryo.Dictionary.join(arg1, tbl3, {
            reportType = arg2.reportType,
            beginningReportType = arg2.reportType,
            targetPlayer = arg2.targetPlayer,
            currentPage = if arg1.voiceReportingFlowEnabled then Constants.Page.Category else Constants.Page.ReportForm
        })
    end

    return Cryo.Dictionary.join(arg1, tbl3, {
        reportType = Constants.ReportType.Any,
        beginningReportType = Constants.ReportType.Any,
        targetPlayer = Cryo.None,
        currentPage = if arg1.voiceReportingFlowEnabled then Constants.Page.Category else Constants.Page.Listing
    })
end

tbl2[NavigateBack.name] = function(arg1, _)
    local currentPage = arg1.history[#arg1.history] or arg1.currentPage
    local history = Cryo.List.removeIndex(arg1.history, #arg1.history)

    return Cryo.Dictionary.join(arg1, { history = history, currentPage = currentPage })
end

tbl2[SelectReportCategory.name] = function(arg1, arg2)
    local bool1 = arg2.reportCategory == Constants.Category.Experience
    local bool2 = arg1.beginningReportType == Constants.ReportType.Player

    local listing = Constants.Page.Listing
    local reportType = arg1.reportType
    if bool1 or bool2 then
        listing = Constants.Page.ReportForm
        if bool1 then
            reportType = Constants.ReportType.Place
        end
    end

    local history = Cryo.List.join(arg1.history, { arg1.currentPage })

    return Cryo.Dictionary.join(
        arg1,
        {
            history = history,
            currentPage = listing,
            reportType = reportType,
            reportCategory = arg2.reportCategory
        }
    )
end

tbl2[SelectReportListing.name] = function(arg1, arg2)
    local history = Cryo.List.join(arg1.history, { arg1.currentPage })

    return Cryo.Dictionary.join(arg1, {
        sortedUserIds = Cryo.List.join(arg2.sortedUserIds or {}, {}),
        history = history,
        currentPage = Constants.Page.ReportForm,
        reportType = arg2.reportType,
        targetPlayer = arg2.targetPlayer or Cryo.None
    })
end

tbl2[OpenReportMenu.name] = function(arg1, _)
    return Cryo.Dictionary.join(arg1, { isReportMenuOpen = true })
end

tbl2[CloseReportMenu.name] = function(arg1, _)
    return Cryo.Dictionary.join(arg1, { isReportMenuOpen = false })
end

tbl2[OpenReportSentDialog.name] = function(arg1, arg2)
    return Cryo.Dictionary.join(
        arg1,
        {
            currentPage = Constants.Page.ReportSent,
            reportType = arg2.reportType,
            targetPlayer = arg2.targetPlayer or Cryo.None
        }
    )
end

tbl2[SetVoiceReportingFlow.name] = function(arg1, arg2)
    return Cryo.Dictionary.join(arg1, { voiceReportingFlowEnabled = arg2.enable })
end

return createReducer(tbl1, tbl2)
