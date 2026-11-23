-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T03:01:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserSearch = script:FindFirstAncestor("UserSearch")
local UserSearchParent = UserSearch.Parent

local _React = require(UserSearchParent.React)
local usePaginatedProfileInsightsFetch = require(script.Parent.usePaginatedProfileInsightsFetch)
local _LocalTypes = require(UserSearch.Common.LocalTypes)

return function(tbl1)
    local var1 = usePaginatedProfileInsightsFetch({ users = tbl1.users or {}, searchKeyword = tbl1.searchParameters.searchKeyword })
        or {}

    return tbl1.renderComponent(var1)
end
