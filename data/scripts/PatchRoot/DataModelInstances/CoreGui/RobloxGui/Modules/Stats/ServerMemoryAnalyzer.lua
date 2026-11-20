-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:41:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")

local BaseMemoryAnalyzer = require(CoreGui.RobloxGui.Modules.Stats.BaseMemoryAnalyzer)
local TreeViewItem = require(CoreGui.RobloxGui.Modules.Stats.TreeViewItem)
local _CommonUtil = require(CoreGui.RobloxGui.Modules.Common.CommonUtil)

local function __ReadAndSumValues(arg1, arg2)
    local num1 = 0

    for k, value in pairs(arg2) do
        local var1 = value / 1048576
        num1 += var1
        arg1:getOrMakeChildById(k):setLabelAndValue(k, var1)
    end
    return num1
end

local module = {}

setmetatable(module, BaseMemoryAnalyzer)
module.__index = module

function module.new(arg1)
    local baseMemoryAnalyzer = BaseMemoryAnalyzer.new(arg1)
    setmetatable(baseMemoryAnalyzer, module)

    baseMemoryAnalyzer._cachedRootTreeViewItem = nil
    baseMemoryAnalyzer._coreTreeViewItem = nil
    baseMemoryAnalyzer._placeTreeViewItem = nil
    baseMemoryAnalyzer._untrackedTreeViewItem = nil

    baseMemoryAnalyzer._isVisible = false

    return baseMemoryAnalyzer
end

function module.filterServerMemoryTreeStats(_, arg1)
    return if arg1.ServerMemoryTree == nil then {} else arg1.ServerMemoryTree
end

function module:updateWithTreeStats(arg1)
    local num1 = 0

    if self._cachedRootTreeViewItem == nil then
        self._cachedRootTreeViewItem = TreeViewItem.new("root", nil)

        self._coreTreeViewItem = self._cachedRootTreeViewItem:getOrMakeChildById("CoreMemory")
        self._placeTreeViewItem = self._cachedRootTreeViewItem:getOrMakeChildById("PlaceMemory")
        self._untrackedTreeViewItem = self._cachedRootTreeViewItem:getOrMakeChildById("UntrackedMemory")
    end

    for k, value in pairs(arg1) do
        if k == "totalServerMemory" then
            num1 = value / 1048576
        elseif k == "developerTags" then
            local var1 = __ReadAndSumValues(self._placeTreeViewItem, value)
            self._placeTreeViewItem:setLabelAndValue("PlaceMemory", var1)
        elseif k == "internalCategories" then
            local var1 = __ReadAndSumValues(self._coreTreeViewItem, value)
            self._coreTreeViewItem:setLabelAndValue("CoreMemory", var1)
        end
    end

    self._cachedRootTreeViewItem:setLabelAndValue("Memory", num1)

    local var1 = num1 - (self._coreTreeViewItem:getValue() + self._placeTreeViewItem:getValue())
    self._untrackedTreeViewItem:setLabelAndValue("UntrackedMemory", var1)

    self:renderUpdates()
end

function module:getMemoryUsageTree()
    return self._cachedRootTreeViewItem
end

function module:setVisible(_isVisible)
    self._isVisible = _isVisible
    if self._isVisible then
        self:renderUpdates()
    end
end

return module
