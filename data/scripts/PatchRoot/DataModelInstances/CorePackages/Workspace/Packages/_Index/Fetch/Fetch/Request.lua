-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T13:21:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local instanceof = require(scriptParentParent.LuauPolyfill).instanceof

local Headers = require(script.Parent.Headers).Headers

local Body = require(script.Parent.Body).Body

local AbortSignal = require(script.Parent.AbortSignal).AbortSignal

local Request = setmetatable({}, { __index = Body })
Request.__index = Request

function Request.new(arg1, tbl1)
    local tbl2 = tbl1 or {}
    local url = nil
    local var2 = nil

    if type(arg1) == "string" then
        url = arg1
        var2 = {}
    elseif instanceof(arg1, Request) then
        url = arg1.url
        var2 = arg1
    else
        error("The first argument of Request.new() must be a string or Request object")
    end

    local body = if tbl2.body or not instanceof(arg1, Request) then nil else arg1.body
    local self = setmetatable(Body.new(tbl2.body or body), Request)

    self.method = tbl2.method or var2.method or "GET"
    if (tbl2.body or body) and (self.method == "GET" or self.method == "HEAD") then
        error(string.format("'body' should not be provided as an option for request method %s", self.method))
    end

    self.url = url
    local var3 = var2.headers or Headers.new()
    if tbl2.headers then
        var3 = Headers.new(tbl2.headers)
    end

    self.headers = var3
    self.cache = tbl2.cache or var2.cache or Enum.HttpCachePolicy.None
    self.signal = tbl2.signal or var2.signal or AbortSignal.abort("Request Cancelled")

    self.destination = "document"
    self.referrer = "client"
    self.referrerPolicy = "no-referrer"
    self.mode = tbl2.mode or "cors"
    self.credentials = tbl2.credentials or var2.credentials or "omit"
    self.redirect = tbl2.redirect or var2.redirect or "error"
    self.integrity = tbl2.integrity or var2.integrity or ""
    self.keepalive = tbl2.keepalive or var2.keepalive or false
    self.isReloadNavigation = false
    self.isHistoryNavigation = false
    self.duplex = tbl2.duplex or var2.duplex or "half"

    return self
end

function Request.clone(arg1)
    return Request.new(arg1)
end

return { Request = Request }
