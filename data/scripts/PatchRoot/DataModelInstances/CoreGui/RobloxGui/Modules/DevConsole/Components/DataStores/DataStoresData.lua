-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:21:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CircularBuffer = require(script.Parent.Parent.Parent.CircularBuffer)
local Signal = require(script.Parent.Parent.Parent.Signal)

local var1 = tonumber(settings():GetFVariable("NewDevConsoleMaxGraphCount"))

local getClientReplicator = require(script.Parent.Parent.Parent.Util.getClientReplicator)

local module = {}
module.__index = module

function module.new()
    local result = {}
    setmetatable(result, module)

    result._dataStoresUpdated = Signal.new()
    result._dataStoresData = {}
    result._dataStoresDataCount = 0
    result._lastUpdateTime = 0
    result._isRunning = false
    return result
end

function module:Signal()
    return self._dataStoresUpdated
end

function module:getCurrentData()
    return self._dataStoresData, self._dataStoresDataCount
end

function module:updateValue(arg1, arg2)
    if not self._dataStoresData[arg1] then
        local circularBuffer = CircularBuffer.new(var1)
        circularBuffer:push_back({ value = arg2, time = self._lastUpdateTime })

        self._dataStoresData[arg1] = { max = arg2, min = arg2, dataSet = circularBuffer }
        return
    end

    local var2 = self._dataStoresData[arg1]
    local max = var2.max
    local min = var2.min

    local tbl1 = {
        value = arg2,
        time = self._lastUpdateTime
    }
    local var3 = self._dataStoresData[arg1].dataSet:push_back(tbl1)

    if var3 then
        local var4 = self._dataStoresData[arg1].dataSet:iterator()
        local var5 = var4:next()
        if max == var3.value then
            local var6 = min

            while var5 do
                min = var5.value < min and min or var5.value
                var5 = var4:next()
            end

            max = min
            min = var6
        end

        if min == var3.value then
            local var6 = max

            while var5 do
                max = max < var5.value and max or var5.value
                var5 = var4:next()
            end

            min = max
            max = var6
        end
    end

    self._dataStoresData[arg1].max = max < arg2 and arg2 or max
    local var4 = self._dataStoresData[arg1]

    if min < arg2 then
        arg2 = min or arg2
    end

    var4.min = arg2
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
        local dataStoreBudget = arg1.DataStoreBudget
        self._lastUpdateTime = os.time()
        if not dataStoreBudget then
            return
        end

        local num1 = 0
        for k, value in pairs(dataStoreBudget) do
            if type(value) == "number" then
                self:updateValue(k, value)
                num1 += 1
            end
        end
        self._dataStoresDataCount = num1
        self._dataStoresUpdated:Fire(self._dataStoresData, self._dataStoresDataCount)
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
