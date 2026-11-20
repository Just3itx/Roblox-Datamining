-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:31:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent

local t = require(scriptParentParentParentParent.t)

return function(arg1): number
    assert(t.number(arg1))
    return if arg1 < 360 then 12 elseif arg1 < 600 then 24 else 48
end
