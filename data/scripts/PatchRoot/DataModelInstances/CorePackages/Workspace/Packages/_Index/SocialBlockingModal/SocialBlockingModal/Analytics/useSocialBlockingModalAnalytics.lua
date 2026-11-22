-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T16:41:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialBlockingModalParent = script:FindFirstAncestor("SocialBlockingModal").Parent

local React = require(SocialBlockingModalParent.React)

local AnalyticsSetup = require(script.Parent.AnalyticsSetup)

local function useSocialBlockingModalAnalytics(infoForAllEvents)
    return (React.useMemo(function()
        return AnalyticsSetup({ infoForAllEvents = infoForAllEvents })
    end, { infoForAllEvents }))
end

return useSocialBlockingModalAnalytics
