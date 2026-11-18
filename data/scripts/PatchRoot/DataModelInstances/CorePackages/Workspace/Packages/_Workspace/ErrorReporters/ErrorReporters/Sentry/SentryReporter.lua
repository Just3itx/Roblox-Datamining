-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-18T23:31:30Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local ErrorReportersParent = script:FindFirstAncestor("ErrorReporters").Parent
local Client = require(ErrorReportersParent.SentrySdk).Client
local RunService = game:GetService("RunService")

local Cryo = require(ErrorReportersParent.Cryo)
local t = require(ErrorReportersParent.t)

local ErrorQueue = require(script.Parent.Parent.ErrorQueue)
local FIntOldestUAVersionToReportErrors = require(script.Parent.Parent.FIntOldestUAVersionToReportErrors)

local FIntSentryErrorLevelQueueTimeLimitSeconds = require(script.Parent.Parent.FIntSentryErrorLevelQueueTimeLimitSeconds)

local FIntSentryDebugLevelQueueTimeLimitSeconds = require(script.Parent.Parent.FIntSentryDebugLevelQueueTimeLimitSeconds)
local FFlagSentrySplitQueuesBySeverity = require(script.Parent.Parent.FFlagSentrySplitQueuesBySeverity)
local ErrorReport = require(script.Parent.ErrorReport)
local SentryReporterUtility = require(script.Parent.SentryReporterUtility)
local Constants = require(script.Parent.Constants)
local FFlagLuaAppSentryStampOccurrenceTime = require(script.Parent.Flags.FFlagLuaAppSentryStampOccurrenceTime)

local IAttributes = ErrorReport.IAttributes
local IAnnotations = ErrorReport.IAnnotations

local isDevelopmentMode = require(script.Parent.isDevelopmentMode)

local bool1 = game:DefineFastFlag("SentryReportBreadcrumbs", false)

local function latestBreadcrumbs(breadcrumbs) -- Luacid: Inlined by compiler; 1 call site recovered
    local breadcrumbsLen = #breadcrumbs
    if breadcrumbsLen <= 100 then
        return breadcrumbs
    end

    local result = {}
    for i = breadcrumbsLen - 100 + 1, breadcrumbsLen do
        table.insert(result, breadcrumbs[i])
    end
    return result
end

local function truncateLog(str1: string): (string, boolean) -- Luacid: Inlined by compiler; 1 call site recovered
    local num1 = string.len(str1)

    if num1 <= 20971520 then
        return str1, false
    end

    local str2 = string.format("[LOG TRUNCATED - Original size: %.2f MB, kept latest %.2f MB]\n\n", num1 / 1048576, 20)

    return str2 .. string.sub(str1, num1 - (20971520 - string.len(str2)) + 1), true
end

local module = {}
module.__index = module

local function createSentryClient(dsn: string, environment: string?, release: string?, httpService) -- Luacid: Inlined by compiler; 1 call site recovered
    return Client:new({ dsn = dsn, environment = environment, release = release }, httpService)
end

local function buildErrorKey(str1: string, str2: string): string -- Luacid: Inlined by compiler; 1 call site recovered
    return string.format("%s | %s", str1 or "", str2 or "")
end

local var1 = t.strictInterface({
    httpService = t.some(
        t.instanceOf("HttpService"),
        t.interface({ JSONEncode = t.callback, JSONDecode = t.callback, RequestInternal = t.callback })
    ),
    processErrorReportMethod = t.optional(t.callback),
    debugQueueOptions = t.optional(t.table),
    errorQueueOptions = t.optional(t.table),
    generateLogMethod = t.optional(t.callback),
    logIntervalInSeconds = t.optional(t.numberPositive),
    dsn = t.string,
    environment = t.optional(t.string),
    release = t.optional(t.string),
    errorQueuedCallback = t.optional(t.callback),
    errorFlushedCallback = t.optional(t.callback),
    sentryClientSuccessCallback = t.optional(t.callback),
    sentryClientFailureCallback = t.optional(t.callback),
    logAttachmentSuccessCallback = t.optional(t.callback),
    logAttachmentFailureCallback = t.optional(t.callback),
    disableDevelopmentLogging = t.optional(t.boolean)
})

