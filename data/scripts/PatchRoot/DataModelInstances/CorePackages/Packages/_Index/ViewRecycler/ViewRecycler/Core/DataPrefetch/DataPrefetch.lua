-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:11:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ViewRecycler = script:FindFirstAncestor("ViewRecycler")

local _Types = require(ViewRecycler.Core.Types)

local tbl1 = {
    Edge = table.freeze({ Start = "start", End = "end" })
}

function tbl1.resolve(tbl2)
    local startItems = if tbl2 == nil then 0 else tbl2.startItems or 0
    local endItems = if tbl2 == nil then 0 else tbl2.endItems or 0
    assert(startItems >= 0 and startItems % 1 == 0, "DataPrefetch: startItems must be a non-negative integer")
    assert(endItems >= 0 and endItems % 1 == 0, "DataPrefetch: endItems must be a non-negative integer")
    return { startItems = startItems, endItems = endItems }
end

return table.freeze(tbl1)
