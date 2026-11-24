-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T21:40:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceSideSheetParent = script:FindFirstAncestor("InExperienceSideSheet").Parent
local GetDrawerVisibleStore = require(InExperienceSideSheetParent.Drawer).Stores.GetDrawerVisibleStore

return function(arg1)
    return GetDrawerVisibleStore(arg1).getDrawerVisible(arg1)
end
