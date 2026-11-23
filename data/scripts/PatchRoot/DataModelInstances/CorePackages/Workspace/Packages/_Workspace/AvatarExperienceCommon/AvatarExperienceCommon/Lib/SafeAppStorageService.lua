-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:31:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppStorageService = game:GetService("AppStorageService")

local __DEV__ = _G.__DEV__ or false

local tbl1 = ({})

return {
    getItem = function(key: string, bool1: boolean?)
        if __DEV__ or bool1 then
            return tbl1[key] or ""
        end

        local success, result = pcall(function(): string
            return AppStorageService:GetItem(key)
        end)
        return if success then result else tbl1[key] or ""
    end,
    setItem = function(key: string, str1: string, bool1: boolean?)
        if __DEV__ or bool1 then
            tbl1[key] = str1
            return
        end

        if not pcall(function()
            AppStorageService:SetItem(key, str1)
        end) then
            tbl1[key] = str1
        end
    end,
    flush = function()
        pcall(function()
            AppStorageService:Flush()
        end)
    end,
    _resetMemStorageForTesting = function(tbl2)
        tbl1 = tbl2 or {}
    end
}
