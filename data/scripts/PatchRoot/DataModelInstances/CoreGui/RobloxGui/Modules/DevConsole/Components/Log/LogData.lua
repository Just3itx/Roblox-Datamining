-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:30:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local LogService = game:GetService("LogService")
local TextService = game:GetService("TextService")

local Constants = require(script.Parent.Parent.Parent.Constants)
local MainWindow = Constants.DefaultFontSize.MainWindow
local Log = Constants.Font.Log
local MaxStringSize = Constants.LogFormatting.MaxStringSize

local EnumToMsgTypeName = Constants.EnumToMsgTypeName

local CircularBuffer = require(script.Parent.Parent.Parent.CircularBuffer)
local Signal = require(script.Parent.Parent.Parent.Signal)

local var1 = tonumber(settings():GetFVariable("NewDevConsoleMaxLogCount"))
local tbl1 = { "ClassDescriptor failed to learn", "EventDescriptor failed to learn", "Type failed to learn" }

local convertTimeStamp = require(script.Parent.Parent.Parent.Util.convertTimeStamp)

local module = {}
module.__index = module

local function messageEntry(str1: string, str2: string, type: number, context)
    local charCount = #str1
    local string2 = if charCount < MaxStringSize then string.format("%s -- %s", str2, str1) else string.format("%s -- %s", str2, string.sub(str1, 1, MaxStringSize))
    local vector2 = TextService:GetTextSize(string2, MainWindow, Log, Vector2.new())

    if context and next(context) == nil then
        context = nil
    end

    return {
        Message = string2,
        CharCount = charCount,
        Type = type,
        Dims = vector2,
        Context = context,
        Expanded = false
    }
end

local function ignoreWarningMessageOnAdd(arg1)
    if arg1.Type ~= Enum.MessageType.MessageWarning.Value then
        return false
    end
    local bool1 = false
    for _, value in ipairs(tbl1) do
        if string.find(arg1.Message, value) ~= nil then
            return true
        end
    end
    return bool1
end

