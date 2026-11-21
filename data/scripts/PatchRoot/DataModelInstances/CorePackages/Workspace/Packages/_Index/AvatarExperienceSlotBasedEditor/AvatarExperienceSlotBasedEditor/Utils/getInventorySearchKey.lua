-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T04:51:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InventorySearchConstants = require(script.Parent.Parent.InventorySearchConstants)

local function getInventorySearchKey(str1: string)
    return InventorySearchConstants.KeyPrefix .. str1
end

return getInventorySearchKey
