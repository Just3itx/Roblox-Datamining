-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T16:11:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialLuaAnalyticsParent = script:FindFirstAncestor("SocialLuaAnalytics").Parent

local React = require(SocialLuaAnalyticsParent.React)

local Timers = require(script.Parent.Timers)
local _SimpleTimer = require(script.Parent.SimpleTimer)

local function useLoadingTimers(arg1)
    return React.useRef(Timers(arg1)).current
end

return useLoadingTimers
