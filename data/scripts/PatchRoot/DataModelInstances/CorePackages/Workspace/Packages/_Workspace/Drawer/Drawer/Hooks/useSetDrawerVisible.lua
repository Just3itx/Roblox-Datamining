-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T06:05:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GetDrawerVisibleStore = require(script.Parent.Parent.Stores.GetDrawerVisibleStore)

local function useSetDrawerVisible()
    return GetDrawerVisibleStore(false).setDrawerVisible
end

return useSetDrawerVisible
