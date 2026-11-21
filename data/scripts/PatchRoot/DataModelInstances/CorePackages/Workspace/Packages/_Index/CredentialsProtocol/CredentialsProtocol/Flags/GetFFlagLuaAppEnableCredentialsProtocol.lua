-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T09:40:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
game:DefineFastFlag("LuaAppEnableCredentialsProtocol", false)

return function(): boolean
    return game:GetFastFlag("LuaAppEnableCredentialsProtocol")
end
