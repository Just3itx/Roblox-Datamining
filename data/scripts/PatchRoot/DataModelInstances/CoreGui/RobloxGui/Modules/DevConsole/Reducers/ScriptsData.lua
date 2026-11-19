-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T20:01:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Immutable = require(script.Parent.Parent.Immutable)

local ClientScriptsUpdateSearchFilter = require(script.Parent.Parent.Actions.ClientScriptsUpdateSearchFilter)
local ServerScriptsUpdateSearchFilter = require(script.Parent.Parent.Actions.ServerScriptsUpdateSearchFilter)

return function(tbl1, tbl2)
    local var1 = tbl1 or {
        clientSearchTerm = "",
        clientTypeFilters = {},
        serverSearchTerm = "",
        serverTypeFilters = {}
    }

    if tbl2.type == ClientScriptsUpdateSearchFilter.name then
        local tbl3 = {
            clientSearchTerm = tbl2.searchTerm,
            clientTypeFilters = Immutable.JoinDictionaries(var1.clientTypeFilters, tbl2.filterTypes)
        }
        return (Immutable.JoinDictionaries(var1, tbl3))
    end
    if tbl2.type ~= ServerScriptsUpdateSearchFilter.name then
        return var1
    end

    local tbl3 = {
        serverSearchTerm = tbl2.searchTerm,
        serverTypeFilters = Immutable.JoinDictionaries(var1.serverTypeFilters, tbl2.filterTypes)
    }
    return (Immutable.JoinDictionaries(var1, tbl3))
end
