-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T16:01:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReporting = script:FindFirstAncestor("GenericAbuseReporting")
local GenericAbuseReportingParent = GenericAbuseReporting.Parent

local React = require(GenericAbuseReportingParent.React)

local LocalizationKeysContext = require(GenericAbuseReporting.LocalizationKeys.LocalizationKeysContext)
local DefaultLocalizationKeys = require(GenericAbuseReporting.LocalizationKeys.DefaultLocalizationKeys)

local function LocalizationKeysProvider(tbl1)
    local value = React.useMemo(function()
        local localizationKeys = tbl1.localizationKeys
        return {
            formTitle = localizationKeys and localizationKeys.formTitle or DefaultLocalizationKeys.formTitle,
            formSubmit = localizationKeys and localizationKeys.formSubmit or DefaultLocalizationKeys.formSubmit,
            completeTitle = localizationKeys and localizationKeys.completeTitle or DefaultLocalizationKeys.completeTitle,
            completeDescription = localizationKeys and localizationKeys.completeDescription or DefaultLocalizationKeys.completeDescription,
            completeClose = localizationKeys and localizationKeys.completeClose or DefaultLocalizationKeys.completeClose,
            failedTitle = localizationKeys and localizationKeys.failedTitle or DefaultLocalizationKeys.failedTitle,
            failedDescription = localizationKeys and localizationKeys.failedDescription or DefaultLocalizationKeys.failedDescription,
            failedClose = localizationKeys and localizationKeys.failedClose or DefaultLocalizationKeys.failedClose
        }
    end, { tbl1.localizationKeys })

    return React.createElement(LocalizationKeysContext.Provider, { value = value }, tbl1.children)
end

return LocalizationKeysProvider
