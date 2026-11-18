-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-18T23:40:57Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local Http = script:FindFirstAncestor("Http")
local HttpParent = Http.Parent

local Promise = require(HttpParent.Promise)
local NetworkProfiler = require(Http.NetworkProfiler)
local _RequestTypes = require(Http.RequestTypes)
local StatusCodes = require(Http.StatusCodes)
local HttpCanceller = require(Http.NetworkLayers.HttpCanceller)

local GreenlistedEndpointsForLogging = require(Http.Logger.GreenlistedEndpointsForLogging)
local MrRouterHeaders = require(HttpParent.MrRouterHeaders)

local bool1 = game:DefineFastFlag("LuaAppHttpSupportNoContent", false)
local bool2 = game:DefineFastFlag("EnableRetryOnPrefetch401", false)

local None = Enum.HttpCachePolicy.None

local tbl1 = {
    [StatusCodes.REQUEST_TIMEOUT] = true,
    [StatusCodes.SERVICE_UNAVAILABLE] = true,
    [StatusCodes.GATEWAY_TIMEOUT] = true
}

local tbl2 = {}
tbl2.__index = tbl2

local function parseResponseBody(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    if arg1.StatusCode == StatusCodes.NO_CONTENT then
        return true, nil
    end
    local success, result = pcall(HttpService.JSONDecode, HttpService, arg1.Body)
    return success, result
end

function tbl2.new(httpService, url: string, str1: string, arg1)
    local tbl3 = {
        resolve = nil,
        reject = nil,
        retryCount = 0,
        maxRetryCount = arg1 and arg1.maxRetryCount or 4,
        httpRequest = nil,
        canceled = false,
        httpService = httpService,
        session = HttpCanceller.currentSession()
    }

    tbl3.internalOptions = {
        Url = url,
        Method = str1 and str1 or "GET",
        Body = if arg1 then arg1.postBody or nil else nil,
        Timeout = arg1 and arg1.timeout or 15000,
        CachePolicy = arg1 and arg1.cachePolicy or None,
        Priority = arg1 and arg1.priority or 0,
        Headers = if arg1 then arg1.headers or nil else nil,
        RequestType = arg1 and arg1.requestType or nil
    }
    if (str1 == "POST" or str1 == "PATCH")
        and (tbl3.internalOptions.Headers == nil or tbl3.internalOptions.Headers["Content-Type"] == nil)
    then
        tbl3.internalOptions.Headers = tbl3.internalOptions.Headers or {}
        tbl3.internalOptions.Headers["Content-Type"] = "application/json"
    end

    tbl3.internalOptions.Headers = MrRouterHeaders.injectMrRouterHeaders(tbl3.internalOptions.Headers)

    setmetatable(tbl3, tbl2)
    return tbl3
end

function tbl2:start(resolve, reject)
    self.resolve = resolve
    self.reject = reject
    self:makeRequest()
end

function tbl2:processResponse(arg1)
    local success, result

    if bool1 then
        success, result = parseResponseBody(arg1)
    else
        success, result = pcall(HttpService.JSONDecode, HttpService, arg1.Body)
    end

    if not success then
        self.reject({ HttpError = Enum.HttpError.OK, isJSONValid = false })
        return
    end
    NetworkProfiler:track({
        queued = arg1.Stats.DurationInQueue,
        nameLookup = arg1.Stats.DurationNameLookup,
        connect = arg1.Stats.DurationConnect,
        sslHandshake = arg1.Stats.DurationSSLHandshake,
        makeRequest = arg1.Stats.DurationMakeRequest,
        receiveResponse = arg1.Stats.DurationReceiveResponse
    })
    local responseTimeMs = arg1.Stats.RoundTripTime * 1000
    local bodyLen = arg1.Body and typeof(arg1.Body) == "string" and #arg1.Body or 0

    local tbl3 = {
        responseCode = arg1.StatusCode,
        requestUrl = self.internalOptions.Url,
        responseTimeMs = responseTimeMs,
        isJSONValid = true,
        result,
        responseBody = result,
        responseStats = arg1.Stats,
        responseSize = bodyLen
    }
    self.resolve(tbl3)
    GreenlistedEndpointsForLogging.sendStatusCodeCounter(self.internalOptions.Url, arg1.StatusCode)
end

function tbl2:retry(arg1, arg2)
    local bool3 = not (arg1.Stats and arg1.Stats.WasRequestRetried)

    if bool3 then
        self.retryCount += 1
        if self.retryCount > self.maxRetryCount then
            bool3 = false
        end
    end

    if not bool3 then
        self.reject(arg1)
        return
    end

    if self.internalOptions.Headers == nil then
        self.internalOptions.Headers = {}
    end
    local headers = self.internalOptions.Headers
    headers["X-Retry-Attempt"] = tostring(self.retryCount)

    arg2 = arg2 or math.pow(2, self.retryCount)

    delay(arg2, function()
        self:makeRequest()
    end)
end

function tbl2:makeRequest()
    if self.canceled then
        return
    end

    self.httpRequest = self.httpService:RequestInternal(self.internalOptions)

    self.httpRequest:Start(function(arg1, arg2)
        if self.session ~= HttpCanceller.currentSession() then
            warn("Http request aborted", self.internalOptions.Url)
            return
        end

        if not arg1 then
            if not self.canceled then
                self:retry({ HttpError = arg2.HttpError })
            end

            return
        end

        if arg2.StatusCode >= 200 and arg2.StatusCode < 400 then
            self:processResponse(arg2)
            return
        end

        if tbl1[arg2.StatusCode] or bool2 and arg2.IsPrefetch and arg2.StatusCode == StatusCodes.UNAUTHORIZED then
            self:retry(arg2)
            return
        end

        if arg2.StatusCode ~= StatusCodes.TOO_MANY_REQUESTS or not arg2.Headers["Retry-After"] then
            GreenlistedEndpointsForLogging.sendStatusCodeCounter(self.internalOptions.Url, arg2.StatusCode)

            self.reject(arg2)
            return
        end

        local var1 = tonumber(arg2.Headers["Retry-After"])
        if var1 ~= nil and var1 <= 16 then
            self:retry(arg2, var1)
            return
        end

        GreenlistedEndpointsForLogging.sendStatusCodeCounter(self.internalOptions.Url, arg2.StatusCode)
        self.reject(arg2)
    end)
end

function tbl2:cancel()
    self.canceled = true
    self.reject({ HttpError = Enum.HttpError.Aborted })
    if self.httpRequest then
        self.httpRequest:Cancel()
    end
end

local function createRequestInternalWrapper(arg1)
    arg1 = arg1 or HttpService

    local function makeRequest(str1: string, str2: string, arg2)
        local var1 = tbl2.new(arg1, str1, str2, arg2)

        local function cancel()
            var1:cancel()
        end

        return Promise.new(function(arg3, arg4)
            var1:start(arg3, arg4)
        end), cancel
    end

    return makeRequest
end

return createRequestInternalWrapper
