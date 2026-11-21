-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T17:10:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local llama = require(scriptParentParentParent.llama)
local _roduxFriendsTypes = require(scriptParentParent.roduxFriendsTypes)
local getDeepValue = require(scriptParentParent.getDeepValue)

local function func1(arg1, arg2): boolean
    return arg1.rank < arg2.rank
end

return function(arg1)
    local keyPath = arg1.keyPath
    return function(arg2, arg3)
        local deepValue = getDeepValue(arg2, string.format("%s.recommendations.byUserId.%s", keyPath, arg3)) or {}

        return llama.List.sort(llama.Dictionary.values(deepValue), func1)
    end
end
