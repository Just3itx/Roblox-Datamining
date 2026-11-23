-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T00:51:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TrustedContactsParent = script:FindFirstAncestor("TrustedContacts").Parent

local React = require(TrustedContactsParent.React)

local AnalyticsSetup = require(script.Parent.AnalyticsSetup)

local function useTCAnalytics(infoForAllEvents)
    return (React.useMemo(function()
        return AnalyticsSetup({ infoForAllEvents = infoForAllEvents })
    end, { infoForAllEvents }))
end

return useTCAnalytics
