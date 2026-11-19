-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T12:10:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ErrorReportersParent = script:FindFirstAncestor("ErrorReporters").Parent
local RunService = game:GetService("RunService")

local Cryo = require(ErrorReportersParent.Cryo)
local t = require(ErrorReportersParent.t)

local BacktraceReport = require(script.Parent.BacktraceReport)
local ErrorQueue = require(script.Parent.Parent.ErrorQueue)
local FFlagLuaAppEnableBacktraceSessionInfo = require(script.Parent.Flags.FFlagLuaAppEnableBacktraceSessionInfo)

local isStudio = RunService:IsStudio()

local FIntOldestUAVersionToReportErrors = require(script.Parent.Parent.FIntOldestUAVersionToReportErrors)

local module = {}
module.__index = module

local var1 = t.strictInterface({
    httpService = t.some(
        t.instanceOf("HttpService"),
        t.interface({ JSONEncode = t.callback, JSONDecode = t.callback, RequestInternal = t.callback })
    ),
    token = t.string,
    processErrorReportMethod = t.optional(t.callback),
    queueOptions = t.optional(t.table),
    generateLogMethod = t.optional(t.callback),
    logIntervalInSeconds = t.optional(t.numberPositive)
})

function module.new(arg1)
    local var2, var3 = var1(arg1)
    local var4 = nil

    if var2 then
        var4 = {
            _isEnabled = true,
            _httpService = arg1.httpService,
            _errorQueue = nil,
            _reportUrl = game:GetFastString("ErrorUploadToBacktraceBaseUrl") .. "token=" .. arg1.token,
            _processErrorReportMethod = arg1.processErrorReportMethod,
            _sharedAttributes = {},
            _sharedAnnotations = {},
            _generateLogMethod = arg1.generateLogMethod,
            _logIntervalInSeconds = arg1.logIntervalInSeconds or 60,
            _lastLogTime = 0
        }
    elseif isStudio or _G.__DEV__ then
        error("invalid arguments for BacktraceReporter: " .. var3)
    else
        var4 = { _isEnabled = false }
    end

    setmetatable(var4, module)

    if var4._isEnabled then
        local errorQueue = ErrorQueue.new(function(...)
            var4:_reportErrorFromErrorQueue(...)
        end, arg1.queueOptions)

        var4._errorQueue = errorQueue

        var4._errorQueue:startTimer()
    end

    return var4
end

function module:isTooOldToReportErrors(): boolean
    local robloxVersion = RunService:GetRobloxVersion()
    local var2 = tonumber(string.match(robloxVersion, ".(%d+)."))
    return if var2 then var2 < FIntOldestUAVersionToReportErrors else false
end

function module:sendErrorReport(arg1, arg2)
    if not self._isEnabled or self:isTooOldToReportErrors() then
        return
    end

    if isStudio or _G.__DEV__ then
        assert(arg1:validate())
    end

    local success, result = pcall(function()
        return self._httpService:JSONEncode(arg1)
    end)

    if not success then
        warn("Cannot convert report to Json")
        return
    end

    pcall(function()
        self._httpService:RequestInternal({
            Url = self._reportUrl .. "&format=json",
            Method = "POST",
            Headers = { ["Content-Type"] = "application/json" },
            Body = result
        }):Start(
            function(_, arg3)
                if arg3.StatusCode ~= 200 or arg2 == nil then
                    return
                end

                local success2, result2 = pcall(function()
                    return self._httpService:JSONDecode(arg3.Body)
                end)

                if success2 and result2._rxid ~= nil then
                    self:_sendLogToReport(result2._rxid, arg2)
                end
            end
        )
    end)
end

function module:_sendLogToReport(arg1, body)
    if type(body) ~= "string" or #body == 0 then
        return
    end

    pcall(function()
        self._httpService:RequestInternal({
            Url = self._reportUrl .. "&object=" .. arg1 .. "&attachment_name=log.txt",
            Method = "POST",
            Headers = { ["Content-Type"] = "text/plain" },
            Body = body
        }):Start(
            function(_, _) end
        )
    end)
end

function module:_generateLog()
    if self._generateLogMethod ~= nil and tick() - self._lastLogTime > self._logIntervalInSeconds then
        self._lastLogTime = tick()

        local success, result = pcall(function()
            return self._generateLogMethod()
        end)

        if success and type(result) == "string" and #result > 0 then
            return result
        end
    end

    return nil
end

function module:_generateErrorReport(arg1, arg2, stackDetails, arg3)
    local var2 = if type(stackDetails) == "table" then BacktraceReport.fromDetails(stackDetails) else BacktraceReport.fromMessageAndStack(arg1, arg2)

    if FFlagLuaAppEnableBacktraceSessionInfo and arg3 ~= nil then
        var2:addAttributes(arg3)
    end

    var2:addAttributes(self._sharedAttributes)
    var2:addAnnotations(self._sharedAnnotations)

    if type(stackDetails) == "string" and stackDetails ~= "" then
        var2:addAnnotations({ stackDetails = stackDetails })
    end

    return var2
end

function module:reportErrorImmediately(arg1, arg2, arg3, arg4)
    if not self._isEnabled then
        return
    end

    local var2 = self:_generateErrorReport(arg1, arg2, arg3, arg4)

    if self._processErrorReportMethod ~= nil then
        var2 = self._processErrorReportMethod(var2)
    end

    self:sendErrorReport(var2, (self:_generateLog()))
end

function module:reportErrorDeferred(arg1, arg2, arg3, arg4)
    if not self._isEnabled then
        return
    end

    local str1 = string.format("%s | %s", arg1, arg2)
    local tbl1

    if self._errorQueue:hasError(str1) then
        tbl1 = {}
    else
        local var2 = self:_generateErrorReport(arg1, arg2, arg3, arg4)

        if self._processErrorReportMethod ~= nil then
            var2 = self._processErrorReportMethod(var2)
        end

        tbl1 = {
            backtraceReport = var2,
            log = self:_generateLog()
        }
    end

    self._errorQueue:addError(str1, tbl1)
end

function module._reportErrorFromErrorQueue(arg1, _, arg2, errorCount)
    local backtraceReport = arg2.backtraceReport
    local log = arg2.log

    backtraceReport:addAttributes({ ErrorCount = errorCount })

    arg1:sendErrorReport(backtraceReport, log)
end

local IAttributes = BacktraceReport.IAttributes

function module:updateSharedAttributes(arg1)
    local _sharedAttributes = Cryo.Dictionary.join(self._sharedAttributes, arg1)

    local var3, var4 = IAttributes(_sharedAttributes)
    if not var3 then
        if not (isStudio or _G.__DEV__) then
            return
        end

        assert(var3, var4)
    end

    self._sharedAttributes = _sharedAttributes
end

local IAnnotations = BacktraceReport.IAnnotations

function module:updateSharedAnnotations(arg1)
    local _sharedAnnotations = Cryo.Dictionary.join(self._sharedAnnotations, arg1)

    local var3, var4 = IAnnotations(_sharedAnnotations)
    if not var3 then
        if not (isStudio or _G.__DEV__) then
            return
        end

        assert(var3, var4)
    end

    self._sharedAnnotations = _sharedAnnotations
end

function module:reportAllErrors()
    if self._errorQueue ~= nil then
        self._errorQueue:reportAllErrors()
    end
end

function module:stop()
    self._isEnabled = false

    if self._errorQueue ~= nil then
        self:reportAllErrors()
        self._errorQueue:stopTimer()
    end
end

return module
