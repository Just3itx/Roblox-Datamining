-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:41:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
game:DefineFastInt("FullscreenTitleBarTriggerDelayMillis", 0)

return function(): number
    local fastInt = game:GetFastInt("FullscreenTitleBarTriggerDelayMillis")
    return if fastInt < 0 then 0 else fastInt
end
