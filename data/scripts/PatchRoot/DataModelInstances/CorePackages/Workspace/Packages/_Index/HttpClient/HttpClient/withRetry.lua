-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T00:50:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpClientParent = script:FindFirstAncestor("HttpClient").Parent

local mutedError = require(HttpClientParent.Loggers).mutedError

local _types = require(script.Parent.types)

local tbl1 = { [408] = true, [503] = true, [504] = true }

local function backoffSeconds(num1: number, num2: number, num3: number): number -- Luacid: Inlined by compiler; 1 call site recovered
    return (num2 + math.random() * (num3 - num2)) * math.pow(2, num1 - 1) / 1000
end

local function shouldRetry(arg1, tbl2, retryOnHttpErrors)
    if arg1.wasTransportFailure and retryOnHttpErrors == nil then
        return true, nil
    end
    if retryOnHttpErrors ~= nil
        and arg1.httpError ~= nil
        and arg1.httpError ~= Enum.HttpError.OK
        and retryOnHttpErrors[arg1.httpError]
    then
        return true, nil
    end
    if tbl2[arg1.statusCode] then
        return true, nil
    end
    if arg1.statusCode == 429 and arg1.headers ~= nil then
        local var1 = tonumber(arg1.headers["retry-after"])
        if var1 ~= nil and var1 <= 16 then
            return true, var1
        end
    end
    return false, nil
end

local function withRetry(arg1, arg2)
    local var1 = arg2 or {}
    local maxRetryCount = var1.maxRetryCount or 4
    local retryJitterMinMs = var1.retryJitterMinMs or 0
    local retryJitterMaxMs = var1.retryJitterMaxMs or 4000
    local var2 = var1.retryOnStatuses or tbl1
    local retryOnHttpErrors = var1.retryOnHttpErrors
    local retryBudgetSec = var1.retryBudgetSec

    if maxRetryCount < 0 then
        mutedError(`withRetry: maxRetryCount must be >= 0, got {maxRetryCount}; falling back to default`)
        maxRetryCount = 4
    end
    if retryJitterMaxMs <= retryJitterMinMs then
        mutedError(
            `withRetry: retryJitterMinMs ({retryJitterMinMs}) must be < retryJitterMaxMs ({retryJitterMaxMs}); falling back to default`
        )
        retryJitterMinMs = 0
        retryJitterMaxMs = 4000
    end
    if retryBudgetSec ~= nil and retryBudgetSec <= 0 then
        mutedError(`withRetry: retryBudgetSec must be > 0, got {retryBudgetSec}; ignoring the budget`)
        retryBudgetSec = nil
    end

    return {
        request = function(arg3, callback: (...any) -> (...any))
            local num1 = 0
            local startTime = os.clock()
            local bool1 = false
            local bool2 = false
            local var3 = nil
            local var4 = nil

            local onMessage = arg3.onMessage

            local function handleMessage(str1: string)
                bool2 = true
                onMessage(str1)
            end

            local function func1()
                if bool1 then
                    return
                end
                local var5 = arg3
                if onMessage ~= nil then
                    var5 = table.clone(arg3)
                    var5.onMessage = handleMessage
                end
                if num1 > 0 then
                    local headers = not arg3.headers and {} or table.clone(arg3.headers)
                    headers["X-Retry-Attempt"] = tostring(num1)
                    if var5 == arg3 then
                        var5 = table.clone(arg3)
                    end
                    var5.headers = headers
                    if var1.onRetry ~= nil then
                        var1.onRetry(num1)
                    end
                end

                var3 = arg1.request(var5, function(arg4, arg5)
                    var3 = nil
                    if bool1 then
                        return
                    end

                    if bool2 then
                        callback(arg4, arg5)
                        return
                    end

                    local var6 = nil
                    if arg4 then
                        local var7
                        var7, var6 = shouldRetry(arg5, var2, retryOnHttpErrors)
                        if not (var7 and num1 < maxRetryCount) then
                            callback(true, arg5)
                            return
                        end
                    elseif retryOnHttpErrors ~= nil or maxRetryCount <= num1 then
                        callback(false, arg5)
                        return
                    end

                    num1 += 1
                    local var7 = var6 or backoffSeconds(num1, retryJitterMinMs, retryJitterMaxMs)

                    if retryBudgetSec ~= nil and startTime ~= nil and os.clock() - startTime + var7 >= retryBudgetSec then
                        callback(arg4, arg5)
                        return
                    end
                    var4 = task.delay(var7, function()
                        var4 = nil
                        func1()
                    end)
                end)
            end

            func1()

            return function()
                if bool1 then
                    return
                end
                bool1 = true
                if var4 ~= nil then
                    task.cancel(var4)
                    var4 = nil
                end
                if var3 ~= nil then
                    var3()
                    var3 = nil
                end
            end
        end
    }
end

return withRetry