function module.new(arg1): {_debugLevelQueue: nil, _dsn: any, _environment: any, _errorFlushedCallback: any, _errorLevelQueue: nil, _errorQueuedCallback: any, _generateLogMethod: any, _httpService: any, _isEnabled: boolean, _lastLogTime: number, _logAttachmentFailureCallback: any, _logAttachmentSuccessCallback: any, _logIntervalInSeconds: any, _processErrorReportMethod: any, _release: any, _sentryClient: any, _sentryClientFailureCallback: any, _sentryClientSuccessCallback: any, _sharedAnnotations: {[any]: any}, _sharedAttributes: {[any]: any}, _shouldLogDevelopmentInfo: any}?
    local var2, var3 = var1(arg1)

    if not var2 then
        if not isDevelopmentMode then
            return nil
        end

        error("invalid arguments for SentryReporter: " .. var3)
    end

    local tbl1 = {
        _isEnabled = true,
        _httpService = arg1.httpService,
        _debugLevelQueue = nil,
        _errorLevelQueue = nil,
        _processErrorReportMethod = arg1.processErrorReportMethod,
        _sharedAttributes = {},
        _sharedAnnotations = {},
        _generateLogMethod = arg1.generateLogMethod,
        _logIntervalInSeconds = arg1.logIntervalInSeconds or 5,
        _lastLogTime = 0,
        _dsn = arg1.dsn,
        _environment = arg1.environment,
        _release = arg1.release,
        _sentryClient = createSentryClient(arg1.dsn, arg1.environment, arg1.release, arg1.httpService),
        _errorQueuedCallback = arg1.errorQueuedCallback or nil,
        _errorFlushedCallback = arg1.errorFlushedCallback or nil,
        _sentryClientSuccessCallback = arg1.sentryClientSuccessCallback or nil,
        _sentryClientFailureCallback = arg1.sentryClientFailureCallback or nil,
        _logAttachmentSuccessCallback = arg1.logAttachmentSuccessCallback or nil,
        _logAttachmentFailureCallback = arg1.logAttachmentFailureCallback or nil,
        _shouldLogDevelopmentInfo = isDevelopmentMode and arg1.disableDevelopmentLogging ~= true
    }

    setmetatable(tbl1, module)

    local function reportQueuedError(_: string, tbl2, num1: number)
        if tbl1:sendErrorReport(tbl2.errorReport, tbl2.log) and tbl1._errorFlushedCallback ~= nil then
            tbl1._errorFlushedCallback(num1)
        end
    end

    local debugQueueOptions = arg1.debugQueueOptions
    if FFlagSentrySplitQueuesBySeverity then
        debugQueueOptions = Cryo.Dictionary.join({ queueTimeLimit = FIntSentryDebugLevelQueueTimeLimitSeconds }, arg1.debugQueueOptions or {})
    end

    local errorQueue = ErrorQueue.new(reportQueuedError, debugQueueOptions)
    tbl1._debugLevelQueue = errorQueue

    errorQueue:startTimer()

    if FFlagSentrySplitQueuesBySeverity then
        local errorQueue2 = ErrorQueue.new(
            reportQueuedError,
            Cryo.Dictionary.join(
                {
                    queueTimeLimit = FIntSentryErrorLevelQueueTimeLimitSeconds,
                    flushImmediately = true
                },
                arg1.errorQueueOptions or {}
            )
        )
        tbl1._errorLevelQueue = errorQueue2

        errorQueue2:startTimer()
    end

    return tbl1
end

function module:isTooOldToReportErrors(): boolean
    local robloxVersion = RunService:GetRobloxVersion()
    local var2 = tonumber(string.match(robloxVersion, ".(%d+)."))
    return if var2 then var2 < FIntOldestUAVersionToReportErrors else false
