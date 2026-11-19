-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T04:01:00Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
game:DefineFastInt("AccountRecoverySecondsBetweenResends", 30)

return function(): number
    return game:GetFastInt("AccountRecoverySecondsBetweenResends")
end
