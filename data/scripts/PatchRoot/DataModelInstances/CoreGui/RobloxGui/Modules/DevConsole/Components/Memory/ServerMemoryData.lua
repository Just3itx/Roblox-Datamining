-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:31:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Signal = require(script.Parent.Parent.Parent.Signal)
local CircularBuffer = require(script.Parent.Parent.Parent.CircularBuffer)
local ChartHeaderNames = require(script.Parent.Parent.Parent.Constants).MemoryFormatting.ChartHeaderNames

local var1 = tonumber(settings():GetFVariable("NewDevConsoleMaxGraphCount"))

local tbl1 = {}
tbl1[ChartHeaderNames[1]] = function(arg1, arg2): boolean
    return arg1.name < arg2.name
end

tbl1[ChartHeaderNames[2]] = function(arg1, arg2): boolean
    return arg1.dataStats.dataSet:back().data < arg2.dataStats.dataSet:back().data
end

local getClientReplicator = require(script.Parent.Parent.Parent.Util.getClientReplicator)

local module = {}
module.__index = module

function module.new()
    local result = {}

    setmetatable(result, module)
    result._init = false
    result._isRunning = false
    result._totalMemory = 0

    result._memoryData = {}
    result._memoryDataSorted = {}

    result._coreTreeData = {}
    result._coreTreeDataSorted = {}

    result._placeTreeData = {}
    result._placeTreeDataSorted = {}

    result._placeScriptTreeData = {}
    result._placeScriptTreeDataSorted = {}

    result._coreScriptTreeData = {}
    result._coreScriptTreeDataSorted = {}

    result._treeViewUpdated = Signal.new()
    result._sortType = ChartHeaderNames[1]

    return result
end

function module:updateEntry(arg1, tbl2: {any}, name, arg3)
    if not arg1[name] then
        local circularBuffer = CircularBuffer.new(var1)

        circularBuffer:push_back({ data = arg3, time = self._lastUpdate })

        arg1[name] = { min = arg3, max = arg3, dataSet = circularBuffer }

        table.insert(tbl2, { name = name, dataStats = arg1[name] })
        return
    end
    local max = arg1[name].max
    local min = arg1[name].min

    local tbl3 = {
        data = arg3,
        time = self._lastUpdate
    }

    local var2 = arg1[name].dataSet:push_back(tbl3)

    if var2 then
        local var3 = arg1[name].dataSet:iterator()
        local var4 = var3:next()
        if max == var2.data then
            local var5 = min

            while var4 do
                min = var4.data < min and min or var4.data
                var4 = var3:next()
            end

            max = min
            min = var5
        end

        if min == var2.data then
            local var5 = max

            while var4 do
                max = max < var4.data and max or var4.data
                var4 = var3:next()
            end

            min = max
            max = var5
        end
    end

    arg1[name].max = max < arg3 and arg3 or max
    local var3 = arg1[name]

    if min < arg3 then
        arg3 = min or arg3
    end

    var3.min = arg3
end

function module:updateEntryList(arg1, tbl2: {any}, arg2)
    local num1 = 0
    for k, value in pairs(arg2) do
        local var2 = value / 1048576
        num1 += var2

        self:updateEntry(arg1, tbl2, k, var2)
    end

    for k, _ in pairs(arg1) do
        if arg2[k] ~= nil then
            continue
        end

        arg1[k] = nil

        for i, value in ipairs(tbl2) do
            if k == value.name then
                table.remove(tbl2, i)
                break
            end
        end
    end

    return num1
end

