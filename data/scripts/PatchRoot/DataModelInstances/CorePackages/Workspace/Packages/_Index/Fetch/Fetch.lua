-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T13:21:15Z
-- Luau bytecode version: 14 | Luau type version: 3
local scriptParent = script.Parent
local _LuauPolyfill = require(scriptParent.LuauPolyfill)

local Headers = require(script.Headers).Headers

local Request = require(script.Request).Request

local Response = require(script.Response).Response

local Body = require(script.Body).Body

local fetch = require(script.fetch)
return {
    Headers = Headers,
    Request = Request,
    Response = Response,
    Body = Body,
    fetch = fetch(game:GetService("HttpService")),
    buildFetch = fetch,
    AbortSignal = require(script.AbortSignal).AbortSignal
}
