-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T02:21:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent

local scriptParentParent = scriptParent.Parent

local Signals = require(scriptParentParent.Signals)
local HttpSignals = require(scriptParentParent.HttpSignals)
local Http = require(scriptParentParent.Http)

local StatusCodes = Http.StatusCodes
local _HttpStoreTypes = require(scriptParent.HttpStoreTypes)

local createParsedResponse = require(scriptParent.createParsedResponse)

local MrRouterHeaders = Http.MrRouterHeaders

local tbl1 = {
    [StatusCodes.REQUEST_TIMEOUT] = true,
    [StatusCodes.SERVICE_UNAVAILABLE] = true,
    [StatusCodes.GATEWAY_TIMEOUT] = true
}

local function createHttpFetchWithRetry(arg1)
    local maxRetryCount = arg1.MaxRetryCount or 4
    local retryJitterMinMs = arg1.RetryJitterMinMs or 0
    local retryJitterMaxMs = arg1.RetryJitterMaxMs or 4000

    local var1 = nil
    local var2 = nil

    local var3, var4 = Signals.createSignal(0)
    local var5, var6 = Signals.createSignal(false)

    local function cleanupCurrentFetch() -- Luacid: Inlined by compiler; 2 call sites recovered
        if var1 ~= nil then
            task.cancel(var1)
            var1 = nil
        end
        if var2 ~= nil then
            var2()
            var2 = nil
        end
    end

    local function dispose()
        var6(true)
        cleanupCurrentFetch()
    end

    local function scheduleRetry(num1: number?)
        if var1 ~= nil then
            return
        end

        if num1 == nil or num1 > 16 then
            local num2 = math.pow(2, var3() + 1)
            local var7 = retryJitterMaxMs - retryJitterMinMs
            num1 = math.max(num2 + (retryJitterMinMs + math.random() * var7) / 1000, 0)
        end

        var1 = task.delay(num1, function()
            var1 = nil
            var4(function(arg2): number
                return arg2 + 1
            end)
        end)
    end

    local computed = Signals.createComputed(function(arg2)
        local var7 = var3(arg2)

        local var8 = arg1
        if var7 > 0 then
            var8 = table.clone(arg1)
            local headers = not arg1.Headers and {} or table.clone(arg1.Headers)
            headers["X-Retry-Attempt"] = tostring(var7)
            var8.Headers = headers
        end

        cleanupCurrentFetch()
        local var9, var10 = HttpSignals.fetch(var8)
        var2 = var10
        return var9
    end)

    return Signals.createComputed(function(arg2)
        if var5(arg2) then
            return {
                status = "error",
                error = {
                    HttpError = Enum.HttpError.Aborted
                }
            }
        end

        local var7 = computed(arg2)(arg2)

        if var7.status == "pending" then
            return var7
        end

        if var7.status ~= "success" then
            if var7.status ~= "error" then
                return var7
            end

            if not (var3() < maxRetryCount) then
                return var7
            end

            scheduleRetry()
            return { status = "pending" }
        end

        local data = var7.data
        local statusCode = data.StatusCode

        if data.Stats and data.Stats.WasRequestRetried then
            return var7
        end

        if statusCode >= 200 and statusCode < 400 then
            return var7
        end

        if var3() < maxRetryCount then
            if tbl1[statusCode] then
                scheduleRetry()
                return { status = "pending" }
            end

            if data.IsPrefetch and statusCode == StatusCodes.UNAUTHORIZED then
                scheduleRetry()
                return { status = "pending" }
            end

            if statusCode == StatusCodes.TOO_MANY_REQUESTS and data.Headers["Retry-After"] then
                local var8 = tonumber(data.Headers["Retry-After"])
                if var8 ~= nil and var8 <= 16 then
                    scheduleRetry(var8)
                    return { status = "pending" }
                end
            end
        end

        return var7
    end), dispose
end

local function createFetchHttpHandler(arg1)
    if arg1.MaxRetryCount ~= nil and arg1.MaxRetryCount < 0 then
        error(`MaxRetryCount must be >= 0, was provided: {arg1.MaxRetryCount}`)
    end

    if arg1.RetryJitterMinMs ~= nil and arg1.RetryJitterMaxMs ~= nil and arg1.RetryJitterMinMs >= arg1.RetryJitterMaxMs then
        error("RetryJitterMinMs must be smaller than RetryJitterMaxMs if both are provided")
    end

    local headers = MrRouterHeaders.injectMrRouterHeaders(arg1.Headers)
    if headers ~= arg1.Headers then
        arg1 = table.clone(arg1)
        arg1.Headers = headers
    end

    local var2, func1 = createHttpFetchWithRetry(arg1)

    return createParsedResponse(var2, arg1), func1
end

return createFetchHttpHandler
