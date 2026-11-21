-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T09:40:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
game:DefineFastInt("LuaAppCredentialsProtocolAvailableTimeout", 2)

return function(): number
    local fastInt = game:GetFastInt("LuaAppCredentialsProtocolAvailableTimeout")
    return if fastInt <= 0 then 2 else fastInt
end
