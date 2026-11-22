-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:30:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local AppStorageService = game:GetService("AppStorageService")

local function get()
    local success, result = pcall(AppStorageService.GetItem, AppStorageService, "MomentsLocalStorage")
    if not success or result == "" then
        return {}
    end
    local success2, result2 = pcall(HttpService.JSONDecode, HttpService, result)
    return if success2 and typeof(result2) == "table" then result2 else {}
end

local function set(input) -- Luacid: Inlined by compiler; 1 call site recovered
    pcall(function()
        AppStorageService:SetItem("MomentsLocalStorage", HttpService:JSONEncode(input))
        AppStorageService:Flush()
    end)
end

return {
    get = get,
    set = set,
    getField = function(str1: string)
        return get()[str1]
    end,
    setField = function(str1: string, arg1)
        local tbl1 = get()
        tbl1[str1] = arg1
        set(tbl1)
    end
}
