-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:51:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent

local withCursorMigration = require(scriptParentParentParentParent.Foundation).UNSTABLE.withCursorMigration

local function SelectionCursorConsumer(arg1)
    return withCursorMigration(arg1)
end

return SelectionCursorConsumer
