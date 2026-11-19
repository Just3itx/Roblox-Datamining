-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T11:41:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppStorageService = game:GetService("AppStorageService")
local HttpService = game:GetService("HttpService")

local module = {}

module.__index = module

function module.new(_appStorageService)
    local tbl1 = {
        _appStorageService = _appStorageService or AppStorageService,
        _httpService = HttpService,
        _jsonDecodeCache = {}
    }
    setmetatable(tbl1, module)
    return tbl1
end

function module:getCachedJsonForKey(str1: string, bool1: boolean?)
    local var1

    if self._jsonDecodeCache[str1] == nil or bool1 then
        var1 = self:decodeInternal(str1)
        self._jsonDecodeCache[str1] = var1
    else
        var1 = self._jsonDecodeCache[str1]
    end
    return var1.result
end

function module:decodeInternal(str1: string)
    local success, result = pcall(function()
        return self._appStorageService:GetItem(str1)
    end)
    if not success then
        return { result = nil }
    end

    local success2, result2 = pcall(function()
        return self._httpService:JSONDecode(result)
    end)

    return if success2 then { result = result2 } else { result = nil }
end

module.default = module.new(nil)
return module
