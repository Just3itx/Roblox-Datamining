-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:41:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SessionService = game:GetService("SessionService")

local CorePackages = game:GetService("CorePackages")

local Cryo = require(CorePackages.Packages.Cryo)

local module = {}
module.__index = module

module.MenuContexts = {
    LegacyMenu = game:DefineFastString("ReportAnalyticsLegacyMenuContext", "ReportAbuseLegacyMenu"),
    LegacySentPage = game:DefineFastString("ReportAnalyticsLegacySentPageContext", "ReportAbuseLegacySentPage"),
    NewMenu = game:DefineFastString("ReportAnalyticsNewMenuContext", "ReportAbuseNewMenu")
}

module.DiagCounters = {
    SuccessfulSubmissionTime = game:DefineFastString("ReportAnalyticsSuccessfulSubmissionTimeStat", "SuccessfulSubmissionTime"),
    AbandonedSubmissionTime = game:DefineFastString("ReportAnalyticsAbandonedSubmissionTimeStat", "AbandonedSubmissionTime"),
    SubmittedMethodOfAbuse = game:DefineFastString("ReportAnalyticsSubmittedMethodOfAbuseStat", "SubmittedMethodOfAbuse")
}

module.ActionNames = {
    FieldChanged = game:DefineFastString("ReportAnalyticsFieldChanged", "FieldChanged"),
    FormSubmitted = game:DefineFastString("ReportAnalyticsFormSubmitted", "FormSubmitted"),
    FormAbandoned = game:DefineFastString("ReportAnalyticsFormAbandoned", "FormAbandoned"),
    ButtonActivated = game:DefineFastString("ReportAnalyticsButtonActivated", "ButtonActivated"),
    InGameAbuseReport = game:DefineFastString("ReportAnalyticsInGameAbuseReport", "InGameAbuseReport")
}

module.SessionConstants = {
    StructuralIdentifier = { Level1 = "level1", AbuseReport = "AbuseReport" },
    Metadata = { EntryPoint = "entryPoint", DeleteOnGameLeave = "_deleteOnGameLeave" }
}

function module.new(_eventStreamImpl, _diagImpl, _context)
    assert(_context, "Base context needs to be provided to ReportAbuseAnalytics")

    local tbl1 = { _eventStreamImpl = _eventStreamImpl, _diagImpl = _diagImpl, _context = _context }

    setmetatable(tbl1, module)

    return tbl1
end

function module:reportFormSubmitted(timeToComplete, methodOfAbuse, arg1)
    local var1 = self._context .. "_" .. module.DiagCounters.SuccessfulSubmissionTime
    local var2 = self._context .. "_" .. module.DiagCounters.SubmittedMethodOfAbuse .. "_" .. methodOfAbuse

    arg1 = Cryo.Dictionary.join(arg1 or {}, { timeToComplete = timeToComplete, methodOfAbuse = methodOfAbuse })

    self._diagImpl:reportStats(var1, timeToComplete)
    self._diagImpl:reportCounter(var2, 1)

    self._eventStreamImpl:sendEventDeferred(self._context, module.ActionNames.FormSubmitted, arg1)
end

function module:reportFormAbandoned(timeToExit, arg1)
    local var1 = self._context .. "_" .. module.DiagCounters.AbandonedSubmissionTime

    arg1 = Cryo.Dictionary.join(arg1 or {}, { timeToExit = timeToExit })

    self._diagImpl:reportStats(var1, timeToExit)
    self._eventStreamImpl:sendEventDeferred(self._context, module.ActionNames.FormAbandoned, arg1)
end

function module:reportAnalyticsFieldChanged(arg1)
    self._eventStreamImpl:sendEventDeferred(self._context, module.ActionNames.FieldChanged, arg1 or {})
end

function module:reportButtonClick(arg1)
    self._eventStreamImpl:sendEventDeferred(self._context, module.ActionNames.ButtonActivated, arg1 or {})
end

function module:reportInGameAbuseReportInteraction(tbl1)
    local bool1 = tbl1.interactionType == 1
    local abandonedSubmissionTime = module.DiagCounters.AbandonedSubmissionTime
    if bool1 then
        abandonedSubmissionTime = module.DiagCounters.SuccessfulSubmissionTime

        local var1 = self._context .. "_" .. module.DiagCounters.SubmittedMethodOfAbuse .. "_" .. tbl1.inferredTypeofabuseSelection

        self._diagImpl:reportCounter(var1, 1)
    end

    local var1 = self._context .. "_" .. abandonedSubmissionTime
    self._diagImpl:reportStats(var1, tbl1.timeSpentMs)

    self._eventStreamImpl:sendEventDeferred(self._context, module.ActionNames.InGameAbuseReport, tbl1)
end

function module:reportEventAndIncrement(arg1, arg2)
    self._diagImpl:reportCounter(self._context .. "_" .. arg1, 1)
    self._eventStreamImpl:sendEventDeferred(self._context, arg1, arg2 or {})
end

function module.startAbuseReportSession(_, arg1)
    if not SessionService:SessionExists(module.SessionConstants.StructuralIdentifier.AbuseReport) then
        SessionService:SetSession(
            module.SessionConstants.StructuralIdentifier.Level1,
            module.SessionConstants.StructuralIdentifier.AbuseReport,
            module.SessionConstants.StructuralIdentifier.AbuseReport
        )
    end

    if not SessionService:GetMetadata(
        module.SessionConstants.StructuralIdentifier.AbuseReport,
        module.SessionConstants.Metadata.EntryPoint
    ) then
        SessionService:SetMetadata(
            module.SessionConstants.StructuralIdentifier.AbuseReport,
            module.SessionConstants.Metadata.EntryPoint,
            arg1
        )
    end

    SessionService:SetMetadata(
        module.SessionConstants.StructuralIdentifier.AbuseReport,
        module.SessionConstants.Metadata.DeleteOnGameLeave,
        "True"
    )
end

function module.getAbuseReportSessionEntryPoint(_)
    if SessionService:SessionExists(module.SessionConstants.StructuralIdentifier.AbuseReport) then
        return (SessionService:GetMetadata(
            module.SessionConstants.StructuralIdentifier.AbuseReport,
            module.SessionConstants.Metadata.EntryPoint
        ))
    end
    return ""
end

function module.endAbuseReportSession(_)
    if SessionService:SessionExists(module.SessionConstants.StructuralIdentifier.AbuseReport) then
        SessionService:RemoveSession(module.SessionConstants.StructuralIdentifier.AbuseReport)
    end
end

return module
