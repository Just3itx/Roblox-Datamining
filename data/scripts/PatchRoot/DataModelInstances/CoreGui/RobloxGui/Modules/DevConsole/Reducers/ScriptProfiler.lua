-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T20:01:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Immutable = require(script.Parent.Parent.Immutable)

local SetScriptProfilerState = require(script.Parent.Parent.Actions.SetScriptProfilerState)
local SetScriptProfilerRoot = require(script.Parent.Parent.Actions.SetScriptProfilerRoot)
local SetIsProfiling = require(script.Parent.Parent.Components.ScriptProfiler.Actions.SetIsProfiling)
local SetData = require(script.Parent.Parent.Components.ScriptProfiler.Actions.SetData)
local SetThreads = require(script.Parent.Parent.Components.ScriptProfiler.Actions.SetThreads)
local SetTimerState = require(script.Parent.Parent.Components.ScriptProfiler.Actions.SetTimerState)

local ClearStateForNewProfilingSession = require(script.Parent.Parent.Components.ScriptProfiler.Actions.ClearStateForNewProfilingSession)
local SetAverage = require(script.Parent.Parent.Components.ScriptProfiler.Actions.SetAverage)
local SetFrequency = require(script.Parent.Parent.Components.ScriptProfiler.Actions.SetFrequency)
local SetDataView = require(script.Parent.Parent.Components.ScriptProfiler.Actions.SetDataView)
local SetLiveUpdate = require(script.Parent.Parent.Components.ScriptProfiler.Actions.SetLiveUpdate)
local SetShowPlugins = require(script.Parent.Parent.Components.ScriptProfiler.Actions.SetShowPlugins)
local SetShowGC = require(script.Parent.Parent.Components.ScriptProfiler.Actions.SetShowGC)
local SetSearchData = require(script.Parent.Parent.Components.ScriptProfiler.Actions.SetSearchData)
local _ProfilerDataFormatV2 = require(script.Parent.Parent.Components.ScriptProfiler.ProfilerDataFormatV2)

local function GetSessionState(bool1: boolean, arg1) -- Luacid: Inlined by compiler; 8 call sites recovered
    return if bool1 then arg1.client else arg1.server
end

local function Update(isClient, tbl1, tbl2)
    local sessionState = if isClient then GetSessionState(true, tbl1) else GetSessionState(false, tbl1)
    local var1 = Immutable.JoinDictionaries(sessionState, tbl2)

    local tbl3 = {
        client = if isClient then var1 else nil,
        server = 0
    }

    if isClient then
        var1 = nil
    end

    tbl3.server = var1

    return Immutable.JoinDictionaries(tbl1, tbl3)
end

