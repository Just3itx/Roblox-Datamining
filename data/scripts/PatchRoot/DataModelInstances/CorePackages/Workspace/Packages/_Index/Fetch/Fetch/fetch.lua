-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T13:21:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local Error = require(scriptParentParent.LuauPolyfill).Error

local Promise = require(scriptParentParent.Promise)

local Response = require(script.Parent.Response).Response

local Request = require(script.Parent.Request).Request

local function parseResponse(tbl1) -- Luacid: Inlined by compiler; 1 call site recovered
    local body = tbl1.Body

    return Response.new(body, { status = tbl1.StatusCode, statusText = tbl1.StatusMessage, headers = tbl1.Headers })
end

local function buildFetch(arg1)
    local function fetch(arg2, arg3)
        return Promise.new(function(callback, callback2)
            local success, result = pcall(function()
                return Request.new(arg2, arg3)
            end)
            if not success then
                callback2(Error.new(result))
                return
            end

            arg1:RequestInternal({
                Url = result.url,
                Method = result.method,
                Body = result.body,
                Headers = result.headers.headerList,
                CachePolicy = result.cache
            }):Start(
                function(arg4, arg5)
                    if not arg4 then
                        result.signal:fire()
                        callback2(Error.new(arg5.ErrorMessage))
                        return
                    end

                    local var1 = parseResponse(arg5)
                    callback(var1)
                end
            )
        end)
    end

    return fetch
end

return buildFetch
