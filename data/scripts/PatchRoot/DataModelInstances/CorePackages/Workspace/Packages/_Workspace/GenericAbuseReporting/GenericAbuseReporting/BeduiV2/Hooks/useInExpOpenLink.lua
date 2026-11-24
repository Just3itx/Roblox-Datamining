-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:50:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReportingParent = script:FindFirstAncestor("GenericAbuseReporting").Parent

local default = require(GenericAbuseReportingParent.LinkingProtocol).LinkingProtocol.default
local React = require(GenericAbuseReportingParent.React)

local function useInExpOpenLink()
    return React.useCallback(function(str1: string)
        if str1 ~= nil and str1 ~= "" then
            default:openURL(str1)
        end
    end, {})
end

return useInExpOpenLink
