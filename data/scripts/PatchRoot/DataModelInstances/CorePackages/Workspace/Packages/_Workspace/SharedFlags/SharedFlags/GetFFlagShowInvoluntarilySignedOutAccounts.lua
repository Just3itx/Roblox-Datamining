-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T03:51:18Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
game:DefineFastFlag("ShowInvoluntarilySignedOutAccounts", false)

return function(): boolean
    return game:GetFastFlag("ShowInvoluntarilySignedOutAccounts")
end
