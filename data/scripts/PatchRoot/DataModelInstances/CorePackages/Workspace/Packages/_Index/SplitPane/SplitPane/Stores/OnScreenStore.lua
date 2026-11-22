-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T21:31:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SplitPaneParent = script:FindFirstAncestor("SplitPane").Parent

local Signals = require(SplitPaneParent.Signals)

local tbl1 = ({})

local function getOrCreateEntry(str1: string) -- Luacid: Inlined by compiler; 2 call sites recovered
    local tbl2 = tbl1[str1]
    if tbl2 == nil then
        local get, set = Signals.createSignal(nil)
        tbl2 = { get = get, set = set }
        tbl1[str1] = tbl2
    end
    return tbl2
end

return {
    setRouteOnScreen = function(str1: string, tbl2)
        getOrCreateEntry(str1).set(tbl2)
    end,
    getRouteOnScreen = function(arg1, str1: string)
        return getOrCreateEntry(str1).get(arg1)
    end,
    _resetForTest = function()
        table.clear(tbl1)
    end
}
