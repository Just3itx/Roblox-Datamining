-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:51:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Immutable = require(script.Parent.Parent.Immutable)

local DebugVisualizationsUpdateSearchFilter = require(script.Parent.Parent.Actions.DebugVisualizationsUpdateSearchFilter)

return function(tbl1, tbl2)
    local var1 = tbl1 or {
        debugVisualizationsSearchTerm = "",
        debugVisualizationsTypeFilters = {}
    }
    local debugVisualizationsTypeFilters = if tbl2.filterTypes == nil then var1.debugVisualizationsTypeFilters else Immutable.JoinDictionaries(var1.debugVisualizationsTypeFilters, tbl2.filterTypes)

    if tbl2.type ~= DebugVisualizationsUpdateSearchFilter.name then
        return var1
    end

    local tbl3 = {
        debugVisualizationsSearchTerm = tbl2.searchTerm,
        debugVisualizationsTypeFilters = debugVisualizationsTypeFilters
    }
    return Immutable.JoinDictionaries(var1, tbl3)
end
