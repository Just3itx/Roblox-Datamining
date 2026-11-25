-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T16:10:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _AnalyticsTypes = require(script.Parent.AnalyticsTypes)
local getSessionIdByKey = require(script.getSessionIdByKey)

return function(arg1)
    return {
        getSessionIdByKey = getSessionIdByKey(arg1)
    }
end
