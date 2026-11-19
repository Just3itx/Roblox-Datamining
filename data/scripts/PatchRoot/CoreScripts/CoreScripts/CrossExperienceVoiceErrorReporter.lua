-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T05:11:12Z
-- Luau bytecode version: 9 | Luau type version: 3
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

local RobloxGui = CoreGui.RobloxGui

local RateLimiter = require(RobloxGui.Modules.ErrorReporting.RateLimiter)
local PiiFilter = require(RobloxGui.Modules.ErrorReporting.PiiFilter)

local BacktraceReporter = require(CorePackages.Workspace.Packages.ErrorReporters).BacktraceReporter

game:DefineFastFlag("DisableCEVBacktraceReporting", false)
game:DefineFastString("CoreScriptBacktraceErrorUploadToken", "")

game:DefineFastInt("CEVBacktracePIIFilterEraseTimeoutSeconds", 300)

game:DefineFastFlag("CEVBacktraceRepeatedErrorRateLimiting", true)
game:DefineFastInt("CEVBacktraceRepeatedErrorRateLimitCount", 5)
game:DefineFastInt("CEVBacktraceRepeatedErrorRateLimitPeriod", 60)

game:DefineFastInt("CEVBacktraceRepeatedErrorRateLimitProcessIntervalTenths", 10)

game:DefineFastInt("CEVBacktraceErrorReportPercentage", 100)

local function CanReportCEVBacktrace(): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return math.random(1, 100) <= math.clamp(game:GetFastInt("CEVBacktraceErrorReportPercentage"), 0, 100)
end

if game:GetFastFlag("DisableCEVBacktraceReporting")
    or game:GetFastString("CoreScriptBacktraceErrorUploadToken") == ""
    or not CanReportCEVBacktrace()
then
    return
end

local tbl1 = {
    LocalVersion = RunService:GetRobloxVersion(),
    BaseUrl = ContentProvider.BaseUrl,
    PlaceId = game.PlaceId,
    Platform = UserInputService:GetPlatform().Name,
    UserAgent = HttpService:GetUserAgent(),
    CoreScriptVersion = RunService:GetCoreScriptVersion(),
    AppName = "CrossExperienceVoice"
}

local piiFilter = PiiFilter.new({ eraseTimeout = game:GetFastInt("CEVBacktracePIIFilterEraseTimeoutSeconds") })

local fastFlag = game:GetFastFlag("CEVBacktraceRepeatedErrorRateLimiting")
local rateLimiter = if fastFlag then RateLimiter.new({
    period = game:GetFastInt("CEVBacktraceRepeatedErrorRateLimitPeriod"),
    threshold = game:GetFastInt("CEVBacktraceRepeatedErrorRateLimitCount"),
    processInterval = game:GetFastInt("CEVBacktraceRepeatedErrorRateLimitProcessIntervalTenths") / 10
}) else nil

local backtraceReporter = BacktraceReporter.new({
    httpService = HttpService,
    token = game:GetFastString("CoreScriptBacktraceErrorUploadToken"),
    processErrorReportMethod = function<T>(arg1: T): T -- name: processReport
        arg1:addAttributes(tbl1)

        arg1:addAttributes({ PlayerCount = #Players:GetPlayers(), RobloxChannel = RunService:GetRobloxClientChannel() })

        return arg1
    end
})

local function handleErrorDetailed(arg1, arg2, arg3, arg4)
    if arg3 == nil or not arg3:IsDescendantOf(CoreGui) and not arg3:IsDescendantOf(CorePackages) then
        return
    end
    local var1 = piiFilter:cleanPii(arg1)
    local var2 = piiFilter:cleanPii(arg2)

    if arg4 ~= nil then
        arg4 = piiFilter:cleanPii(arg4)
    end

    if fastFlag then
        local var3 = var1 .. var2
        if rateLimiter:isRateLimited(var3) then
            return
        end
        rateLimiter:increment(var3)
    end

    backtraceReporter:reportErrorDeferred(var1, var2, arg4)
end

ScriptContext.ErrorDetailed:Connect(function(...)
    local success, result = pcall(handleErrorDetailed, ...)

    if not success then
        warn(("CEV error reporter failed to handle an error:\n%s"):format(result))
    end
end)

tbl1.ServerVersion = RobloxReplicatedStorage:WaitForChild("GetServerVersion", math.huge):InvokeServer()
