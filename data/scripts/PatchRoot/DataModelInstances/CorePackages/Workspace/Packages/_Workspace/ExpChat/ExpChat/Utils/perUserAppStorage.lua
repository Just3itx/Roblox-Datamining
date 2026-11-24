-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:40:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppStorageService = game:GetService("AppStorageService")
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")

local function getLocalUserKey(): string -- Luacid: Inlined by compiler; 2 call sites recovered
    local localPlayer = Players.LocalPlayer
    if localPlayer == nil then
        return ""
    end
    return tostring(localPlayer.UserId)
end

local function readLookup(key: string)
    local success, result = pcall(function(): string
        return AppStorageService:GetItem(key)
    end)
    if not success or type(result) ~= "string" or result == "" then
        return {}
    end
    local success2, result2 = pcall(function()
        return HttpService:JSONDecode(result)
    end)
    return if success2 and type(result2) == "table" then result2 else {}
end

local function writeLookup(key: string, input): boolean
    local success, result = pcall(function(): string
        return HttpService:JSONEncode(input)
    end)
    if not success or type(result) ~= "string" then
        return false
    end
    return (pcall(function()
        AppStorageService:SetItem(key, result)
        AppStorageService:Flush()
    end))
end
local module = {}

function module.getEntry(key: string)
    local localUserKey = getLocalUserKey()

    if localUserKey == "" then
        return {}
    end
    local var1 = readLookup(key)[localUserKey]
    return if type(var1) == "table" then var1 else {}
end

function module.updateEntry(key: string, func1: (...any) -> (...any))
    local localUserKey = getLocalUserKey()

    if localUserKey == "" then
        return
    end
    local tbl1 = readLookup(key)
    local var1 = tbl1[localUserKey]
    local var2 = func1(type(var1) ~= "table" and {} or var1)
    if var2 == nil then
        return
    end
    tbl1[localUserKey] = var2
    writeLookup(key, tbl1)
end

return module
