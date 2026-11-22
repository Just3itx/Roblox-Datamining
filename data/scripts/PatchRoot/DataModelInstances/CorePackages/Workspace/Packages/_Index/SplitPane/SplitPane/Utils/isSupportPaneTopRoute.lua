-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T21:40:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SplitPaneStore = require(script.Parent.Parent.Stores.SplitPaneStore)

local function isSupportPaneTopRoute(str1: string, tbl1)
    local var1 = SplitPaneStore.getStore().getSupportPaneTopRouteMatcher(false)
    return not (var1 == nil) and var1(str1, tbl1)
end

return isSupportPaneTopRoute
