-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T13:21:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local _LuauPolyfill = require(scriptParentParent.LuauPolyfill)

local Headers = require(script.Parent.Headers).Headers

local Body = require(script.Parent.Body).Body

local Response = setmetatable({}, { __index = Body })
Response.__index = Response

function Response.new(arg1, tbl1)
    local tbl2 = tbl1 or {}
    local self = setmetatable(Body.new(arg1), Response)

    self.status = tbl2.status or 200
    self.statusText = tbl2.statusText or ""
    self.headers = Headers.new(tbl2.headers or {})
    self.headers.guard = "response"
    self.type = "text"
    self.url = ""
    self.redirected = false
    self.ok = self.status >= 200 and self.status < 300
    return self
end

function Response.error()
    local var2 = Response.new(nil, { status = 0 })

    var2.type = "error"
    return var2
end

function Response.redirect(_: string, _: number?)
    error("Response.redirect not implemented")
end

function Response.STATIC_json(_, _)
    error("Response.json static method not implemented")
end

function Response:clone()
    return Response.new(self.body, { status = self.status, statusText = self.statusText, headers = self.headers.headerList })
end

return { Response = Response }
