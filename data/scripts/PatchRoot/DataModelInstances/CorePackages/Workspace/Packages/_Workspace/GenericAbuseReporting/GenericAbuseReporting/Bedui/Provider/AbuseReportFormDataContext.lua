-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:31:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReporting = script:FindFirstAncestor("GenericAbuseReporting")
local GenericAbuseReportingParent = GenericAbuseReporting.Parent

local React = require(GenericAbuseReportingParent.React)

local _AbuseReportBeduiTypes = require(GenericAbuseReporting.Bedui.Provider.AbuseReportBeduiTypes)

local FFlagAddThumbnailSelectorReport = require(GenericAbuseReportingParent.SharedFlags).FFlagAddThumbnailSelectorReport

return React.createContext({
    custom = FFlagAddThumbnailSelectorReport and {} or nil,
    formData = {},
    updateForm = function(_: string, _: string) end,
    additionalReportTags = FFlagAddThumbnailSelectorReport and {} or nil,
    updateAdditionalReportTags = FFlagAddThumbnailSelectorReport and function(_: string, _) end or nil
})
