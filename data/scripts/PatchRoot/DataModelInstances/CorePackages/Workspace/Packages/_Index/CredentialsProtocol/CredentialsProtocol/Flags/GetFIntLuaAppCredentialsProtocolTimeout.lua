-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T09:40:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
game:DefineFastInt("LuaAppCredentialsProtocolTimeout", 20)

return function(): number
    local fastInt = game:GetFastInt("LuaAppCredentialsProtocolTimeout")
    return if fastInt <= 20 then 20 else fastInt
end
