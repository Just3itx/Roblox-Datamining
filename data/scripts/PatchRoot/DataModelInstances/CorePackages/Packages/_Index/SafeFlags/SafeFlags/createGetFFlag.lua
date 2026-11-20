-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T14:30:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function createGetFFlag(name: string, bool1: boolean?): () -> boolean
    local success, result = pcall(function()
        game:DefineFastFlag(name, bool1 or false)
    end)

    return if success or not result:match("The current thread cannot call") then function(): boolean
        return game:GetFastFlag(name)
    end else function(): boolean
        return name:match("^Debug") == nil
    end
end

return createGetFFlag
