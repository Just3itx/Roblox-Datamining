-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T20:01:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Immutable = require(script.Parent.Parent.Immutable)

local ClientNetworkUpdateSearchFilter = require(script.Parent.Parent.Actions.ClientNetworkUpdateSearchFilter)
local ServerNetworkUpdateSearchFilter = require(script.Parent.Parent.Actions.ServerNetworkUpdateSearchFilter)

return function(tbl1, tbl2)
    local var1 = tbl1 or { clientSearchTerm = "", serverSearchTerm = "" }

    if tbl2.type == ClientNetworkUpdateSearchFilter.name then
        return (Immutable.Set(var1, "clientSearchTerm", tbl2.searchTerm))
    elseif tbl2.type == ServerNetworkUpdateSearchFilter.name then
        return (Immutable.Set(var1, "serverSearchTerm", tbl2.searchTerm))
    end

    return var1
end
