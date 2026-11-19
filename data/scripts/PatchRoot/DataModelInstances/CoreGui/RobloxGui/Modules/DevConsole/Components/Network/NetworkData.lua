-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:40:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local LogService = game:GetService("LogService")
local CircularBuffer = require(script.Parent.Parent.Parent.CircularBuffer)
local Signal = require(script.Parent.Parent.Parent.Signal)

local ChartHeaderNames = require(script.Parent.Parent.Parent.Constants).NetworkFormatting.ChartHeaderNames

local var1 = tonumber(settings():GetFVariable("NewDevConsoleMaxHttpCount"))

local tbl1 = {}
tbl1[ChartHeaderNames[1]] = function(arg1, arg2): boolean
    return arg1.Num < arg2.Num
end

tbl1[ChartHeaderNames[2]] = function(arg1, arg2): boolean
    return arg1.Method < arg2.Method
end

tbl1[ChartHeaderNames[3]] = function(arg1, arg2): boolean
    return arg1.Status < arg2.Status
end

tbl1[ChartHeaderNames[4]] = function(arg1, arg2): boolean
    return arg1.Time < arg2.Time
end

tbl1[ChartHeaderNames[5]] = function(arg1, arg2): boolean
    return arg1.RequestType < arg2.RequestType
end

tbl1[ChartHeaderNames[6]] = function(arg1, arg2): boolean
    return arg1.Url < arg2.Url
end

local function newHttpEntry(num, method, status, time, requestType, url, response) -- Luacid: Inlined by compiler; 1 call site recovered
    return {
        Num = num,
        Method = method,
        Status = status,
        Time = time,
        RequestType = requestType,
        Url = url,
        Response = response
    }
end

local module = {}
module.__index = module

function module.new(_isClient)
    local result = {}
    setmetatable(result, module)

    result._isRunning = false
    result._isClient = _isClient
    result._httpResultSignal = _isClient and LogService.HttpResultOut or LogService.ServerHttpResultOut

    result._httpEntryAdded = Signal.new()
    result._httpSummaryTable = {}
    result._httpSummaryCount = 0
    result._httpEntryBuffer = CircularBuffer.new(var1)

    result._httpLifeTimeEntryCount = 0
    result._sortType = ChartHeaderNames[1]
    return result
end

function module:addHttpEntry(arg1)
    self._httpLifeTimeEntryCount += 1

    local tbl2 = newHttpEntry(
        self._httpLifeTimeEntryCount,
        arg1.Method,
        arg1.Status,
        arg1.Time,
        arg1.RequestType,
        arg1.URL,
        arg1.Response
    )

    self._httpEntryBuffer:push_back(tbl2)

    local requestType = arg1.RequestType
    local var2 = self._httpSummaryTable[requestType]

    if not var2 then
        self._httpSummaryCount += 1

        self._httpSummaryTable[requestType] = {
            RequestType = requestType,
            RequestCount = 1,
            FailedCount = 0,
            AverageTime = arg1.Time,
            MinTime = arg1.Time,
            MaxTime = arg1.Time
        }

        if arg1.Status >= 400 then
            self._httpSummaryTable[arg1.RequestType].FailedCount = 1
        end
    else
        var2.RequestCount += 1
        if arg1.Status >= 400 then
            var2.FailedCount += 1
        end

        var2.AverageTime = (var2.AverageTime * var2.RequestCount + arg1.Time - var2.AverageTime) / var2.RequestCount

        if arg1.Time < var2.MinTime then
            var2.MinTime = arg1.Time
        end
        if arg1.Time > var2.MaxTime then
            var2.MaxTime = arg1.Time
        end
    end
end

function module:setSortType(_sortType)
    if tbl1[_sortType] then
        self._sortType = _sortType
        self._httpEntryAdded:Fire(self._httpSummaryTable, self._httpSummaryCount, self:getSortedEntries())
        return
    end

    error(string.format("attempted to pass invalid sortType: %s", tostring(_sortType)), 2)
end

function module:getSortType()
    return self._sortType
end

function module:resetHttpEntryList()
    self._httpSummaryTable = {}
    self._httpEntryBuffer:reset()
    self._httpLifeTimeEntryCount = 0
    if not self._isClient then
        return
    end

    local httpResultHistory = LogService:GetHttpResultHistory()

    if not httpResultHistory then
        return
    end

    for _, value in pairs(httpResultHistory) do
        self:addHttpEntry(value)
    end
end

function module:Signal()
    return self._httpEntryAdded
end

function module:getSortedEntries()
    local var2 = self._httpEntryBuffer:iterator()
    local var3 = var2:next()
    local sortedEntries = ({})
    local num1 = 1

    while var3 do
        sortedEntries[num1] = var3
        num1 += 1
        var3 = var2:next()
    end

    table.sort(sortedEntries, tbl1[self._sortType])

    return sortedEntries
end

function module:getCurrentData()
    return {
        summaryTable = self._httpSummaryTable,
        summaryCount = self._httpSummaryCount,
        entryList = self:getSortedEntries()
    }
end

function module:isRunning()
    return self._isRunning
end

function module:start()
    if self._httpResultConnection then
        return
    end

    if self._additionHttpSetup then
        self._additionHttpSetup()
    end

    self._httpResultConnection = self._httpResultSignal:connect(function(arg1)
        self:addHttpEntry(arg1)
        self._httpEntryAdded:Fire(self._httpSummaryTable, self._httpSummaryCount, self:getSortedEntries())
    end)

    self:resetHttpEntryList()

    if not self._isClient then
        self._onHttpResultApprovedConnection = LogService.OnHttpResultApproved:connect(function(isApproved: boolean)
            LogService:RequestHttpResultApproved()
            if isApproved then
                self._onHttpResultApprovedConnection:Disconnect()
                self._onHttpResultApprovedConnection = nil
            end
        end)
        LogService:RequestServerHttpResult()
    end
    self._isRunning = true
end

function module:stop()
    if self._httpResultConnection then
        self._httpResultConnection:Disconnect()
        self._httpResultConnection = nil
    end
    self._isRunning = false
end

return module
