-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-18T23:21:17Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local MemStorageService = game:GetService("MemStorageService")

return function(key: string)
    local success, result = pcall(function(): string
        return MemStorageService:GetItem(key)
    end)

    return if success and result and result ~= "" then result else nil
end
