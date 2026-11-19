-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:31:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ContentProvider = game:GetService("ContentProvider")
local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local RobloxReplicatedStorage = game:GetService("RobloxReplicatedStorage")
local RunService = game:GetService("RunService")
local ScriptContext = game:GetService("ScriptContext")
local UserInputService = game:GetService("UserInputService")

local bool1 = game:DefineFastFlag("CoreScriptErrorReporterUseErrorHandler", false)

local bool2 = game:DefineFastFlag("CoreScriptErrorCounterIgnoreReporterSampling", false)

local RobloxGui = CoreGui.RobloxGui
local RateLimiter = require(RobloxGui.Modules.ErrorReporting.RateLimiter)
local PiiFilter = require(RobloxGui.Modules.ErrorReporting.PiiFilter)
local LuaCoreScriptsErrorV2CounterConfig = require(RobloxGui.Modules.ErrorReporting.LuaCoreScriptsErrorV2CounterConfig)
local createCoreScriptErrorHandler = require(RobloxGui.Modules.ErrorReporting.createCoreScriptErrorHandler)
local createCoreScriptReportProcessor = require(RobloxGui.Modules.ErrorReporting.createCoreScriptReportProcessor)
local createCoreScriptSentryReporter = if bool1 then require(RobloxGui.Modules.ErrorReporting.createCoreScriptSentryReporter) else nil
local FFlagCoreScriptErrorReporterIncludeScriptContext = require(RobloxGui.Modules.Flags.FFlagCoreScriptErrorReporterIncludeScriptContext)

local BacktraceReporter = require(CorePackages.Workspace.Packages.ErrorReporters).BacktraceReporter
local default = require(CorePackages.Workspace.Packages.LoggingProtocol).default
local React = require(CorePackages.Packages.React)

local SessionWithErrorReporter = require(CorePackages.Workspace.Packages.AppObservability).SessionWithErrorReporter

local LuaCoreScriptsSessionWithErrorConfig = require(RobloxGui.Modules.ErrorReporting.LuaCoreScriptsSessionWithErrorConfig)

game:DefineFastFlag("DisableCorescriptBacktraceReporting", false)
game:DefineFastString("CoreScriptBacktraceErrorUploadToken", "")

game:DefineFastInt("CoreScriptBacktracePIIFilterEraseTimeoutSeconds", 300)

game:DefineFastFlag("CoreScriptBacktraceRepeatedErrorRateLimiting", true)
game:DefineFastInt("CoreScriptBacktraceRepeatedErrorRateLimitCount", 5)
game:DefineFastInt("CoreScriptBacktraceRepeatedErrorRateLimitPeriod", 60)

game:DefineFastInt("CoreScriptBacktraceRepeatedErrorRateLimitProcessIntervalTenths", 10)

game:DefineFastInt("CoreScriptBacktraceErrorReportPercentage", 100)

local dsn = game:DefineFastString("CoreScriptSentryDsn", "")
local num1 = game:DefineFastInt("CoreScriptSentryRolloutPercentage", 0)

local function CanReportCoreScriptBacktrace(): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return math.random(1, 100) <= math.clamp(game:GetFastInt("CoreScriptBacktraceErrorReportPercentage"), 0, 100)
end

local function CanReportCoreScriptSentry(): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return math.random(1, 100) <= math.clamp(num1, 0, 100)
end

local bool3 = not game:GetFastFlag("DisableCorescriptBacktraceReporting")

if bool3 then
    if game:GetFastString("CoreScriptBacktraceErrorUploadToken") == "" then
        bool3 = false
    else
        bool3 = CanReportCoreScriptBacktrace()
    end
end

local bool4 = bool1 and not (dsn == "") and not not CanReportCoreScriptSentry()

