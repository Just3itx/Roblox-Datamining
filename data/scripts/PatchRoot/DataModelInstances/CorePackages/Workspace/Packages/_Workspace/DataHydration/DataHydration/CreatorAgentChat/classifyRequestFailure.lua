-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:21:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RequestFailureKind = require(script.Parent.types).RequestFailureKind

local function classifyRequestFailure(arg1)
    if arg1.status == "pending" then
        return {
            kind = RequestFailureKind.Timeout
        }
    end

    local response = arg1.response

    if arg1.errorCode ~= nil then
        return {
            kind = RequestFailureKind.RpcError,
            httpStatusCode = if response == nil then nil else response.statusCode
        }
    end

    if response ~= nil then
        if response.wasTransportFailure then
            return {
                kind = RequestFailureKind.Transport
            }
        end

        if response.statusCode < 200 or response.statusCode >= 300 then
            return {
                kind = RequestFailureKind.Http,
                httpStatusCode = response.statusCode
            }
        end

        return {
            kind = RequestFailureKind.Unknown
        }
    end

    local error = arg1.error
    if error ~= nil then
        if string.sub(error, 1, 16) == "transport error:" then
            return {
                kind = RequestFailureKind.Transport
            }
        end

        local httpStatusCode = tonumber((string.match(error, "^CAS HTTP (%d+)")))
        if httpStatusCode ~= nil then
            return {
                kind = RequestFailureKind.Http,
                httpStatusCode = httpStatusCode
            }
        end
    end

    return {
        kind = RequestFailureKind.Unknown
    }
end

return classifyRequestFailure