end

function module:_sendLogAttachment(str1: string, str2: string)
    local num1 = string.len(str2)
    local str3, bool2 = truncateLog(str2)

    if bool2 and self._shouldLogDevelopmentInfo then
        local str4 = string.format("Log attachment truncated: original %.2f MB, sending latest %.2f MB", num1 / 1048576, 20)

        print("[Sentry] " .. str4)
    end

    local tbl1 = {{ filename = "app.log", data = str3, content_type = "text/plain" }}

    if self._shouldLogDevelopmentInfo and not bool2 then
        local str4 = string.format("Sending log attachment for event: %s (%.2f KB)", str1, num1 / 1024)
        print("[Sentry] " .. str4)
    end

    self._sentryClient:send_event_with_attachments(str1, tbl1, function(arg1, arg2, _)
        if arg1 then
            if self._shouldLogDevelopmentInfo then
                print("[Sentry] Successfully attached log to event:", str1)
            end

            if self._logAttachmentSuccessCallback ~= nil then
                self._logAttachmentSuccessCallback()
            end
        else
            if self._shouldLogDevelopmentInfo then
                local var2 = if type(arg2) == "table" then arg2.error or "unknown error" else tostring(arg2)
                warn("[Sentry] Failed to attach log:", var2)
            end

            if self._logAttachmentFailureCallback ~= nil then
                self._logAttachmentFailureCallback(arg2)
            end
        end
    end)
end

function module:_handleSentryExceptionCallback(bool2: boolean, arg1, str1: string?, str2: string?)
    if bool2 then
        if self._shouldLogDevelopmentInfo then
            print("[Sentry] Successfully reported error to Sentry:", str1)
        end

        if self._sentryClientSuccessCallback ~= nil then
            self._sentryClientSuccessCallback()
        end

        if str2 and str1 then
            self:_sendLogAttachment(str1, str2)
        end
    else
        if self._shouldLogDevelopmentInfo then
            local var2 = if type(arg1) == "table" then arg1.error or "unknown error" else tostring(arg1)
            warn("[Sentry] Failed to report error to Sentry:", var2)
        end

        if self._sentryClientFailureCallback ~= nil then
            self._sentryClientFailureCallback(arg1)
        end
    end
end

function module:sendErrorReport(arg1, str1: string?): boolean
    if not self._isEnabled then
        return false
    end

    if self:isTooOldToReportErrors() then
        return false
    end

    if isDevelopmentMode then
        assert(arg1:validate())
    end

    local message = arg1.message or "Unknown error message"
    local var2 = arg1.level or Constants.DEFAULT_ERROR_LEVEL

    local var3 = SentryReporterUtility.parseErrorToContext(arg1)
    local var4 = SentryReporterUtility.parseThreadsToSentry(arg1.threads)

    local stacktrace = nil
    if var4 and var4.values then
        for _, value in ipairs(var4.values) do
            if value.main == true or value.crashed == true then
                stacktrace = value.stacktrace
                break
            end
        end
    end

    local var5 = if bool1 and arg1.breadcrumbs and #arg1.breadcrumbs > 0 then latestBreadcrumbs(arg1.breadcrumbs) else nil

    if self._shouldLogDevelopmentInfo then
        print("[Sentry] Report Context:", var3)
        print("[Sentry] Threads:", var4)
        print("[Sentry] Main Stacktrace:", stacktrace)
        print("[Sentry] Level:", var2)
        print("[Sentry] Breadcrumbs:", var5)
    end

    self._sentryClient:capture_exception(
        { type = "LuaError", message = message, stacktrace = stacktrace },
        var2,
        var3,
        var4,
        function(arg2, arg3, arg4)
            self:_handleSentryExceptionCallback(arg2, arg3, arg4, str1)
        end,
        var5,
        if FFlagLuaAppSentryStampOccurrenceTime then arg1.timestamp else nil,
        arg1.tags
    )

    return true
