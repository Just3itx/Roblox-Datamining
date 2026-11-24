-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:31:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReporting = script:FindFirstAncestor("GenericAbuseReporting")
local GenericAbuseReportingParent = GenericAbuseReporting.Parent

local React = require(GenericAbuseReportingParent.React)

local AbuseVector = require(GenericAbuseReporting.Enums.AbuseVector)

return React.createContext({
    abuseVector = AbuseVector.Invalid,
    isReportSubmitted = false,
    setIsReportSubmitted = function(_: boolean) end
})
