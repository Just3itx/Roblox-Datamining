-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T00:41:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpClientParent = script:FindFirstAncestor("HttpClient").Parent

local Resources = require(HttpClientParent.Resources)
local Signals = require(HttpClientParent.Signals)

local _types = require(script.Parent.types)
local encoders = require(script.Parent.encoders)
local analytics = require(script.Parent.analytics)

local createSignal = Signals.createSignal
local createResource = Resources.createResource

local function safeDecode(callback, arg1) -- Luacid: unused: defined but never referenced
    local success, result, result2, result3 = pcall(callback, arg1)
    if not success then
        return nil, `decode error: {tostring(result)}`, nil
    end
    return result, result2, result3
end

local function createRequest(arg1)
    local var1 = arg1.analytics or analytics.defaultAnalytics
    local var2 = arg1.encode or encoders.encodeJson

    local state, var4 = createSignal({ status = "pending" })

    local headers = { Accept = "application/json" }
    if arg1.headers then
        for k, header in arg1.headers do
            headers[k] = header
        end
    end

    local var5 = nil
    if arg1.body ~= nil then
        local var6, var7 = var2(arg1.body)
        var5 = var6
        headers["Content-Type"] = headers["Content-Type"] or var7
    end

    return {
        state = state,
        dispose = createResource(function(callback)
            local bool1 = false
            local startTime = os.clock()

            local function settleFailed(str1: string)
                if bool1 then
                    return
                end
                bool1 = true
                local num1 = (os.clock() - startTime) * 1000
                var4({ status = "failed", error = `transport error: {str1}` })
                var1(arg1.analyticsKey, arg1.method, arg1.url, nil, num1, "failed")
            end

            local function settleResponse(response)
                if bool1 then
                    return
                end
                bool1 = true
                local num1 = (os.clock() - startTime) * 1000

                if arg1.statusCodeActions ~= nil then
                    local statusCodeAction = arg1.statusCodeActions[response.statusCode]
                    if statusCodeAction ~= nil then
                        for _, value in statusCodeAction do
                            local success, result = pcall(value, response)
                            if not success then
                                warn(`[HttpClient] {arg1.analyticsKey} status code action threw: {tostring(result)}`)
                            end
                        end
                    end
                end

                local success, result, result2, result3 = pcall(arg1.decode, response)

                if not success then
                    result2 = `decode error: {tostring(result)}`
                    result = nil
                    result3 = nil
                end

                local str1 = if result2 == nil then "succeeded" else "failed"

                if result2 ~= nil then
                    var4({ status = "failed", error = result2, errorCode = result3, response = response })
                else
                    var4({ status = "succeeded", result = result, response = response })
                end
                var1(arg1.analyticsKey, arg1.method, arg1.url, response, num1, str1)
            end

            local success, result = pcall(function()
                local var6 = arg1.networkImpl.request({
                    url = arg1.url,
                    method = arg1.method,
                    headers = headers,
                    body = var5,
                    onMessage = arg1.onMessage,
                    priority = arg1.priority
                }, function(arg2, arg3)
                    if arg2 then
                        settleResponse(arg3)
                        return
                    end
                    settleFailed(tostring(arg3))
                end)

                callback(function()
                    if bool1 then
                        return
                    end
                    bool1 = true
                    var6()
                end)
            end)

            if not success then
                settleFailed(tostring(result))
            end
        end)
    }
end

return createRequest
