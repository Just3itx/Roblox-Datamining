-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T11:01:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local _types = require(scriptParentParent.types)

return function(arg1): boolean
    return table.isfrozen(arg1)
end
