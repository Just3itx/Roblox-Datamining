-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:31:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local lib = script.lib
local src = script.src

local html = require(lib.html)

local request = require(src.request)
local session = require(src.session)
local form = require(src.form)
local ratelimit = require(src.ratelimit)
local util = require(src.util)
local fetch = require(src.fetch)

local module = {
    VERSION = "0.5.4",
    Request = request.new,
    Session = session.new,
    FormData = form.FormData.new,
    File = form.File.new,
    cache = require(src.cache)
}
function module.request(arg1, arg2, arg3)
    return request.new(arg1, arg2, arg3 or {}):send()
end
module.send = util.deprecate(module.request, "0.5", "http.send")

function module.promise_request(arg1, arg2, arg3)
    return request.new(arg1, arg2, arg3 or {}):send(true)
end
module.promise_send = util.deprecate(module.promise_request, "0.5", "http.promise_send")

module.fetch = fetch(module.promise_request)

for _, value in pairs({ "GET", "POST", "HEAD", "OPTIONS", "PUT", "DELETE", "PATCH" }) do
    module[value:lower()] = function(arg1, arg2)
        return module.request(value, arg1, arg2)
    end

    module["promise_" .. value:lower()] = function(arg1, arg2)
        return module.promise_request(value, arg1, arg2)
    end
end

function module.set_ratelimit(arg1, arg2)
    local var1 = ratelimit.get("http", arg1, arg2)

    print("[http] RateLimiter settings changed: ", var1.rate, "reqs /", var1.window_size, "secs")
end

function module.parse_html(arg1, arg2)
    return html.parse(arg1, 100000, arg2)
end

module.parse_xml = module.parse_html

return module
