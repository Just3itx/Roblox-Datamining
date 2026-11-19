-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:51:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Immutable = require(script.Parent.Parent.Immutable)

local DataStoresUpdateSearchFilter = require(script.Parent.Parent.Actions.DataStoresUpdateSearchFilter)

return function(tbl1, tbl2)
    local var1 = tbl1 or { storesSearchTerm = "" }

    if tbl2.type == DataStoresUpdateSearchFilter.name then
        return (Immutable.Set(var1, "storesSearchTerm", tbl2.searchTerm))
    end

    return var1
end