return function(tbl1, tbl2)
    local var1 = tbl1
        or {
            isClientView = true,
            usePercentages = false,
            isExporting = false,
            isShowingMobileSettings = false,
            client = {
                isProfiling = false,
                data = nil,
                serializedData = nil,
                frequency = 1000,
                timedProfilingThread = nil,
                timedProfilingTimerThread = nil,
                timedProfilingDuration = 0,
                timedProfilingCountdown = 0,
                isFunctionsView = false,
                average = 0,
                searchTerm = "",
                searchFilterGraph = {},
                searchFilterFlat = {},
                rootNode = 0,
                rootFunc = 0,
                rootNodeName = nil,
                liveUpdate = false,
                liveUpdateThread = nil,
                showPlugins = false,
                pluginOffsets = {},
                showGC = false,
                gcFunctionOffsets = {},
                gcNodeOffsets = {},
                pluginGCOffsets = {},
                expandedNodes = {}
            },
            server = {
                isProfiling = false,
                data = nil,
                serializedData = nil,
                frequency = 1000,
                timedProfilingThread = nil,
                timedProfilingTimerThread = nil,
                timedProfilingDuration = 0,
                timedProfilingCountdown = 0,
                isFunctionsView = false,
                average = 0,
                searchTerm = "",
                searchFilterGraph = {},
                searchFilterFlat = {},
                rootNode = 0,
                rootFunc = 0,
                rootNodeName = nil,
                liveUpdate = false,
                liveUpdateThread = nil,
                showPlugins = false,
                pluginOffsets = {},
                showGC = false,
                gcFunctionOffsets = {},
                gcNodeOffsets = {},
                pluginGCOffsets = {},
                expandedNodes = {}
            }
        }

    if tbl2.type == SetScriptProfilerState.name then
        local tbl3 = {
            isClientView = tbl2.isClientView,
            usePercentages = tbl2.usePercentages,
            isExporting = tbl2.isExporting,
            isShowingMobileSettings = tbl2.isShowingMobileSettings,
            client = tbl2.clientSessionState,
            server = tbl2.serverSessionState
        }
        return (Immutable.JoinDictionaries(var1, tbl3))
    end

    if tbl2.type == SetIsProfiling.name then
        return Update(tbl2.isClient, var1, { isProfiling = tbl2.isProfiling })
    end

    if tbl2.type == SetAverage.name then
        return Update(tbl2.isClient, var1, { average = tbl2.average })
    end

    if tbl2.type == SetFrequency.name then
        return Update(tbl2.isClient, var1, { frequency = tbl2.frequency })
    end

    if tbl2.type == SetDataView.name then
        return Update(tbl2.isClient, var1, { isFunctionsView = tbl2.isFunctionsView })
    end

    if tbl2.type == SetLiveUpdate.name then
        return Update(tbl2.isClient, var1, { liveUpdate = tbl2.liveUpdate })
    end

    if tbl2.type == SetShowPlugins.name then
        return Update(tbl2.isClient, var1, { showPlugins = tbl2.showPlugins })
    end

    if tbl2.type == SetShowGC.name then
        return Update(tbl2.isClient, var1, { showGC = tbl2.showGC })
    end

    if tbl2.type == SetSearchData.name then
        return Update(tbl2.isClient, var1, {
            searchTerm = tbl2.state.searchTerm,
            searchFilterFlat = tbl2.state.searchFilterFlat,
            searchFilterGraph = tbl2.state.searchFilterGraph
        })
    end
    if tbl2.type == SetTimerState.name then
        local tbl3 = {
            timedProfilingDuration = tbl2.state.timedProfilingDuration,
            timedProfilingCountdown = tbl2.state.timedProfilingCountdown
        }

        return Update(tbl2.isClient, var1, tbl3)
    end

    if tbl2.type == SetData.name then
        local var2 = table.clone(if tbl2.isClient then GetSessionState(true, var1) else GetSessionState(false, var1))

        var2.data = tbl2.state.data
        var2.serializedData = tbl2.state.serializedData
        var2.pluginOffsets = tbl2.state.pluginOffsets or {}
        var2.pluginGCOffsets = tbl2.state.pluginGCOffsets or {}
        var2.gcFunctionOffsets = tbl2.state.gcFunctionOffsets or {}
        var2.gcNodeOffsets = tbl2.state.gcNodeOffsets or {}
        var2.expandedNodes = tbl2.state.expandedNodes or {}

        local var3 = table.clone(var1)

        if tbl2.isClient then
            var3.client = var2
        else
            var3.server = var2
        end

        return Immutable.JoinDictionaries(var1, var3)
    end

    if tbl2.type == SetThreads.name then
        local var2 = table.clone(if tbl2.isClient then GetSessionState(true, var1) else GetSessionState(false, var1))

        var2.timedProfilingThread = tbl2.state.timedProfilingThread
        var2.timedProfilingTimerThread = tbl2.state.timedProfilingTimerThread
        var2.liveUpdateThread = tbl2.state.liveUpdateThread

        local var3 = table.clone(var1)

        if tbl2.isClient then
            var3.client = var2
        else
            var3.server = var2
        end

        return Immutable.JoinDictionaries(var1, var3)
    end

    if tbl2.type == ClearStateForNewProfilingSession.name then
        local var2 = table.clone(if tbl2.isClient then GetSessionState(true, var1) else GetSessionState(false, var1))

        var2.rootNode = 0
        var2.rootFunc = 0
        var2.rootNodeName = nil
        var2.searchFilterFlat = {}
        var2.searchFilterGraph = {}
        var2.expandedNodes = {}

        local var3 = table.clone(var1)

        if tbl2.isClient then
            var3.client = var2
        else
            var3.server = var2
        end

        return Immutable.JoinDictionaries(var1, var3)
    end

    if tbl2.type ~= SetScriptProfilerRoot.name then
        return var1
    end

    local tbl3 = {}

    local var2 = table.clone(if var1.isClientView then var1.client else var1.server)

    if var2.rootNode ~= tbl2.rootNode then
        var2.rootNode = tbl2.rootNode
        var2.rootFunc = tbl2.rootFunc
        var2.rootNodeName = tbl2.rootNodeName
    else
        var2.rootNode = 0
        var2.rootFunc = 0
        var2.rootNodeName = nil
    end

    if var1.isClientView then
        tbl3.client = var2
    else
        tbl3.server = var2
    end

    return Immutable.JoinDictionaries(var1, tbl3)
end
