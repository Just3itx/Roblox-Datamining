-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T17:10:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local getDeepValue = require(scriptParentParent.getDeepValue)
local _roduxFriendsTypes = require(scriptParentParent.roduxFriendsTypes)
local Object = require(scriptParentParentParent.LuauPolyfill).Object

return function(arg1)
    local keyPath = arg1.keyPath
    return function(arg2)
        return function(str1: string)
            local deepValue = getDeepValue(arg2, string.format("%s.recommendations.bySource.%s", keyPath, str1 or "")) or {}

            return Object.keys(deepValue)
        end
    end
end
