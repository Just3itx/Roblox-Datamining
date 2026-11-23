-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T02:20:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserList = script:FindFirstAncestor("UserList")
local UserListParent = UserList.Parent

local React = require(UserListParent.React)
local _Enums = require(UserList.Common.Enums)
local _Types = require(UserList.Common.Types)

local function useEntities(tbl1)
    return (React.useMemo(function()
        local entitiesMap = {}

        for _, value in tbl1 do
            entitiesMap[value.id] = value
        end

        return { entitiesMap = entitiesMap }
    end, { tbl1 }))
end

return useEntities