if bool1 and (bool3 or bool4 or bool2) then
    local processErrorReportMethod, var2 = createCoreScriptReportProcessor()

    local piiFilter = PiiFilter.new({ eraseTimeout = game:GetFastInt("CoreScriptBacktracePIIFilterEraseTimeoutSeconds") })
    local rateLimiter = if game:GetFastFlag("CoreScriptBacktraceRepeatedErrorRateLimiting") then RateLimiter.new({
        period = game:GetFastInt("CoreScriptBacktraceRepeatedErrorRateLimitPeriod"),
        threshold = game:GetFastInt("CoreScriptBacktraceRepeatedErrorRateLimitCount"),
        processInterval = game:GetFastInt("CoreScriptBacktraceRepeatedErrorRateLimitProcessIntervalTenths") / 10
    }) else nil
    local sessionWithErrorReporter = SessionWithErrorReporter.new(LuaCoreScriptsSessionWithErrorConfig, 300, nil)

    local reporters = {}

    if bool3 then
        table.insert(
            reporters,
            BacktraceReporter.new({
                httpService = HttpService,
                token = game:GetFastString("CoreScriptBacktraceErrorUploadToken"),
                processErrorReportMethod = processErrorReportMethod
            })
        )
    end

    if bool4 then
        local coreScriptSentryReporter = createCoreScriptSentryReporter({ dsn = dsn, processErrorReportMethod = processErrorReportMethod })

        if coreScriptSentryReporter ~= nil then
            table.insert(reporters, coreScriptSentryReporter)
        end
    end

    local coreScriptErrorHandler = createCoreScriptErrorHandler({
        piiFilter = piiFilter,
        rateLimiter = rateLimiter,
        reporters = reporters,
        onErrorReported = function()
            default:logRobloxTelemetryCounter(LuaCoreScriptsErrorV2CounterConfig, 1)

            if #reporters > 0 then
                sessionWithErrorReporter:reportEvent(1, nil, "ERROR")
            end
        end
    })

    if #reporters > 0 or bool2 then
        ScriptContext.ErrorDetailed:Connect(function(...)
            local success, result = pcall(coreScriptErrorHandler, ...)

            if not success then
                warn(("CoreScript error reporter failed to handle an error:\n%s"):format(result))
            end
        end)
    end

    if bool3 or bool4 then
        var2.ServerVersion = RobloxReplicatedStorage:WaitForChild("GetServerVersion", math.huge):InvokeServer()
    end
end

if not bool3 or bool1 then
    return
end

local tbl1 = {
    LocalVersion = RunService:GetRobloxVersion(),
    BaseUrl = ContentProvider.BaseUrl,
    PlaceId = game.PlaceId,
    Platform = UserInputService:GetPlatform().Name,
    UserAgent = HttpService:GetUserAgent(),
    CoreScriptVersion = RunService:GetCoreScriptVersion()
}

local piiFilter = PiiFilter.new({ eraseTimeout = game:GetFastInt("CoreScriptBacktracePIIFilterEraseTimeoutSeconds") })

local fastFlag = game:GetFastFlag("CoreScriptBacktraceRepeatedErrorRateLimiting")
local rateLimiter = if fastFlag then RateLimiter.new({
    period = game:GetFastInt("CoreScriptBacktraceRepeatedErrorRateLimitPeriod"),
    threshold = game:GetFastInt("CoreScriptBacktraceRepeatedErrorRateLimitCount"),
    processInterval = game:GetFastInt("CoreScriptBacktraceRepeatedErrorRateLimitProcessIntervalTenths") / 10
}) else nil

local sessionWithErrorReporter = SessionWithErrorReporter.new(LuaCoreScriptsSessionWithErrorConfig, 300, nil)

local backtraceReporter = BacktraceReporter.new({
    httpService = HttpService,
    token = game:GetFastString("CoreScriptBacktraceErrorUploadToken"),
    processErrorReportMethod = function<T>(arg1: T): T -- name: processReport
        arg1:addAttributes(tbl1)

        arg1:addAttributes({ PlayerCount = #Players:GetPlayers() })

        arg1:addAttributes({ RobloxChannel = RunService:GetRobloxClientChannel() })

        return arg1
    end
})

local function handleErrorDetailed(arg1, arg2, arg3, arg4)
    if arg3 == nil
        or not arg3:IsDescendantOf(CoreGui)
            and not arg3:IsDescendantOf(CorePackages)
            and (not FFlagCoreScriptErrorReporterIncludeScriptContext
                or not arg3:IsA("CoreScript")
                or not arg3:IsDescendantOf(ScriptContext))
    then
        return
    end

    local var1, var2 = React.unstable_parseReactError(arg1)

    arg1 = var1.message

    arg2 = var1.stack or arg2

    arg4 = arg4 or var2

    local var3 = piiFilter:cleanPii(arg1)
    local var4 = piiFilter:cleanPii(arg2)

    if arg4 ~= nil then
        arg4 = piiFilter:cleanPii(arg4)
    end

    if fastFlag then
        local var5 = var3 .. var4
        if rateLimiter:isRateLimited(var5) then
            return
        end
        rateLimiter:increment(var5)
    end

    backtraceReporter:reportErrorDeferred(var3, var4, arg4)
    default:logRobloxTelemetryCounter(LuaCoreScriptsErrorV2CounterConfig, 1)

    sessionWithErrorReporter:reportEvent(1, nil, "ERROR")
end

ScriptContext.ErrorDetailed:Connect(function(...)
    local success, result = pcall(handleErrorDetailed, ...)

    if not success then
        warn(("CoreScript error reporter failed to handle an error:\n%s"):format(result))
    end
end)

tbl1.ServerVersion = RobloxReplicatedStorage:WaitForChild("GetServerVersion", math.huge):InvokeServer()
