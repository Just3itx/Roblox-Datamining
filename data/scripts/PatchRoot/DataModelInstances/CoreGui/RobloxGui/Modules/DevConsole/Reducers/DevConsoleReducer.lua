-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:51:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local DevConsoleDisplayOptions = require(scriptParent.DevConsoleDisplayOptions)
local MainView = require(scriptParent.MainView)

local MemoryData = require(scriptParent.MemoryData)
local NetworkData = require(scriptParent.NetworkData)
local ScriptsData = require(scriptParent.ScriptsData)
local DataStoresData = require(scriptParent.DataStoresData)
local ServerStatsData = require(scriptParent.ServerStatsData)
local ServerJobsData = require(scriptParent.ServerJobsData)
local ActionBindingsData = require(scriptParent.ActionBindingsData)
local MicroProfiler = require(scriptParent.MicroProfiler)
local DebugVisualizationsData = require(scriptParent.DebugVisualizationsData)
local ScriptProfiler = require(scriptParent.ScriptProfiler)
local LuauHeap = require(scriptParent.LuauHeap)

return function(tbl1, tbl2)
    local tbl3 = tbl1 or {}
    return {
        DisplayOptions = DevConsoleDisplayOptions(tbl3.DisplayOptions, tbl2),
        MainView = MainView(tbl3.MainView, tbl2),
        MemoryData = MemoryData(tbl3.MemoryData, tbl2),
        NetworkData = NetworkData(tbl3.NetworkData, tbl2),
        ScriptsData = ScriptsData(tbl3.ScriptsData, tbl2),
        DataStoresData = DataStoresData(tbl3.DataStoresData, tbl2),
        ServerStatsData = ServerStatsData(tbl3.ServerStatsData, tbl2),
        ServerJobsData = ServerJobsData(tbl3.ServerJobsData, tbl2),
        ActionBindingsData = ActionBindingsData(tbl3.ActionBindingsData, tbl2),
        MicroProfiler = MicroProfiler(tbl3.MicroProfiler, tbl2),
        DebugVisualizationsData = DebugVisualizationsData(tbl3.DebugVisualizationsData, tbl2),
        ScriptProfiler = ScriptProfiler(tbl3.ScriptProfiler, tbl2),
        LuauHeap = LuauHeap(tbl3.LuauHeap, tbl2)
    }
end
