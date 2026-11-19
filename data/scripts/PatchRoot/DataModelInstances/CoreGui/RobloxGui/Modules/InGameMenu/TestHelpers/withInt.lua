-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:51:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function withInt(name: string, newValue: number, callback)
    local newValue2 = game:SetFastIntForTesting(name, newValue)
    local success, result = pcall(callback)

    game:SetFastIntForTesting(name, newValue2)

    if not success then
        error(result)
    end
end

return withInt
