-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:41:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
game:DefineFastFlag("FullscreenTitleBarInjectGameServices", false)

return function(): boolean
    return game:GetFastFlag("FullscreenTitleBarInjectGameServices")
end
