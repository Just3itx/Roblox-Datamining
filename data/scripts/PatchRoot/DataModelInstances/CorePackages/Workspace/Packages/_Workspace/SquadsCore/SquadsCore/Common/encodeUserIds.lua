-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T17:41:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local function encodeUserIds(input)
    if input == nil then
        return "[]"
    end

    local success, result = pcall(function(): string
        return HttpService:JSONEncode(input)
    end)

    return if success then result else "[]"
end

return encodeUserIds
