-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:50:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {
    Enum = { IN_APP = "IN_APP", IN_EXPERIENCE = "IN_EXPERIENCE" }
}

function module.get(): string
    return if game.GameId == 0 then "IN_APP" else "IN_EXPERIENCE"
end

return module
