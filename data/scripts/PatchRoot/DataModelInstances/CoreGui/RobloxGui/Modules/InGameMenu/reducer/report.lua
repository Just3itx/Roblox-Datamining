-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:50:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)
local Rodux = InGameMenuDependencies.Rodux
local Cryo = InGameMenuDependencies.Cryo

local scriptParentParent = script.Parent.Parent

local OpenReportDialog = require(scriptParentParent.Actions.OpenReportDialog)
local CloseReportDialog = require(scriptParentParent.Actions.CloseReportDialog)
local OpenReportSentDialog = require(scriptParentParent.Actions.OpenReportSentDialog)
local CloseReportSentDialog = require(scriptParentParent.Actions.CloseReportSentDialog)
local SetCurrentPage = require(scriptParentParent.Actions.SetCurrentPage)

local createReducer = Rodux.createReducer

local tbl1 = {}
tbl1[OpenReportDialog.name] = function(arg1, arg2)
    return {
        dialogOpen = true,
        reportSentOpen = arg1.reportSentOpen,
        userId = arg2.userId,
        userName = arg2.userName
    }
end

tbl1[SetCurrentPage.name] = function(arg1, _)
    return Cryo.Dictionary.join(arg1, { dialogOpen = false })
end

tbl1[CloseReportDialog.name] = function(arg1, _)
    return Cryo.Dictionary.join(arg1, { dialogOpen = false })
end

tbl1[OpenReportSentDialog.name] = function(arg1, _)
    return Cryo.Dictionary.join(arg1, { reportSentOpen = true })
end

tbl1[CloseReportSentDialog.name] = function(arg1, _)
    return Cryo.Dictionary.join(arg1, { reportSentOpen = false })
end

return createReducer({ dialogOpen = false, reportSentOpen = false, userId = nil, userName = nil }, tbl1)