end

function module._sendLogToReport(_, _: string, str1: string?)
    if type(str1) ~= "string" or #str1 == 0 then
        return
    end

    pcall(function() end)
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

function module:_generateErrorReport(str1: string, str2: string, stackDetails, arg2, level)
    local var2

    if type(stackDetails) == "table" then
        if level ~= nil then
            stackDetails = Cryo.Dictionary.join(stackDetails, { level = level })
        end

        var2 = ErrorReport.fromDetails(stackDetails)
    else
        var2 = ErrorReport.fromMessageAndStack(str1, str2, level)

        if type(stackDetails) == "string" then
            var2:addAnnotations({ stackDetails = stackDetails })
        end
    end

    if FFlagLuaAppSentryStampOccurrenceTime then
        var2.timestamp = os.time()
    end

    if arg2 ~= nil then
        var2:addCustomMetadata(arg2)
    end

    var2:addAttributes(self._sharedAttributes)

    if self._sharedAnnotations and next(self._sharedAnnotations) ~= nil then
        var2:addAnnotations(self._sharedAnnotations)
    end

    if self._processErrorReportMethod ~= nil then
        var2 = self._processErrorReportMethod(var2)
    end

    return var2, (self:_generateLog())
end

function module:reportErrorImmediately(str1: string, str2: string, arg1, arg2, arg3)
    if not self._isEnabled then
        return
    end

    local var2, var3 = self:_generateErrorReport(str1, str2, arg1, arg2, arg3)

    self:sendErrorReport(var2, var3)
end

function module:_getQueueForLevel(arg1)
    return if self._errorLevelQueue == nil or (arg1 or Constants.DEFAULT_ERROR_LEVEL) ~= "error" then self._debugLevelQueue else self._errorLevelQueue
end

function module:reportErrorDeferred(str1: string, str2: string, arg1, arg2, arg3)
    if not self._isEnabled then
        return
    end

    local errorKey = buildErrorKey(str1, str2)

    local var2 = self:_getQueueForLevel(arg3)
    local tbl1

    if var2:hasError(errorKey) then
        tbl1 = { errorReport = nil, log = nil }
    else
        local errorReport, log = self:_generateErrorReport(str1, str2, arg1, arg2, arg3)
        tbl1 = { errorReport = errorReport, log = log }
    end

    if self._errorQueuedCallback ~= nil then
        self._errorQueuedCallback()
    end

    var2:addError(errorKey, tbl1)
end

function module:reportAllErrors()
    if self._debugLevelQueue ~= nil then
        self._debugLevelQueue:reportAllErrors()
    end

    if self._errorLevelQueue ~= nil then
        self._errorLevelQueue:reportAllErrors()
    end
end

function module:stop()
    self._isEnabled = false

    if self._debugLevelQueue ~= nil then
        self:reportAllErrors()
        self._debugLevelQueue:stopTimer()
    end

    if self._errorLevelQueue ~= nil then
        self._errorLevelQueue:stopTimer()
    end
end

function module:updateSharedAttributes(arg1)
    local _sharedAttributes = Cryo.Dictionary.join(self._sharedAttributes, arg1)

    local var3, var4 = IAttributes(_sharedAttributes)
    if not var3 then
        if not isDevelopmentMode then
            return
        end

        assert(var3, var4)
    end

    self._sharedAttributes = _sharedAttributes
end

function module:setTag(str1: string, str2: string)
    self._sentryClient:set_tag(str1, str2)
end

function module:setUser(arg1)
    self._sentryClient:set_user(arg1)
end

function module:updateSharedAnnotations(arg1)
    local _sharedAnnotations = Cryo.Dictionary.join(self._sharedAnnotations, arg1)

    local var3, var4 = IAnnotations(_sharedAnnotations)
    if not var3 then
        if not isDevelopmentMode then
            return
        end

        assert(var3, var4)
    end

    self._sharedAnnotations = _sharedAnnotations
end

return module
