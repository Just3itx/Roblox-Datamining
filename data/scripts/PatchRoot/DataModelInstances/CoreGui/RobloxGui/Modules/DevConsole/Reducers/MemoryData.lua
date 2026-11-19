-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T20:00:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Immutable = require(script.Parent.Parent.Immutable)

local ClientMemoryUpdateSearchFilter = require(script.Parent.Parent.Actions.ClientMemoryUpdateSearchFilter)
local ServerMemoryUpdateSearchFilter = require(script.Parent.Parent.Actions.ServerMemoryUpdateSearchFilter)

return function(tbl1, tbl2)
    local var1 = tbl1 or { clientSearchTerm = "", serverSearchTerm = "" }

    if tbl2.type == ClientMemoryUpdateSearchFilter.name then
        return (Immutable.Set(var1, "clientSearchTerm", tbl2.searchTerm))
    elseif tbl2.type == ServerMemoryUpdateSearchFilter.name then
        return (Immutable.Set(var1, "serverSearchTerm", tbl2.searchTerm))
    end

    return var1
end
