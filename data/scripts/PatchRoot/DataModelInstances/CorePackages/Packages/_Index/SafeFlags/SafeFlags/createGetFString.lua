-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T14:31:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function createGetFString(name: string, defaultValue: string): () -> string
    local success, result = pcall(function()
        game:DefineFastString(name, defaultValue)
    end)

    return if success or not result:match("The current thread cannot call") then function(): string
        return game:GetFastString(name)
    end else function()
        return defaultValue
    end
end

return createGetFString
