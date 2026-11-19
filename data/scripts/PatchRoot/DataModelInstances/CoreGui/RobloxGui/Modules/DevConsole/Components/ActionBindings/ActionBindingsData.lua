-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:20:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ContextActionService = game:GetService("ContextActionService")
local Signal = require(script.Parent.Parent.Parent.Signal)

local ChartHeaderNames = require(script.Parent.Parent.Parent.Constants).ActionBindingsFormatting.ChartHeaderNames

local tbl1 = {}
tbl1[ChartHeaderNames[1]] = function(arg1, arg2): boolean
    return arg1.counter < arg2.counter
end

tbl1[ChartHeaderNames[2]] = function(arg1, arg2): boolean
    if arg1.actionInfo.priorityLevel == arg2.actionInfo.priorityLevel then
        return arg1.counter < arg2.counter
    end

    return arg1.actionInfo.priorityLevel < arg2.actionInfo.priorityLevel
end

tbl1[ChartHeaderNames[3]] = function(arg1, arg2)
    if arg1.actionInfo.isCore == arg2.actionInfo.isCore then
        return arg1.counter < arg2.counter
    end

    return arg1.actionInfo.isCore
end

tbl1[ChartHeaderNames[4]] = function(arg1, arg2): boolean
    return arg1.name:lower() < arg2.name:lower()
end

tbl1[ChartHeaderNames[5]] = function(arg1, arg2): boolean
    return tostring(arg1.actionInfo.inputTypes[1]) < tostring(arg2.actionInfo.inputTypes[1])
end

local module = {}
module.__index = module

function module.new()
    local result = {}
    setmetatable(result, module)

    result._bindingsUpdated = Signal.new()
    result._bindingsData = {}
    result._bindingCounter = 0
    result._sortedBindingData = {}
    result._sortType = ChartHeaderNames[1]
    result._isRunning = false
    return result
end

function module:setSortType(_sortType)
    if tbl1[_sortType] then
        self._sortType = _sortType
        table.sort(self._sortedBindingData, tbl1[self._sortType])
        self._bindingsUpdated:Fire(self._sortedBindingData)
        return
    end
    error(string.format("attempted to pass invalid sortType: %s", tostring(_sortType)), 2)
end

function module:getSortType()
    return self._sortType
end

function module:Signal()
    return self._bindingsUpdated
end

function module:getCurrentData()
    return self._sortedBindingData
end

function module:updateBindingDataEntry(name, arg1)
    if arg1 == nil then
        self._bindingsData[name] = nil
        for k, value in pairs(self._sortedBindingData) do
            if value.name == name then
                table.remove(self._sortedBindingData, k)
                return
            end
        end

        return
    end

    if self._bindingsData[name] then
        self._bindingsData[name] = arg1
        return
    end

    self._bindingCounter += 1
    self._bindingsData[name] = arg1
    local tbl2 = {
        name = name,
        actionInfo = self._bindingsData[name],
        counter = self._bindingCounter
    }
    table.insert(self._sortedBindingData, tbl2)
end

function module:isRunning()
    return self._isRunning
end

function module:start()
    local allBoundActionInfo = ContextActionService:GetAllBoundActionInfo()
    for k, value in pairs(allBoundActionInfo) do
        value.isCore = false
        self:updateBindingDataEntry(k, value)
    end

    local allBoundCoreActionInfo = ContextActionService:GetAllBoundCoreActionInfo()
    for k, value in pairs(allBoundCoreActionInfo) do
        value.isCore = true
        self:updateBindingDataEntry(k, value)
    end

    if not self._actionChangedConnection then
        self._actionChangedConnection = ContextActionService.BoundActionChanged:connect(function(actionChanged: string, changeName: string, changeTable)
            self:updateBindingDataEntry(actionChanged, nil)
            self:updateBindingDataEntry(changeName, changeTable)
            self._bindingsUpdated:Fire(self._sortedBindingData)
        end)
    end

    if not self._actionAddedConnection then
        self._actionAddedConnection = ContextActionService.BoundActionAdded:connect(function(actionAdded: string, _: boolean, functionInfoTable, isCore: boolean)
            functionInfoTable.isCore = isCore
            self:updateBindingDataEntry(actionAdded, functionInfoTable)
            self._bindingsUpdated:Fire(self._sortedBindingData)
        end)
    end

    if not self._actionRemovedConnection then
        self._actionRemovedConnection = ContextActionService.BoundActionRemoved:connect(function(actionRemoved: string, _, _: boolean)
            self:updateBindingDataEntry(actionRemoved, nil)
            self._bindingsUpdated:Fire(self._sortedBindingData)
        end)
    end
    self._isRunning = true
end

function module:stop()
    if self.actionChangedConnector then
        self.actionChangedConnector:Disconnect()
        self.actionChangedConnector = nil
    end
    if self.actionAddedConnector then
        self.actionAddedConnector:Disconnect()
        self.actionAddedConnector = nil
    end
    if self.actionRemovedConnector then
        self.actionRemovedConnector:Disconnect()
        self.actionRemovedConnector = nil
    end
    self._isRunning = false
end

return module
