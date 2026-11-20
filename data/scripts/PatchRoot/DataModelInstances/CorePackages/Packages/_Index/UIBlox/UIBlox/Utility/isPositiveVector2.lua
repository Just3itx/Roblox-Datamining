-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:40:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local t = require(scriptParentParent.Parent.t)

return (t.intersection(t.Vector2, function(arg1)
    if arg1.X < 0 or arg1.Y < 0 then
        return false, ("each component of the Vector2 must be >= 0; component values are: %d, %d"):format(arg1.X, arg1.Y)
    end

    return true
end))
