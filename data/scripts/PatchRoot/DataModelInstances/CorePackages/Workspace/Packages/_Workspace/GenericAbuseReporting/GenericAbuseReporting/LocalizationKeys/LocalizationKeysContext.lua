-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T16:01:14Z
-- Luau bytecode version: 14 | Luau type version: 3
local GenericAbuseReporting = script:FindFirstAncestor("GenericAbuseReporting")
local GenericAbuseReportingParent = GenericAbuseReporting.Parent

local React = require(GenericAbuseReportingParent.React)
local DefaultLocalizationKeys = require(GenericAbuseReporting.LocalizationKeys.DefaultLocalizationKeys)

return React.createContext(DefaultLocalizationKeys)