local function isMessageFiltered(arg1, _filters, _searchTerm): boolean
    return not (#_searchTerm == 0 and not next(_filters))
        and not (next(_filters) and not _filters[EnumToMsgTypeName[arg1.Type]])
        and (not (#_searchTerm > 0) or string.find(arg1.Message:lower(), _searchTerm:lower()) ~= nil or false)
end

local function validActiveFilters(_filters) -- Luacid: Inlined by compiler; 3 call sites recovered
    local bool1 = false
    for _, _filter in pairs(_filters) do
        bool1 = bool1 or _filter
    end

    return bool1
end

local function filterMessages(_logDataSearched, arg1, _filters, _searchTerm)
    _logDataSearched:reset()
    local var2 = validActiveFilters(_filters)

    if #_searchTerm == 0 and not var2 then
        return
    end

    local var3 = arg1:next()
    local num1 = 0

    while var3 do
        if isMessageFiltered(var3, _filters, _searchTerm) then
            num1 += 1
            _logDataSearched:push_back(var3)
        end
        var3 = arg1:next()
    end

    if num1 ~= 0 then
        return
    end

    if #_searchTerm > 0 then
        _logDataSearched:push_back((messageEntry(string.format("\"%s\" was not found", _searchTerm), "", 0)))
        return
    end
    _logDataSearched:push_back((messageEntry("No Messages were found", "", 0)))
end

function module:checkErrorWarningCounter(arg1)
    if arg1 == Enum.MessageType.MessageWarning.Value then
        self._warningCount += 1
        self._errorWarningSignal:Fire(self._errorCount, self._warningCount)
    elseif arg1 == Enum.MessageType.MessageError.Value then
        self._errorCount += 1
        self._errorWarningSignal:Fire(self._errorCount, self._warningCount)
    end
end

function module.new(_isClient)
    local result = {}
    setmetatable(result, module)

    result._initialized = false
    result._isRunning = false
    result._isClient = _isClient

    result._logData = CircularBuffer.new(var1)
    result._logDataSearched = CircularBuffer.new(var1)
    result._searchTerm = ""

    result._commandLineHistory = CircularBuffer.new(100)
    result._commandLineIndex = 0

    result._filters = {}
    for _, value in pairs(EnumToMsgTypeName) do
        result._filters[value] = true
    end

    result._errorCount = _isClient and 0
    result._warningCount = _isClient and 0
    result._logDataUpdate = Signal.new()
    result._errorWarningSignal = _isClient and Signal.new()
    result._filterUpdated = Signal.new()

    return result
end

function module:Signal()
    return self._logDataUpdate
end

function module:errorWarningSignal()
    return self._errorWarningSignal
end

function module:filterUpdatedSignal()
    return self._filterUpdated
end

function module:setSearchTerm(_searchTerm)
    if self._searchTerm == _searchTerm then
        return
    end

    self._searchTerm = _searchTerm

    if self._searchTerm == "" then
        self._logDataSearched:reset()
        self._logDataUpdate:Fire(self._logData)
        return
    end
    filterMessages(self._logDataSearched, self._logData:iterator(), self._filters, self._searchTerm)

    self._logDataUpdate:Fire(self._logDataSearched)
end

function module:getSearchTerm()
    return self._searchTerm
end

function module:getCommandLineHistory()
    return self._commandLineHistory
end

function module:getCommandLineIndex()
    return self._commandLineIndex
end

function module:setCommandLineIndex(_commandLineIndex)
    self._commandLineIndex = _commandLineIndex
end

function module:getFilters()
    return self._filters
end

function module:setFilter(arg1, arg2)
    local _filter = self._filters[arg1]
    self._filters[arg1] = arg2

    if not validActiveFilters(self._filters) then
        self._filters[arg1] = _filter
        return
    end

    filterMessages(self._logDataSearched, self._logData:iterator(), self._filters, self._searchTerm)

    self._logDataUpdate:Fire(self._logDataSearched)
    self._filterUpdated:Fire()
end

function module:setFilters(_filters)
    self._filters = _filters

    if not validActiveFilters(_filters) then
        self._logDataSearched:reset()
        self._logDataUpdate:Fire(self._logData)
        return
    end

    filterMessages(self._logDataSearched, self._logData:iterator(), self._filters, self._searchTerm)

    self._logDataUpdate:Fire(self._logDataSearched)
    self._filterUpdated:Fire()
end

function module:getLogData()
    return if #self._logDataSearched:getData() > 0 then self._logDataSearched else self._logData
end

function module:getErrorWarningCount()
    return self._errorCount, self._warningCount
end

function module:isRunning()
    return self._initialized
end

function module:start()
    if self._isClient then
        if not self._initialized then
            self._initialized = true
            if #{} == 0 then
                local logHistory = LogService:GetLogHistory()
                for _, value in ipairs(logHistory) do
                    local tbl2 = messageEntry(
                        value.message or "[DevConsole Error 1]",
                        convertTimeStamp(value.timestamp),
                        value.messageType.Value,
                        value.context
                    )
                    if not ignoreWarningMessageOnAdd(tbl2) then
                        self:checkErrorWarningCounter(value.messageType.Value)
                        self._logData:push_back(tbl2)
                    end
                end
            end
        end

        self._connection = LogService.MessageOut:connect(function(message: string, messageType: Enum.MessageType, context)
            local tbl2 = messageEntry(message or "[DevConsole Error 2]", convertTimeStamp(os.time()), messageType.Value, context)

            if ignoreWarningMessageOnAdd(tbl2) then
                return
            end

            self:checkErrorWarningCounter(messageType.Value)
            self._logData:push_back(tbl2)

            if #self._logDataSearched:getData() > 0 then
                if isMessageFiltered(tbl2, self._filters, self._searchTerm) then
                    self._logDataSearched:push_back(tbl2)
                    self._logDataUpdate:Fire(self._logDataSearched)
                end
            else
                self._logDataUpdate:Fire(self._logData)
            end
        end)
    else
        self._connection = LogService.ServerMessageOut:connect(function(message: string, messageType: Enum.MessageType, timestamp: number, arg1)
            local tbl2 = messageEntry(message or "[DevConsole Error 3]", convertTimeStamp(timestamp), messageType.Value, arg1)

            if ignoreWarningMessageOnAdd(tbl2) then
                return
            end

            self._logData:push_back(tbl2)

            if #self._logDataSearched:getData() > 0 then
                if isMessageFiltered(tbl2, self._filters, self._searchTerm) then
                    self._logDataSearched:push_back(tbl2)
                    self._logDataUpdate:Fire(self._logDataSearched)
                end
            else
                self._logDataUpdate:Fire(self._logData)
            end
        end)

        pcall(function()
            self._variantConnection = LogService.ServerContextOut:connect(function(contextData)
                if type(contextData) ~= "table" or not contextData._structuredContext then
                    return
                end

                local _message = contextData._message or ""
                local _messageType = contextData._messageType or 0
                local _timestamp = contextData._timestamp or 0
                local _structuredContext = contextData._structuredContext

                local tbl2 = messageEntry(_message, convertTimeStamp(_timestamp), _messageType, _structuredContext)

                if ignoreWarningMessageOnAdd(tbl2) then
                    return
                end

                self._logData:push_back(tbl2)

                if #self._logDataSearched:getData() > 0 then
                    if isMessageFiltered(tbl2, self._filters, self._searchTerm) then
                        self._logDataSearched:push_back(tbl2)
                        self._logDataUpdate:Fire(self._logDataSearched)
                    end
                else
                    self._logDataUpdate:Fire(self._logData)
                end
            end)
        end)

        LogService:RequestServerOutput()
    end

    self._isRunning = true
end

function module:stop()
    self._initialized = false
    self._isRunning = false

    if self._connection then
        self._connection:Disconnect()
    end
    if self._variantConnection then
        self._variantConnection:Disconnect()
    end
end

return module
