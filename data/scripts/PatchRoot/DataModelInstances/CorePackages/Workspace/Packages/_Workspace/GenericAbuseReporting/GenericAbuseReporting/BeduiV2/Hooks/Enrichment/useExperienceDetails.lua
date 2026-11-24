-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:41:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReportingParent = script:FindFirstAncestor("GenericAbuseReporting").Parent

local DataHydration = require(GenericAbuseReportingParent.DataHydration)
local SignalsReact = require(GenericAbuseReportingParent.SignalsReact)

local function useExperienceDetails(str1: string)
    return (SignalsReact.useSignalState(DataHydration.Game.getGameInfoStore(false).getAndFetchGameInfo(str1).data))
end

return useExperienceDetails
