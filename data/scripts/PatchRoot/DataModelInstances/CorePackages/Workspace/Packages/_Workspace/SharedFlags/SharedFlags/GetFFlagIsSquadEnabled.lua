-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T03:40:46Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local bool1 = game:DefineFastFlag("LuaAppEnableSquadPage4", false)
local bool2 = game:DefineFastFlag("ForceEnableSquad", false)
local bool3 = game:DefineFastFlag("SquadEnabled", false)

return function(): boolean
    return bool3 or bool1 and bool2
end