function module:updateWithTreeStats(arg1)
    local tbl2 = {
        PlaceMemory = 0,
        CoreMemory = 0,
        UntrackedMemory = 0,
        PlaceScriptMemory = 0,
        CoreScriptMemory = 0
    }

    for k, value in pairs(arg1) do
        if k == "totalServerMemory" then
            self._totalMemory = value / 1048576
        elseif k == "developerTags" then
            tbl2.PlaceMemory = self:updateEntryList(self._placeTreeData, self._placeTreeDataSorted, value)
        elseif k == "internalCategories" then
            tbl2.CoreMemory = self:updateEntryList(self._coreTreeData, self._coreTreeDataSorted, value)
        elseif k == "placeScriptMemoryCategories" then
            tbl2.PlaceScriptMemory = self:updateEntryList(self._placeScriptTreeData, self._placeScriptTreeDataSorted, value)
        elseif k == "coreScriptMemoryCategories" then
            tbl2.CoreScriptMemory = self:updateEntryList(self._coreScriptTreeData, self._coreScriptTreeDataSorted, value)
        end
    end

    tbl2.UntrackedMemory = self._totalMemory - tbl2.PlaceMemory - tbl2.CoreMemory

    if self._init then
        for k, value in pairs(tbl2) do
            self:updateEntry(self._memoryData.Memory.children, self._memoryData.Memory.sortedChildren, k, value)
        end

        self:updateEntry(self._memoryData, self._memoryDataSorted, "Memory", self._totalMemory)
        return
    end
    local children = {}
    local sortedChildren = {}

    for k, value in pairs(tbl2) do
        self:updateEntry(children, sortedChildren, k, value)
    end

    self:updateEntry(self._memoryData, self._memoryDataSorted, "Memory", self._totalMemory)

    children.PlaceMemory.children = self._placeTreeData
    children.PlaceMemory.sortedChildren = self._placeTreeDataSorted

    children.CoreMemory.children = self._coreTreeData
    children.CoreMemory.sortedChildren = self._coreTreeDataSorted

    children.PlaceScriptMemory.children = self._placeScriptTreeData
    children.PlaceScriptMemory.sortedChildren = self._placeScriptTreeDataSorted

    children.CoreScriptMemory.children = self._coreScriptTreeData
    children.CoreScriptMemory.sortedChildren = self._coreScriptTreeDataSorted

    self._memoryData.Memory.children = children
    self._memoryData.Memory.sortedChildren = sortedChildren

    self._init = true
end

function module.totalMemSignal(arg1)
    return arg1._totalMemoryUpdated
end

function module:treeUpdatedSignal()
    return self._treeViewUpdated
end

function module:getSortType()
    return self._sortType
end

local function recursiveSort<T>(tbl2: {T}, func1: ((T, T) -> boolean)?)
    table.sort(tbl2, func1)
    for _, value in pairs(tbl2) do
        if value.dataStats.sortedChildren then
            recursiveSort(value.dataStats.sortedChildren, func1)
        end
    end
end

function module:setSortType(_sortType)
    if tbl1[_sortType] then
        self._sortType = _sortType
        recursiveSort(self._memoryDataSorted, tbl1[self._sortType])
        return
    end
    error(string.format("attempted to pass invalid sortType: %s", tostring(_sortType)), 2)
end

function module:getMemoryData()
    return self._memoryDataSorted
end

function module:isRunning()
    return self._isRunning
end

function module:start()
    local clientReplicator = getClientReplicator()
    if not clientReplicator or self._statsListenerConnection then
        return
    end

    self._statsListenerConnection = clientReplicator.StatsReceived:connect(function(arg1)
        if not arg1.ServerMemoryTree then
            return
        end
        self._lastUpdate = os.time()

        local serverMemoryTree = arg1.ServerMemoryTree
        if serverMemoryTree then
            self:updateWithTreeStats(serverMemoryTree)
            self._treeViewUpdated:Fire(self._memoryDataSorted)
        end
    end)

    clientReplicator:RequestServerStats(true)
    self._isRunning = true
end

function module:stop()
    local clientReplicator = getClientReplicator()
    if clientReplicator then
        clientReplicator:RequestServerStats(false)
        self._statsListenerConnection:Disconnect()
        self._isRunning = false
    end
end

return module
