-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T03:40:48Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
game:DefineFastFlag("JoinWithoutMicPermissions3", false)

local bool1 = true

return function(bool2: boolean?): boolean
    if bool2 ~= nil then
        bool1 = bool2
    end
    return game:GetFastFlag("JoinWithoutMicPermissions3") and bool1
end
