-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T14:30:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function createGetFInt(name: string, defaultValue: number): () -> number
    local success, result = pcall(function()
        game:DefineFastInt(name, defaultValue)
    end)

    return if success or not result:match("The current thread cannot call") then function(): number
        return game:GetFastInt(name)
    end else function()
        return defaultValue
    end
end

return createGetFInt
