-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:41:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Stats = game:GetService("Stats")
local CoreGui = game:GetService("CoreGui")

local BaseMemoryAnalyzer = require(CoreGui.RobloxGui.Modules.Stats.BaseMemoryAnalyzer)
local CommonUtil = require(CoreGui.RobloxGui.Modules.Common.CommonUtil)
local StatsUtils = require(CoreGui.RobloxGui.Modules.Stats.StatsUtils)
local TreeViewItem = require(CoreGui.RobloxGui.Modules.Stats.TreeViewItem)

local function __GetMemoryPerformanceStatsItem() -- Luacid: Inlined by compiler; 1 call site recovered
    local performanceStats = Stats and Stats:FindFirstChild("PerformanceStats")
    if performanceStats == nil then
        return nil
    end

    return (performanceStats:FindFirstChild(StatsUtils.StatNames[StatsUtils.StatType_Memory]))
end

local function __FillInMemoryUsageTreeRecursive(arg1, arg2)
    local name = arg2.Name
    arg1:setLabelAndValue(StatsUtils.GetMemoryAnalyzerStatName(name), (arg2:GetValue()))

    local children = arg2:GetChildren()

    local var1 = CommonUtil.SortByName(children)

    for _, value in ipairs(var1) do
        local orMakeChildById = arg1:getOrMakeChildById(value.Name)
        __FillInMemoryUsageTreeRecursive(orMakeChildById, value)
    end
end

local module = {}

setmetatable(module, BaseMemoryAnalyzer)
module.__index = module

function module.new(arg1)
    local baseMemoryAnalyzer = BaseMemoryAnalyzer.new(arg1)
    setmetatable(baseMemoryAnalyzer, module)

    baseMemoryAnalyzer._rootTreeViewItem = nil

    baseMemoryAnalyzer._shouldListenForUpdates = false

    baseMemoryAnalyzer._spawnedLoopScheduled = false

    return baseMemoryAnalyzer
end

function module:startListeningForUpdates()
    self._shouldListenForUpdates = true

    if self._spawnedLoopScheduled then
        return
    end
    self._spawnedLoopScheduled = true

    spawn(function()
        while self._shouldListenForUpdates do
            self:refreshMemoryUsageTree()
            self:renderUpdates()
            wait(1)
        end

        self._spawnedLoopScheduled = false
    end)
end

function module:stopListeningForUpdates()
    self._shouldListenForUpdates = false
end

function module:refreshMemoryUsageTree()
    if self._rootTreeViewItem == nil then
        self._rootTreeViewItem = TreeViewItem.new("root", nil)
    end

    local var1 = __GetMemoryPerformanceStatsItem()

    if var1 == nil then
        return nil
    end

    __FillInMemoryUsageTreeRecursive(self._rootTreeViewItem, var1)
end

function module:getMemoryUsageTree()
    return self._rootTreeViewItem
end

return module
