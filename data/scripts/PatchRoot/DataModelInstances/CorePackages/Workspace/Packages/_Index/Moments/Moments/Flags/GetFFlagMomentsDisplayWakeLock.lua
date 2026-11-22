-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T05:11:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
game:DefineFastFlag("MomentsDisplayWakeLock", false)

return function(): boolean
    return game:GetFastFlag("MomentsDisplayWakeLock")
end
