-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:41:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CircularBuffer = require(script.Parent.Parent.Parent.CircularBuffer)
local Signal = require(script.Parent.Parent.Parent.Signal)

local ChartHeaderNames = require(script.Parent.Parent.Parent.Constants).ServerJobsFormatting.ChartHeaderNames

local var1 = tonumber(settings():GetFVariable("NewDevConsoleMaxGraphCount"))

local tbl1 = {}
tbl1[ChartHeaderNames[1]] = function(arg1, arg2): boolean
    return arg1.name < arg2.name
end

tbl1[ChartHeaderNames[2]] = function(arg1, arg2): boolean
    return arg1.dataStats.dataSet:back().data[1] < arg2.dataStats.dataSet:back().data[1]
end

tbl1[ChartHeaderNames[3]] = function(arg1, arg2): boolean
    return arg1.dataStats.dataSet:back().data[2] < arg2.dataStats.dataSet:back().data[2]
end

tbl1[ChartHeaderNames[4]] = function(arg1, arg2): boolean
    return arg1.dataStats.dataSet:back().data[3] < arg2.dataStats.dataSet:back().data[3]
end

local minOfTable = require(script.Parent.Parent.Parent.Util.minOfTable)
local maxOfTable = require(script.Parent.Parent.Parent.Util.maxOfTable)
local getClientReplicator = require(script.Parent.Parent.Parent.Util.getClientReplicator)

local module = {}
module.__index = module

function module.new()
    local result = {}
    setmetatable(result, module)

    result._serverJobsUpdated = Signal.new()
    result._serverJobsData = {}
    result._sortedJobsData = {}
    result._sortType = ChartHeaderNames[1]
    result._lastUpdate = 0
    result._isRunning = false

    return result
end

function module:setSortType(_sortType)
    if tbl1[_sortType] then
        self._sortType = _sortType

        table.sort(self._sortedJobsData, tbl1[self._sortType])
        return
    end
    error(string.format("attempted to pass invalid sortType: %s", tostring(_sortType)), 2)
end

function module:getSortType()
    return self._sortType
end

function module:Signal()
    return self._serverJobsUpdated
end

function module:getCurrentData()
    return self._sortedJobsData
end

function module:updateServerJobsData(arg1)
    self._lastUpdate = os.time()
    for name, value in pairs(arg1) do
        if not self._serverJobsData[name] then
            local circularBuffer = CircularBuffer.new(var1)
            local tbl2 = {
                data = value,
                time = self._lastUpdate
            }
            circularBuffer:push_back(tbl2)

            self._serverJobsData[name] = { max = value, min = value, dataSet = circularBuffer }

            table.insert(self._sortedJobsData, { name = name, dataStats = self._serverJobsData[name] })
        else
            local tbl2 = ({})
            for k2, value2 in pairs(self._serverJobsData[name].max) do
                tbl2[k2] = value2
            end

            local tbl3 = ({})
            for k2, value2 in pairs(self._serverJobsData[name].min) do
                tbl3[k2] = value2
            end

            local tbl4 = {
                data = value,
                time = self._lastUpdate
            }

            local var2 = self._serverJobsData[name].dataSet:push_back(tbl4)

            if var2 then
                for k2, value2 in pairs(var2.data) do
                    if tbl2[k2] ~= value2 then
                        continue
                    end

                    local var3 = self._serverJobsData[name].dataSet:iterator()
                    local var4 = var3:next()
                    tbl2[k2] = tbl3[k2]

                    while var4 do
                        tbl2[k2] = var4.data[k2] < tbl2[k2] and tbl2[k2] or var4.data[k2]
                        var4 = var3:next()
                    end
                end

                for k2, value2 in pairs(var2.data) do
                    if tbl3[k2] ~= value2 then
                        continue
                    end

                    local var3 = self._serverJobsData[name].dataSet:iterator()
                    local var4 = var3:next()
                    tbl3[k2] = tbl2[k2]

                    while var4 do
                        tbl3[k2] = tbl3[k2] < var4.data[k2] and tbl3[k2] or var4.data[k2]
                        var4 = var3:next()
                    end
                end
            end

            self._serverJobsData[name].max = maxOfTable(tbl2, value)
            self._serverJobsData[name].min = minOfTable(tbl3, value)
        end
    end
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
        local jobs = arg1.Jobs

        if jobs then
            self:updateServerJobsData(jobs)
            self._serverJobsUpdated:Fire(self._sortedJobsData)
        end
    end)
    clientReplicator:RequestServerStats(true)
    self._isRunning = true
end

function module:stop()
    if self._statsListenerConnection then
        self._statsListenerConnection:Disconnect()
        self._statsListenerConnection = nil
        self._isRunning = false
    end
end

return module
