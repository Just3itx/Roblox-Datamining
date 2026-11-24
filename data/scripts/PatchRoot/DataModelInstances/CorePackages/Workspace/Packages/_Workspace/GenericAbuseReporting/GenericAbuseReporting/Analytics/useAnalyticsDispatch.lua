-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:30:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReportingParent = script:FindFirstAncestor("GenericAbuseReporting").Parent
local React = require(GenericAbuseReportingParent.React)
local AnalyticsDispatchContext = require(script.Parent.AnalyticsDispatchContext)

local function useAnalyticsDispatch()
    return (React.useContext(AnalyticsDispatchContext))
end

return useAnalyticsDispatch
