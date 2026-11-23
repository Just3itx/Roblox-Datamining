-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T21:20:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function thumbForUniverseId(id: number): string
    return string.format("rbxthumb://type=GameIcon&id=%d&w=150&h=150", id)
end

return thumbForUniverseId
