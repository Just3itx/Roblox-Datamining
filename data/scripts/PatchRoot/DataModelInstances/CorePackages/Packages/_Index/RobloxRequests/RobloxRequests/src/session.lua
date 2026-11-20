-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:31:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local _lib = scriptParentParent.lib
local src = scriptParentParent.src

local request = require(src.request)
local cookies = require(src.cookies)
local ratelimit = require(src.ratelimit)
local util = require(src.util)

local function randomString(num1: number): string
    local str1 = ""

    for _ = 1, num1 do
        str1 ..= string.char(math.random(97, 122))
    end

    return str1
end

local module = {}
module.__index = module
function module.new(baseUrl)
    local self = setmetatable({}, module)

    self.headers = {}
    self.cookies = cookies.new()

    self.base_url = baseUrl or ""

    self._ratelimit = nil
    self.ignore_ratelimit = false

    self.before_request = nil
    self.after_request = nil

    self.no_stats = false

    self.log = true

    return self
end

function module:set_ratelimit(arg1, arg2)
    if not arg1 then
        self:disable_ratelimit()
    end

    arg2 = arg2 or 60

    if self._ratelimit then
        ratelimit.ratelimit[self._ratelimit.id] = nil
    end

    local str1 = "http.session-" .. randomString(12)

    self._ratelimit = ratelimit.get(str1, arg1, arg2)
end

function module:disable_ratelimit()
    if self._ratelimit then
        ratelimit.ratelimit[self._ratelimit.id] = nil
        self._ratelimit = nil
    end
end

function module:set_headers(arg1)
    for k, value in pairs(arg1) do
        self.headers[k] = value
    end

    return self
end

function module:Request(arg1, arg2, arg3)
    arg3 = arg3 or {}

    if arg2:sub(1, 7) ~= "http://" and arg2:sub(1, 8) ~= "https://" then
        arg2 = self.base_url .. arg2
    end

    local log = self.log
    if arg3.log ~= nil then
        log = arg3.log
    end

    local request2 = request.new(arg1, arg2, {
        headers = self.headers,
        query = arg3.query,
        data = arg3.data,
        log = log,
        cookies = arg3.cookies or self.cookies,
        ignore_ratelimit = arg3.ignore_ratelimit or self.ignore_ratelimit,
        no_stats = self.no_stats or false
    })

    if self._ratelimit then
        table.insert(request2._ratelimits, self._ratelimit)
    end

    request2:set_headers(arg3.headers or {})

    function request2._callback(arg4)
        for _, value in ipairs(arg4.cookies.cookies) do
            table.insert(self.cookies.cookies, value)
        end
    end

    return request2
end

function module.request(arg1, arg2, arg3, arg4)
    return arg1:Request(arg2, arg3, arg4 or {}):send()
end
module.send = util.deprecate(module.request, "0.5", "Session:send")

function module.promise_request(arg1, arg2, arg3, arg4)
    return arg1:Request(arg2, arg3, arg4 or {}):send(true)
end
module.promise_send = util.deprecate(module.promise_request, "0.5", "Session:promise_send")

for _, value in pairs({ "GET", "POST", "HEAD", "OPTIONS", "PUT", "DELETE", "PATCH" }) do
    module[value:lower()] = function(arg1, arg2, arg3)
        return arg1:send(value, arg2, arg3)
    end

    module["promise_" .. value:lower()] = function(arg1, arg2, arg3)
        return arg1:promise_send(value, arg2, arg3)
    end
end

return module
