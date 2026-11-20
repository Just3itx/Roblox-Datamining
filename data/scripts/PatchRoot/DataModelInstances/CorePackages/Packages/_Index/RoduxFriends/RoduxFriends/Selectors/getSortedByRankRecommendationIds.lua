-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T14:01:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local _roduxFriendsTypes = require(scriptParentParent.roduxFriendsTypes)
local selectRecommendationsForUserId = require(script.Parent.selectRecommendationsForUserId)
local LuauPolyfill = require(scriptParentParentParent.LuauPolyfill)
local Object = LuauPolyfill.Object
local Array = LuauPolyfill.Array

local function func1(arg1, arg2)
    return (arg1.rank or 0) - (arg2.rank or 0)
end

return function(arg1)
    return function(arg2)
        return function(str1: string, tbl1)
            local var1 = selectRecommendationsForUserId(arg1)(arg2)(str1, tbl1)

            return Array.map(Array.sort(Object.values(var1), func1), function(arg3)
                return arg3.id
            end)
        end
    end
end
