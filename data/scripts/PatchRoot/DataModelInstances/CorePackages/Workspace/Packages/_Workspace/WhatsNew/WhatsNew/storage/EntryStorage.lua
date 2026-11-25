-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T23:01:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local WhatsNew = script:FindFirstAncestor("WhatsNew")
local WhatsNewParent = WhatsNew.Parent
local AppCommonLib = require(WhatsNewParent.AppCommonLib)
local _Types = require(WhatsNew.Types)
local AppStorageService = game:GetService("AppStorageService")
local HttpService = game:GetService("HttpService")
local appStorageJsonCacheUtils = AppCommonLib.Utils.AppStorageJsonCacheUtils.new(AppStorageService)

local function getOrCreateStoredEntry(entries, str1: string) -- Luacid: Inlined by compiler; 1 call site recovered
    local tbl1 = entries[str1]
    if type(tbl1) ~= "table" then
        tbl1 = {}
        entries[str1] = tbl1
    end
    return tbl1
end

local function emptyDeviceData() -- Luacid: Inlined by compiler; 2 call sites recovered
    return {
        entries = {}
    }
end

local function normalizeDeviceData(tbl1) -- Luacid: Inlined by compiler; 3 call sites recovered
    if type(tbl1.entries) ~= "table" then
        tbl1.entries = {}
    end
    return tbl1
end

local function deepClone(arg1)
    local result = ({})
    if type(arg1) == "table" then
        for value, value2 in arg1 do
            if type(value2) == "table" then
                result[value] = deepClone(value2)
            else
                result[value] = value2
            end
        end
    end
    return result
end

local function readDeviceData(): {[any]: any}? -- Luacid: Inlined by compiler; 3 call sites recovered
    local cachedJsonForKey = appStorageJsonCacheUtils:getCachedJsonForKey("WhatsNewEntries")
    return if type(cachedJsonForKey) == "table" then cachedJsonForKey else nil
end

local function cloneStoredDeviceData(tbl1) -- Luacid: Inlined by compiler; 3 call sites recovered
    local tbl2 = {
        entries = deepClone(tbl1.entries)
    }
    normalizeDeviceData(tbl2)
    return tbl2
end

local function writeDeviceData(input): boolean
    local success, result = pcall(function(): string
        return HttpService:JSONEncode(input)
    end)
    if not success or type(result) ~= "string" then
        warn(`WhatsNew EntryStorage: failed to encode storage: {result}`)
        return false
    end

    local success2, result2 = pcall(function()
        AppStorageService:SetItem("WhatsNewEntries", result)
        AppStorageService:Flush()
    end)
    if not success2 then
        warn(`WhatsNew EntryStorage: failed to persist storage: {result2}`)
        return false
    end

    appStorageJsonCacheUtils:getCachedJsonForKey("WhatsNewEntries", true)
    return true
end

local function getDeviceData() -- Luacid: unused: defined but never referenced
    local var1 = readDeviceData()

    if var1 == nil then
        return emptyDeviceData()
    end

    return cloneStoredDeviceData(var1)
end

local function updateDeviceData(func1: (...any) -> (...any))
    local var1 = readDeviceData()
    local tbl1 = not var1 and {
        entries = {}
    } or cloneStoredDeviceData(var1)
    normalizeDeviceData(tbl1)
    local var2 = func1(tbl1)
    if var2 == nil then
        return
    end

    normalizeDeviceData(var2)
    writeDeviceData(var2)
end

local function toSnapshot(entries)
    local result = ({})
    if type(entries) ~= "table" then
        return result
    end

    for value, value2 in entries do
        if type(value2) ~= "table" then
            continue
        end

        local tbl1 = {
            seen = value2.seen,
            optOutCount = 0,
            adopted = false
        }
        result[value] = tbl1
    end

    return result
end

return {
    STORAGE_KEY = "WhatsNewEntries",
    clearJsonCacheForTests = function()
        appStorageJsonCacheUtils._jsonDecodeCache = {}
    end,
    clearForTests = function()
        local tbl1 = emptyDeviceData()
        writeDeviceData(tbl1)
        appStorageJsonCacheUtils._jsonDecodeCache = {}
    end,
    getEntries = function()
        local var1 = readDeviceData()
        local tbl1 = var1 == nil and {
            entries = {}
        } or cloneStoredDeviceData(var1)

        return (toSnapshot(tbl1.entries))
    end,
    markSeen = function(str1: string, seen: string)
        updateDeviceData(function(arg1)
            getOrCreateStoredEntry(arg1.entries, str1).seen = seen
            return arg1
        end)
    end
}
