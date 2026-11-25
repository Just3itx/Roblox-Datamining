-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T16:10:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local Rodux = require(scriptParentParentParent.dependencies).Rodux
local _AnalyticsTypes = require(script.Parent.AnalyticsTypes)

local bySessionKey = require(script.bySessionKey)

return function(arg1)
    return Rodux.combineReducers({ bySessionKey = bySessionKey(arg1) })
end
