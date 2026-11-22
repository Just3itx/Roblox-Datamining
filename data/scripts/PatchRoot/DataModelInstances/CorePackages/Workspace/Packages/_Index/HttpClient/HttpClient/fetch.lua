-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T00:41:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _types = require(script.Parent.types)
local createRequest = require(script.Parent.createRequest)
local createRequestInternalNetwork = require(script.Parent.createRequestInternalNetwork)
local withRetry = require(script.Parent.withRetry)
local decoders = require(script.Parent.decoders)
local encoders = require(script.Parent.encoders)
local isSuccess = require(script.Parent.httpStatus).isSuccess
local statusCodeActions = require(script.Parent.statusCodeActions)

local var1 = nil

local function defaultNetwork() -- Luacid: Inlined by compiler; 2 call sites recovered
    if var1 == nil then
        var1 = withRetry(createRequestInternalNetwork())
    end
    return var1
end

local function pickNetwork(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    local network = arg1.network

    if typeof(arg1.retry) == "table" then
        return withRetry(network or createRequestInternalNetwork(), arg1.retry)
    elseif network ~= nil then
        return network
    elseif arg1.retry == false then
        return createRequestInternalNetwork()
    end

    return defaultNetwork()
end

local function asBuffer(responseBody)
    if typeof(responseBody) == "buffer" then
        return responseBody
    end
    return buffer.fromstring(responseBody or "")
end

local function buildProtobufDecoder(decode: (...any) -> (...any)) -- Luacid: Inlined by compiler; 1 call site recovered
    return function(arg1)
        if not isSuccess(arg1.statusCode) then
            return nil, `http {arg1.statusCode}`, arg1.statusCode
        end
        return decode(asBuffer(arg1.responseBody)), nil, nil
    end
end

local function resolveStatusCodeActions(statusCodeActions2) -- Luacid: Inlined by compiler; 1 call site recovered
    local var2 = statusCodeActions.snapshot()
    if var2 == nil then
        return statusCodeActions2
    end
    if statusCodeActions2 ~= nil then
        for k, statusCodeAction in statusCodeActions2 do
            var2[k] = statusCodeAction
        end
    end
    return var2
end

local function fetch(arg1)
    local requestEncoding = arg1.requestEncoding or "json"
    local responseEncoding = arg1.responseEncoding or "json"
    local encode = if requestEncoding == "protobuf" then encoders.encodeRaw("application/x-protobuf") else nil
    local decode = if responseEncoding == "protobuf" then buildProtobufDecoder(arg1.decode) elseif arg1.legacy then decoders.decodeLegacyJson(arg1.decode) else decoders.decodeJson(arg1.decode)
    return createRequest({
        networkImpl = pickNetwork(arg1),
        method = arg1.method,
        url = arg1.url,
        body = arg1.body,
        headers = arg1.headers,
        encode = encode,
        decode = decode,
        analyticsKey = arg1.analyticsKey,
        analytics = arg1.analytics,
        statusCodeActions = resolveStatusCodeActions(arg1.statusCodeActions),
        onMessage = arg1.onMessage,
        priority = arg1.priority
    })
end

return fetch
