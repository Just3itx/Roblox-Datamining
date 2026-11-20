-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:21:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpRequestParent = script:FindFirstAncestor("HttpRequest").Parent
local Cryo = require(HttpRequestParent.Cryo)

local HttpService = game:GetService("HttpService")

local StatusCode = require(script.Parent.StatusCode)
local HttpSession = require(script.Parent.HttpSession)
local HttpResponse = require(script.Parent.HttpResponse)

local tbl1 = {
    [StatusCode.REQUEST_TIMEOUT] = true,
    [StatusCode.SERVICE_UNAVAILABLE] = true,
    [StatusCode.GATEWAY_TIMEOUT] = true
}

local module = {}
module.__index = module

function module.new(arg1, url, requestMethod, arg2)
    arg1 = arg1 or {}
    local tbl2 = {
        resolve = nil,
        reject = nil,
        retryCount = 0,
        httpRequest = nil,
        canceled = false,
        requestFunction = arg1.requestFunction,
        postRequestFunction = arg1.postRequestFunction,
        url = url,
        requestMethod = requestMethod,
        options = Cryo.Dictionary.join(arg1.defaultOptions or {}, arg2 or {}),
        waitImpl = arg1.waitImpl or delay,
        maxRetryCount = arg1.maxRetryCount or 4,
        maxWaitTime = arg1.maxWaitTime or 16,
        session = HttpSession.currentSession()
    }

    setmetatable(tbl2, module)
    return tbl2
end

function module:start(resolve, reject)
    self.resolve = resolve
    self.reject = reject
    self:makeRequest()
end

function module:processResponse(arg1)
    local success, result = pcall(HttpService.JSONDecode, HttpService, arg1.Body)

    if not success then
        self.reject(HttpResponse.error(Enum.HttpError.OK))

        return
    end

    if self.postRequestFunction then
        pcall(
            self.postRequestFunction,
            arg1,
            {
                url = self.url,
                requestMethod = self.requestMethod,
                options = self.options,
                retryCount = self.retryCount
            }
        )
    end
    self.resolve(HttpResponse.success(arg1.StatusCode, result))
end

function module:retry(arg1, arg2)
    self.retryCount += 1
    if self.retryCount > self.maxRetryCount then
        self.reject(arg1)
        return
    end

    arg2 = arg2 or math.pow(2, self.retryCount)
    self:wait(arg2)
end

function module:wait(arg1)
    self.waitImpl(arg1, function()
        self:makeRequest()
    end)
end

function module:makeRequest()
    if self.canceled then
        return
    end
    self.httpRequest = self.requestFunction(self.url, self.requestMethod, self.options)
    self.httpRequest:Start(function(arg1, arg2)
        if self.session ~= HttpSession.currentSession() then
            warn("Http request aborted", self.url)
            return
        end

        if not arg1 then
            if not self.canceled then
                self:retry(HttpResponse.error(arg2.HttpError))
            end

            return
        end

        if arg2.StatusCode >= 200 and arg2.StatusCode < 400 then
            self:processResponse(arg2)
            return
        end

        if tbl1[arg2.StatusCode] then
            self:retry(arg2)
            return
        end

        if arg2.StatusCode ~= StatusCode.TOO_MANY_REQUESTS or not arg2.Headers["Retry-After"] then
            self.reject(arg2)
            return
        end

        local var1 = tonumber(arg2.Headers["Retry-After"])
        if var1 ~= nil and var1 <= self.maxWaitTime then
            self:retry(arg2, var1)
            return
        end
        self.reject(arg2)
    end)
end

function module:cancel()
    self.canceled = true
    self.reject(HttpResponse.error(Enum.HttpError.Aborted))
    if self.httpRequest then
        self.httpRequest:Cancel()
    end
end

return module
