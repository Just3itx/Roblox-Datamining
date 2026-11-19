-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:41:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
game:DefineFastFlag("FixFullscreenTitleBarPromiseCancel", false)

return function(): boolean
    return game:GetFastFlag("FixFullscreenTitleBarPromiseCancel")
end
