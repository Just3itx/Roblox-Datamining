-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T17:10:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local getDeepValue = require(scriptParentParent.getDeepValue)
local _roduxFriendsTypes = require(scriptParentParent.roduxFriendsTypes)
local filterByKeys = require(script.Parent.filterByKeys)

return function(arg1)
    local keyPath = arg1.keyPath
    return function(arg2)
        return function(tbl1)
            local deepValue = getDeepValue(arg2, string.format("%s.friendshipStatus", keyPath)) or {}

            if not tbl1 then
                return deepValue
            end

            return filterByKeys(tbl1, deepValue)
        end
    end
end
