-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T20:01:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Immutable = require(script.Parent.Parent.Immutable)

local ServerStatsUpdateSearchFilter = require(script.Parent.Parent.Actions.ServerStatsUpdateSearchFilter)

return function(tbl1, tbl2)
    local var1 = tbl1 or { statsSearchTerm = "" }

    if tbl2.type == ServerStatsUpdateSearchFilter.name then
        return (Immutable.Set(var1, "statsSearchTerm", tbl2.searchTerm))
    end

    return var1
end
