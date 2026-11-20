-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:20:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SessionService = game:GetService("SessionService")

local scriptParentParent = script.Parent.Parent

local Constants = require(scriptParentParent.Resources.Constants)
local GetFFlagEnableARFlowSession = require(scriptParentParent.Flags.GetFFlagEnableARFlowSession)
local SendAnalytics = require(scriptParentParent.Utility.SendAnalytics)

local module = {}

function module.startAbuseReportSession(source)
    if not GetFFlagEnableARFlowSession() then
        return
    end

    if not SessionService:SessionExists(Constants.Session.StructuralIdentifier.AbuseReport) then
        SessionService:SetSession(
            Constants.Session.StructuralIdentifier.Level1,
            Constants.Session.StructuralIdentifier.AbuseReport,
            Constants.Session.StructuralIdentifier.AbuseReport
        )
    end
    SessionService:SetMetadata(
        Constants.Session.StructuralIdentifier.AbuseReport,
        Constants.Session.Metadata.EntryPoint,
        source
    )

    SessionService:SetMetadata(
        Constants.Session.StructuralIdentifier.AbuseReport,
        Constants.Session.Metadata.DeleteOnGameLeave,
        "True"
    )
    SendAnalytics(Constants.Analytics.ReportFlowOpened, Constants.Analytics.ReportFlowOpened, { source = source })
end

function module.endAbuseReportSession()
    if GetFFlagEnableARFlowSession() and SessionService:SessionExists(Constants.Session.StructuralIdentifier.AbuseReport) then
        SessionService:RemoveSession(Constants.Session.StructuralIdentifier.AbuseReport)
    end
end

return module
