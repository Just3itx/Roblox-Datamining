-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:11:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
game:DefineFastString("UGCValidateMaxAnimationMovement", "0.3")

local module = {}

function module.asString(): string
    return game:GetFastString("UGCValidateMaxAnimationMovement")
end

function module.asNumber(): number?
    return tonumber(module.asString())
end

return module
