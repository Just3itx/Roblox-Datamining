-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T16:01:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReportingParent = script:FindFirstAncestor("GenericAbuseReporting").Parent
local React = require(GenericAbuseReportingParent.React)

local LocalizationKeysContext = require(script.Parent.LocalizationKeysContext)
local useLocalization = require(GenericAbuseReportingParent.Localization).Hooks.useLocalization

local function useLocalizedStrings()
    local var1 = React.useContext(LocalizationKeysContext)
    return (useLocalization(var1))
end

return useLocalizedStrings
