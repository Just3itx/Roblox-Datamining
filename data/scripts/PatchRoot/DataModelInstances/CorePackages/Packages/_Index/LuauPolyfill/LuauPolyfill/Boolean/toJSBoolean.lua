-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T10:51:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local Number = require(scriptParentParent.Number)

return function(arg1): boolean
    local bool1 = not not arg1
    return bool1 and arg1 ~= 0 and arg1 ~= "" and not Number.isNaN(arg1)
end
