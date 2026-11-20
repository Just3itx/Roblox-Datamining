-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:31:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local lib = scriptParentParent.lib
local src = scriptParentParent.src
local scriptParentParentParent = scriptParentParent.Parent

local HttpService = game:GetService("HttpService")

local url = require(lib.url)
local Promise = require(scriptParentParentParent.Promise)

local json = require(src.json)
local response = require(src.response)
local cookies = require(src.cookies)
local ratelimit = require(src.ratelimit)
local util = require(src.util)

local cache = require(src.cache)

local module = {}
module.__index = module
function module.new(arg1, inputUrl, arg2)
    local self = setmetatable({}, module)

    arg2 = arg2 or {}

    local var1 = url.parse(inputUrl)
    local headers = arg2.headers or {}

    self.method = arg1:upper()
    self.url = var1
    self.input_url = inputUrl
    self.headers = headers
    self.query = {}
    self.data = nil

    self._ratelimits = { ratelimit.get("http", 250, 30) }

    self.ignore_ratelimit = arg2.ignore_ratelimit or false

    if arg2.data then
        self:set_data(arg2.data)
    end

    self:set_query(arg2.query or {})

    local cookies2 = arg2.cookies or {}
    local cookies3

    if cookies2.__cookiejar then
        cookies3 = cookies2
    else
        cookies3 = cookies.new()

        if cookies2 then
            for k, value in pairs(cookies2) do
                cookies3:insert(k, value)
            end
        end
    end

    self.cookies = cookies3
    self.headers.Cookie = cookies3:string(inputUrl)

    self._callback = nil

    self._log = arg2.log == nil or arg2.log

    return self
end

function module:set_headers(arg1)
    for k, value in pairs(arg1) do
        self.headers[k] = value
    end

    return self
end
module.update_headers = util.deprecate(module.set_headers, "0.5", "update_headers")

function module:set_query(arg1)
    for k, value in pairs(arg1) do
        self.query[k] = value
    end

    self.url:setQuery(self.query)

    return self
end
module.update_query = util.deprecate(module.set_headers, "0.5", "update_query")

function module:set_data(arg1)
    if type(arg1) == "table" then
        if arg1.__FormData then
            self.headers["Content-Type"] = arg1.content_type
            arg1 = arg1:build()
        else
            arg1 = json.enc(arg1)
            self.headers["Content-Type"] = "application/json"
        end
    end

    self.data = arg1

    return self
end

function module:_ratelimit()
    for _, _ratelimit2 in ipairs(self._ratelimits) do
        if not _ratelimit2:request() then
            return false
        end
    end

    return true
end

function module:_send()
    local requestOptions = {
        Url = self.url:build(),
        Method = self.method,
        Headers = self.headers
    }

    if self.data ~= nil then
        requestOptions.Body = self.data
    end

    local var1 = requestOptions.Url:sub(-1, -1) == "/" and requestOptions.Url:sub(1, -2) or requestOptions.Url

    local str1 = ("Request_%s_%s_%s"):format(self.method, var1, requestOptions.Body or "")
    local var2, var3, response2, var4

    if self.method:upper() == "GET" and cache.is_cached(requestOptions.Url, str1) then
        local startTime = tick()
        local var5, var6 = cache.get_cached(requestOptions.Url, str1)

        if startTime - var5.timestamp <= cache.get_expire(requestOptions.Url) then
            local response3 = response.new(self, var5, tick() - startTime)
            response3.from_cache = true

            print("[http]", var6:upper(), "CACHE |", response3.method, response3.url)
            return response3
        end

        var2 = 0
        var3 = false
        response2 = nil
        var4 = nil
    else
        var2 = 0
        var3 = false
        response2 = nil
        var4 = nil
    end

    while var2 < 5 do
        if self.ignore_ratelimit or self:_ratelimit() then
            local timestamp = tick()

            var4 = HttpService:RequestAsync(requestOptions)
            response2 = response.new(self, var4, tick() - timestamp)
            self.timestamp = timestamp
            var3 = true
            break
        end

        warn("[http] Rate limit exceeded. Retrying in 5 seconds")

        var2 += 1
        wait(5)
    end

    if not var3 then
        error("[http] Rate limit still exceeded after 5 attempts")
    end

    if self._log then
        local str2 = tostring(math.floor(self._ratelimits[#self._ratelimits]:consumption() * 1000) * 0.1) .. "%"

        print("[http]", response2.code, response2.message, "|", response2.method, response2.url, "(", str2, "ratelimit )")
    end

    if self._callback then
        self._callback(response2)
    end

    if self.method:upper() == "GET" and response2.ok and cache.should_cache(requestOptions.Url) then
        cache.update_cache(requestOptions.Url, str1, var4)
    end

    return response2
end

function module.send(arg1, arg2)
    if not arg2 then
        return arg1:_send()
    end

    return Promise.new(function(callback, callback2)
        local success, result = pcall(arg1._send, arg1)

        if success and result.ok then
            callback(result)
        elseif success then
            callback2({ request_sent = true, response = result })
        else
            callback2({ request_sent = false, error = result })
        end
    end)
end

function module.promise(arg1)
    return arg1:send(true)
end

return module
