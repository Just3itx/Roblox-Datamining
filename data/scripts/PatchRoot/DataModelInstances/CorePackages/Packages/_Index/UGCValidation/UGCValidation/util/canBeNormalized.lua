-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:11:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local floatEquals = require(scriptParentParent.util.floatEquals)

local function canBeNormalized(vec1: vector): boolean
    return not (floatEquals(vec1.X, 0) and floatEquals(vec1.Y, 0) and floatEquals(vec1.Z, 0))
end

return canBeNormalized
