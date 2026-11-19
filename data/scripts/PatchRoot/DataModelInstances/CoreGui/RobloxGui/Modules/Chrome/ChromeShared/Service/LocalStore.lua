-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:31:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChromeShared = script:FindFirstAncestor("ChromeShared")

local AppStorageService = game:GetService("AppStorageService")
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")

local Constants = require(ChromeShared.Unibar.Constants)

local isEnabled = game:GetEngineFeature("InGameMenuStateStorageKey")

local input = nil
local bool1 = false

local LocalPlayer = Players.LocalPlayer
while not LocalPlayer do
    Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
    LocalPlayer = Players.LocalPlayer
end

local str1 = "player_" .. tostring(if LocalPlayer then LocalPlayer.UserId else 0)

local function initStore()
    if input.LocalPlayer == nil then
        input.LocalPlayer = {}
    end
    if input.LocalPlayer[str1] == nil then
        input.LocalPlayer[str1] = {}
    end
    if input.AnyPlayer == nil then
        input.AnyPlayer = {}
    end
end

local function localPlayerSelector(arg1) -- Luacid: Inlined by compiler; 7 call sites recovered
    return if arg1 and arg1.LocalPlayer and arg1.LocalPlayer[str1] then arg1.LocalPlayer[str1] else arg1
end

local function anyPlayerSelector(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    return if arg1 and arg1.AnyPlayer then arg1.AnyPlayer else arg1
end

local function loadStore()
    if not isEnabled then
        return
    end
    local success, result = pcall(function(): string
        return AppStorageService:GetItem("InGameMenuState")
    end)
    if not success then
        return
    end

    bool1 = true
    if #result > 0 then
        local success2, result2 = pcall(function()
            return HttpService:JSONDecode(result)
        end)
        if success2 then
            input = result2
        else
            input = {}
        end
    else
        input = {}
    end
    initStore()
end

local function saveStore()
    if not isEnabled then
        return
    end
    if not bool1 then
        return
    end

    local success, result = pcall(function(): string
        return HttpService:JSONEncode(input)
    end)
    if not success then
        error("Failed to encode JSON", 0)
        return
    end

    local success2, result2 = pcall(function()
        AppStorageService:SetItem("InGameMenuState", result)
        AppStorageService:Flush()
    end)
    if not success2 then
        print(result2)
        error("Failed to write JSON to AppStorageService", 0)
    end
end

local function deepCopy(arg1)
    if type(arg1) ~= "table" then
        return arg1
    end

    local result = ({})
    for k, value in pairs(arg1) do
        result[k] = deepCopy(value)
    end
    return result
end

local function store(str2: string, arg1, arg2) -- Luacid: unused: defined but never referenced
    if not bool1 then
        loadStore()
    end
    if not bool1 then
        return
    end

    local var1 = arg2 and arg2(input) or input
    local var2 = var1[str2]
    var1[str2] = deepCopy(arg1)
    if var2 ~= var1[str2] then
        saveStore()
    end
end

local function load(str2: string, arg1) -- Luacid: unused: defined but never referenced
    if not bool1 then
        loadStore()
    end
    if bool1 then
        local var1 = arg1 and arg1(input) or input
        if var1 then
            return (deepCopy(var1[str2]))
        end
    end
    return nil
end

local function getUniversesExposedTo(str2: string) -- Luacid: Inlined by compiler; 1 call site recovered
    local func1 = localPlayerSelector

    if not bool1 then
        loadStore()
    end

    local var1

    if bool1 then
        local var2 = func1 and localPlayerSelector(input) or input
        if var2 then
            var1 = deepCopy(var2[str2])
        else
            var1 = nil
        end
    else
        var1 = nil
    end

    return var1 or {}
end

return {
    isEnabled = function()
        return isEnabled
    end,
    storeForLocalPlayer = function(arg1, arg2)
        local func1 = localPlayerSelector

        if not bool1 then
            loadStore()
        end
        if not bool1 then
            return
        end

        local var1 = func1 and localPlayerSelector(input) or input
        local var2 = var1[arg1]
        var1[arg1] = deepCopy(arg2)
        if var2 ~= var1[arg1] then
            saveStore()
        end
    end,
    loadForLocalPlayer = function(arg1)
        local func1 = localPlayerSelector

        if not bool1 then
            loadStore()
        end
        if bool1 then
            local var1 = func1 and localPlayerSelector(input) or input
            if var1 then
                return (deepCopy(var1[arg1]))
            end
        end
        return nil
    end,
    storeForAnyPlayer = function(arg1, arg2)
        local func1 = anyPlayerSelector

        if not bool1 then
            loadStore()
        end
        if not bool1 then
            return
        end

        local var1 = func1 and anyPlayerSelector(input) or input
        local var2 = var1[arg1]
        var1[arg1] = deepCopy(arg2)
        if var2 ~= var1[arg1] then
            saveStore()
        end
    end,
    loadForAnyPlayer = function(arg1)
        local func1 = anyPlayerSelector

        if not bool1 then
            loadStore()
        end
        if bool1 then
            local var1 = func1 and anyPlayerSelector(input) or input
            if var1 then
                return (deepCopy(var1[arg1]))
            end
        end
        return nil
    end,
    clearCache = function()
        bool1 = false
        input = nil
    end,
    getValue = function(str2: string)
        local func1 = localPlayerSelector

        if not bool1 then
            loadStore()
        end
        if bool1 then
            local var1 = func1 and localPlayerSelector(input) or input
            if var1 then
                return (deepCopy(var1[str2]))
            end
        end
        return nil
    end,
    getUniversesExposedTo = getUniversesExposedTo,
    getNumUniversesExposedTo = function(arg1): number
        local func1 = localPlayerSelector

        if not bool1 then
            loadStore()
        end

        local var1

        if bool1 then
            local var2 = func1 and localPlayerSelector(input) or input
            if var2 then
                var1 = deepCopy(var2[arg1])
            else
                var1 = nil
            end
        else
            var1 = nil
        end

        return #(var1 or {})
    end,
    addUniverseToExposureList = function(str2: string, num1: number)
        local universesExposedTo = getUniversesExposedTo(str2)

        if table.find(universesExposedTo, num1) or not (#universesExposedTo < Constants.MAX_NUM_UNIVERSES_SHOWN) then
            return
        end

        table.insert(universesExposedTo, num1)
        local func1 = localPlayerSelector

        if not bool1 then
            loadStore()
        end
        if not bool1 then
            return
        end

        local var1 = func1 and localPlayerSelector(input) or input
        local var2 = var1[str2]
        var1[str2] = deepCopy(universesExposedTo)
        if var2 ~= var1[str2] then
            saveStore()
        end
    end
}
