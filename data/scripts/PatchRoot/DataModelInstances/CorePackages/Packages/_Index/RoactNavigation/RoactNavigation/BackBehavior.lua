-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:11:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local NavigationSymbol = require(script.Parent.NavigationSymbol)

local tbl1 = {
    None = NavigationSymbol("NONE"),
    InitialRoute = NavigationSymbol("INITIAL_ROUTE"),
    Order = NavigationSymbol("ORDER"),
    History = NavigationSymbol("HISTORY")
}

setmetatable(tbl1, {
    __index = function(_, arg1)
        error(("%q is not a valid member of BackBehavior"):format(tostring(arg1)), 2)
    end
})

return tbl1
