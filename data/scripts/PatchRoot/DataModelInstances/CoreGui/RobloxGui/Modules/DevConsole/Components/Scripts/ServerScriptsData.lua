-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:41:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CircularBuffer = require(script.Parent.Parent.Parent.CircularBuffer)
local Signal = require(script.Parent.Parent.Parent.Signal)

local Constants = require(script.Parent.Parent.Parent.Constants)
local var1 = tonumber(settings():GetFVariable("NewDevConsoleMaxGraphCount"))

local ChartHeaderNames = Constants.ServerScriptsFormatting.ChartHeaderNames

local tbl1 = {}
tbl1[ChartHeaderNames[1]] = function(arg1, arg2): boolean
    return arg1.dataStats.dataSet:back().name < arg2.dataStats.dataSet:back().name
end

tbl1[ChartHeaderNames[2]] = function(arg1, arg2): boolean
    return arg1.dataStats.dataSet:back().data[1] < arg2.dataStats.dataSet:back().data[1]
end

tbl1[ChartHeaderNames[3]] = function(arg1, arg2): boolean
    return arg1.dataStats.dataSet:back().data[2] < arg2.dataStats.dataSet:back().data[2]
end

local minOfTable = require(script.Parent.Parent.Parent.Util.minOfTable)
local maxOfTable = require(script.Parent.Parent.Parent.Util.maxOfTable)
local getClientReplicator = require(script.Parent.Parent.Parent.Util.getClientReplicator)

local module = {}
module.__index = module

function module.new()
    local result = {}
    setmetatable(result, module)

    result._serverScriptsUpdated = Signal.new()
    result._serverScriptsData = {}
    result._lastUpdate = 0
    result._sortedScriptsData = {}
    result._sortType = ChartHeaderNames[1]
    result._isRunning = false

    return result
end

function module:setSortType(_sortType)
    if tbl1[_sortType] then
        self._sortType = _sortType

        table.sort(self._sortedScriptsData, tbl1[self._sortType])
        return
    end
    error(string.format("attempted to pass invalid sortType: %s", tostring(_sortType)), 2)
end

function module:getSortType()
    return self._sortType
end

function module:Signal()
    return self._serverScriptsUpdated
end

function module:getCurrentData()
    return self._sortedScriptsData
end

function module:updateScriptsData(arg1)
    self._lastUpdate = os.time()
    for name, value in pairs(arg1) do
        if not self._serverScriptsData[name] then
            local circularBuffer = CircularBuffer.new(var1)
            local tbl2 = {
                data = value,
                time = self._lastUpdate
            }
            circularBuffer:push_back(tbl2)

            self._serverScriptsData[name] = { max = value, min = value, dataSet = circularBuffer }

            table.insert(self._sortedScriptsData, { name = name, dataStats = self._serverScriptsData[name] })
        else
            local tbl2 = ({})
            for k2, value2 in pairs(self._serverScriptsData[name].max) do
                tbl2[k2] = value2
            end

            local tbl3 = ({})
            for k2, value2 in pairs(self._serverScriptsData[name].min) do
                tbl3[k2] = value2
            end

            local tbl4 = {
                data = value,
                time = self._lastUpdate
            }

            local var2 = self._serverScriptsData[name].dataSet:push_back(tbl4)

            if var2 then
                for k2, value2 in pairs(var2.data) do
                    if tbl2[k2] ~= value2 then
                        continue
                    end

                    local var3 = self._serverScriptsData[name].dataSet:iterator()
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

                    local var3 = self._serverScriptsData[name].dataSet:iterator()
                    local var4 = var3:next()
                    tbl3[k2] = tbl2[k2]

                    while var4 do
                        tbl3[k2] = tbl3[k2] < var4.data[k2] and tbl3[k2] or var4.data[k2]
                        var4 = var3:next()
                    end
                end
            end

            self._serverScriptsData[name].max = maxOfTable(tbl2, value)
            self._serverScriptsData[name].min = minOfTable(tbl3, value)
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
        if not arg1 then
            return
        end

        self._lastUpdate = os.time()

        local scripts = arg1.Scripts
        if scripts then
            self:updateScriptsData(scripts)
        end

        self._serverScriptsUpdated:Fire(self._sortedScriptsData)
    end)

    clientReplicator:RequestServerStats(true)
    self._isRunning = true
end

function module:stop()
    if self._statsListenerConnection then
        self._statsListenerConnection:Disconnect()
        self._statsListenerConnection = nil
    end
    self._isRunning = false
end

return module
