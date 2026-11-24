-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:21:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local isEnabled = game:DefineFastFlag("DebugMyStatsExperienceAgentSpec", false)

local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local Signals = require(DataHydrationParent.Signals)
local _acpSession = require(script.Parent.Types.acpSession)
local SharedFlags = require(DataHydrationParent.SharedFlags)
local FFlagBuildExperienceModelPickerData = SharedFlags.FFlagBuildExperienceModelPickerData
local FFlagBuildExperienceAdvancedPreviewSpecs = SharedFlags.FFlagBuildExperienceAdvancedPreviewSpecs
local createSignal = Signals.createSignal
if FFlagBuildExperienceModelPickerData and isEnabled then
    createSignal = require(DataHydrationParent.SignalsUtils).createSessionScopedSignal
end

local var1, var2 = createSignal({})
local var3, var4 = createSignal({})
local tbl1 = {}
local function func1(_)
    return tbl1
end

local function func2(_) end
if FFlagBuildExperienceModelPickerData and isEnabled then
    func1, func2 = createSignal({})
end

local function normalize(str1: string?): string -- Luacid: Inlined by compiler; 1 call site recovered
    return if str1 == nil or str1 == "" or str1 == "latest" then "" else str1
end

local function getState(str1: string?, arg1)
    local var5 = if str1 == nil then nil else var1(arg1 or false)[str1]
    return {
        isSet = var5 ~= nil,
        specVersion = if var5 == nil or var5.specVersion == "" then nil else var5.specVersion,
        specName = if FFlagBuildExperienceAdvancedPreviewSpecs and var5 ~= nil then var5.specName else nil
    }
end

local function isPending(str1: string?): boolean -- Luacid: Inlined by compiler; 11 call sites recovered
    return not (str1 == nil) and var3(false)[str1] == true
end

local function writeDisplay(str1: string, str2: string?, arg1, specName)
    local var5 = table.clone(var1(false))
    local var6 = table.clone(arg1 or var5[str1] or { clientToolConfig = { mode = "exclude", tools = {} } })

    var6.specVersion = normalize(str2)
    if FFlagBuildExperienceAdvancedPreviewSpecs and arg1 == nil then
        var6.specName = specName
    end
    var5[str1] = var6
    var2(var5)
end

local function setPendingFlag(str1: string, bool2: boolean) -- Luacid: Inlined by compiler; 6 call sites recovered
    if isPending(str1) == bool2 then
        return
    end
    local var5 = table.clone(var3(false))
    if bool2 then
        var5[str1] = true
    else
        var5[str1] = nil
    end
    var4(var5)
end

local num1 = 0

local function buildPromptPayload(str1: string)
    local var5 = table.clone(var1(false)[str1])
    if func1(false)[str1] == false then
        var5.specVersion = ""
        if FFlagBuildExperienceAdvancedPreviewSpecs then
            var5.specName = nil
        end
    end

    if FFlagBuildExperienceAdvancedPreviewSpecs and var5.specName == "build-on-mobile-advanced" and var5.specVersion == "" then
        var5.specVersion = "latest"
    end
    return var5
end

return {
    isEnabled = function()
        return isEnabled
    end,
    getKey = function(str1: string?)
        if str1 ~= nil and str1 ~= "" then
            return `session:{str1}`
        end
        return nil
    end,
    selectInternal = function(str1: string, bool2: boolean)
        if not getState(str1).isSet then
            writeDisplay(str1, nil)
        end
        local var5 = table.clone(func1(false))
        var5[str1] = bool2
        func2(var5)
        setPendingFlag(str1, true)
    end,
    getInternalSelection = function(str1: string, arg1)
        local bool2 = func1(arg1)[str1]
        local state = getState(str1, arg1)
        local tbl2 = { isSelected = 0, previewHash = 0, previewSpecName = 0 }

        if bool2 == nil then
            bool2 = state.specVersion ~= nil or state.specName == "build-on-mobile-advanced"
        end

        tbl2.isSelected = bool2

        tbl2.previewHash = state.specVersion
        tbl2.previewSpecName = state.specName
        return tbl2
    end,
    hasInternalEdit = function(str1: string?): boolean
        return not (str1 == nil) and func1(false)[str1] ~= nil
    end,
    normalize = normalize,
    createPendingKey = function(): string
        num1 += 1
        return `pending:{num1}`
    end,
    getState = getState,
    getStateSignal = function(str1: string?)
        return Signals.createComputed(function(arg1)
            return (getState(str1, arg1))
        end)
    end,
    get = function(str1: string?): number
        return getState(str1, nil).specVersion
    end,
    has = function(str1: string?): boolean
        return getState(str1, nil).isSet
    end,
    isPending = isPending,
    set = function(str1: string?, str2: string?, specName)
        if str1 == nil then
            return
        end
        writeDisplay(str1, str2, nil, specName)
        setPendingFlag(str1, true)
    end,
    hydrate = function(str1: string?, str2: string?, arg1)
        if str1 == nil or isPending(str1) or func1(false)[str1] ~= nil then
            return
        end
        writeDisplay(str1, str2, arg1)
    end,
    clear = function(str1: string?)
        if str1 == nil then
            return
        end
        local var5 = table.clone(var1(false))
        var5[str1] = nil
        var2(var5)
        setPendingFlag(str1, false)
        local var6 = table.clone(func1(false))
        var6[str1] = nil
        func2(var6)
    end,
    consumePending = function(str1: string?)
        if str1 == nil or not isPending(str1) then
            return
        end

        setPendingFlag(str1, false)
    end,
    move = function(str1: string?, str2: string?)
        local var5 = var1(false)
        if str1 == nil or str2 == nil or var5[str1] == nil or str1 == str2 then
            return
        end
        local var6 = table.clone(var5)
        var6[str2] = var6[str1]
        var6[str1] = nil
        var2(var6)
        local var7 = table.clone(func1(false))
        var7[str2] = var7[str1]
        var7[str1] = nil
        func2(var7)
        local bool2 = isPending(str1)
        setPendingFlag(str1, false)
        setPendingFlag(str2, bool2)
    end,
    getExperiment = function(str1: string?)
        local state = getState(str1, nil)
        local bool2 = FFlagBuildExperienceAdvancedPreviewSpecs

        if bool2 then
            if state.specName == "build-on-mobile-advanced" then
                bool2 = func1(false)[str1] ~= false
            else
                bool2 = false
            end
        end

        if not isEnabled or state.specVersion == nil and not bool2 then
            return nil
        end
        return (buildPromptPayload(str1))
    end,
    getPromptExperiment = function(str1: string?)
        local state = getState(str1, nil)

        if not (isEnabled and isPending(str1) and state.isSet) then
            return nil
        end
        return (buildPromptPayload(str1))
    end
}
