-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T16:10:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent
local scriptParentParent = script.Parent.Parent

local _AnalyticsTypes = require(scriptParentParent.AnalyticsTypes)
local getDeepValue = require(scriptParentParentParentParent.Utils.getDeepValue)

return function(arg1)
    local keyPath = arg1.keyPath
    return function(arg2)
        return function(arg3)
            return getDeepValue(arg2, string.format("%s.bySessionKey.%s", keyPath, arg3))
        end
    end
end
