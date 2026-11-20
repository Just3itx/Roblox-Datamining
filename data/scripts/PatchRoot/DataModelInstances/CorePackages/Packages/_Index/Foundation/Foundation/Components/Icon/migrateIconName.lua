-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T04:40:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FoundationParent = script:FindFirstAncestor("Foundation").Parent
local Migration = require(FoundationParent.BuilderIcons).Migration

local function migrateIconName(str1: string)
    return Migration.uiblox[str1]
end

return migrateIconName
