-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:10:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
game:DefineFastString("UGCValidateFrameDeltaKeyTimeTol", "0.85")

local module = {}

function module.asString(): string
    return game:GetFastString("UGCValidateFrameDeltaKeyTimeTol")
end

function module.asNumber(): number?
    return tonumber(module.asString())
end

return module
