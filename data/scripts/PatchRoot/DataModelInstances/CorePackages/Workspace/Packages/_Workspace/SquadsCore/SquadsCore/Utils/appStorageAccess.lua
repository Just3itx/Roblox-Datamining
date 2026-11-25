-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T18:11:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local AppStorageService = game:GetService("AppStorageService")

return {
    getTableAppStorageKey = function(key: string)
        local success, result = pcall(function(): string
            return AppStorageService:GetItem(key)
        end)

        if not success or result == nil then
            return {}
        end

        return HttpService:JSONDecode(result)
    end,
    setTableAppStorageKey = function(key: string, arg1)
        pcall(function()
            AppStorageService:SetItem(key, tostring(arg1))
            AppStorageService:Flush()
        end)
    end
}
