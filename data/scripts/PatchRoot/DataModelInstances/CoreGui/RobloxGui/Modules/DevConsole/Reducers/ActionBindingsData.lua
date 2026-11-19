-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:51:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Immutable = require(script.Parent.Parent.Immutable)

local ActionBindingsUpdateSearchFilter = require(script.Parent.Parent.Actions.ActionBindingsUpdateSearchFilter)

return function(tbl1, tbl2)
    local var1 = tbl1 or { bindingsSearchTerm = "" }

    if tbl2.type == ActionBindingsUpdateSearchFilter.name then
        return (Immutable.Set(var1, "bindingsSearchTerm", tbl2.searchTerm))
    end
    return var1
end
