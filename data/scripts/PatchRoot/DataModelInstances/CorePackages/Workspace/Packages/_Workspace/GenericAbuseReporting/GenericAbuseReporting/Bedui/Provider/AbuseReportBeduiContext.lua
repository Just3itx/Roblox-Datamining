-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:31:06Z
-- Luau bytecode version: 14 | Luau type version: 3
local GenericAbuseReporting = script:FindFirstAncestor("GenericAbuseReporting")
local GenericAbuseReportingParent = GenericAbuseReporting.Parent

local React = require(GenericAbuseReportingParent.React)

local AbuseReportBeduiContextStatus = require(GenericAbuseReporting.Bedui.Provider.AbuseReportBeduiTypes).AbuseReportBeduiContextStatus

return React.createContext({ status = AbuseReportBeduiContextStatus.Loading, beduiData = nil, error = nil })
