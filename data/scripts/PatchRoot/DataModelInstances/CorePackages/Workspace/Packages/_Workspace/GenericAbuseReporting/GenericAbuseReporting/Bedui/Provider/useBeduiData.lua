-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:31:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReporting = script:FindFirstAncestor("GenericAbuseReporting")
local GenericAbuseReportingParent = GenericAbuseReporting.Parent
local React = require(GenericAbuseReportingParent.React)

local AbuseReportBeduiContext = require(GenericAbuseReporting.Bedui.Provider.AbuseReportBeduiContext)

local function useBeduiData()
    return React.useContext(AbuseReportBeduiContext)
end

return useBeduiData
