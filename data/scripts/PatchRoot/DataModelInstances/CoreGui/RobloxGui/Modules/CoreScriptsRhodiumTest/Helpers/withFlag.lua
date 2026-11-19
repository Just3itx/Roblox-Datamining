-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:10:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function withFlag(name: string, callback)
    local newValue = game:SetFastFlagForTesting(name, true)
    local success, result = pcall(callback)

    game:SetFastFlagForTesting(name, newValue)

    assert(success, tostring(result))
end

return withFlag
