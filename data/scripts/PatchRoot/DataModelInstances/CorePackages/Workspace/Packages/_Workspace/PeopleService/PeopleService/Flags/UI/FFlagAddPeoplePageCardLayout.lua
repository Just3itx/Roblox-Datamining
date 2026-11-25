-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T01:51:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
game:DefineFastFlag("AddPeoplePageCardLayout4", false)

local engineFeature = game:GetEngineFeature("AddPeoplePageLayoutSettings")

return function(): boolean
    return game:GetFastFlag("AddPeoplePageCardLayout4") and engineFeature
end
