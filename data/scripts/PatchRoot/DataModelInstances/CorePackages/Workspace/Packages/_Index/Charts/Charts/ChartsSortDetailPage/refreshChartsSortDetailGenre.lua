-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T06:30:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Charts = script:FindFirstAncestor("Charts")
local ChartsParent = Charts.Parent

local Promise = require(ChartsParent.Promise)
local SduiSharedUtilities = require(ChartsParent.SduiSharedUtilities)
local getSduiApiStore = SduiSharedUtilities.getSduiApiStore
local getSduiClientPageScope = SduiSharedUtilities.getSduiClientPageScope

local ChartsSortDetailScopeFields = require(Charts.ChartsSortDetailPage.ChartsSortDetailScopeFields)

local function canStartGenreRefresh(str1: string): boolean -- Luacid: unused: defined but never referenced
    return not getSduiApiStore().isInFlight(str1)
end

local function finishRefresh(configKey: string, bool1: boolean) -- Luacid: Inlined by compiler; 2 call sites recovered
    local sduiClientPageScope = getSduiClientPageScope(configKey)
    if bool1 then
        local var1 = sduiClientPageScope.get(ChartsSortDetailScopeFields.DesiredGenre)
        sduiClientPageScope.set(ChartsSortDetailScopeFields.SafeGenre, var1)
        return
    end
    local var1 = sduiClientPageScope.get(ChartsSortDetailScopeFields.SafeGenre)
    sduiClientPageScope.set(ChartsSortDetailScopeFields.DesiredGenre, var1)
end

local function settleGenreRefresh(configKey: string, arg1)
    if typeof(arg1) ~= "table" then
        return Promise.reject("ChartsSortDetail genre refresh non-table result")
    end

    finishRefresh(configKey, true)
    return Promise.resolve(arg1)
end

local function refreshChartsSortDetailGenre(tbl1)
    local configKey = tbl1.configKey
    local selectedGenre = tbl1.selectedGenre

    if typeof(configKey) ~= "string" or configKey == "" then
        return nil
    end
    if typeof(selectedGenre) ~= "string" or selectedGenre == "" then
        return nil
    end

    if getSduiApiStore().isInFlight(configKey) then
        return nil
    end

    getSduiClientPageScope(configKey).set(ChartsSortDetailScopeFields.DesiredGenre, selectedGenre)

    return getSduiApiStore().refreshFromApi({ configKey = configKey, loadTimer = tbl1.loadTimer }):andThen(function(arg1)
        return settleGenreRefresh(configKey, arg1)
    end):catch(function(arg1)
        finishRefresh(configKey, false)
        return Promise.reject(arg1)
    end)
end

return refreshChartsSortDetailGenre
