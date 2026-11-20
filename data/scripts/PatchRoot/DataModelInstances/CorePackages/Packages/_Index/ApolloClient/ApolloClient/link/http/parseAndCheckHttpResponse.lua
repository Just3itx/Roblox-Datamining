-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:51:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local LuauPolyfill = require(scriptParentParentParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Error = LuauPolyfill.Error

local _Response = require(scriptParentParentParent.luaUtils.Response)

local HttpService = game:GetService("HttpService")

local module = {}

local _types = require(script.Parent.Parent.core.types)

local throwServerError = require(script.Parent.Parent.utils).throwServerError
local hasOwnProperty = require(scriptParentParentParent.luaUtils.hasOwnProperty)

function module.parseAndCheckHttpResponse(arg1)
    return function(response)
        return response:text():andThen(function(input: string)
            local success, result = pcall(function()
                return HttpService:JSONDecode(input), true
            end)
            if not success then
                local error2 = Error.new(result)
                error2.name = "ServerParseError"
                error2.response = response
                error2.statusCode = response.status
                error2.bodyText = input
                error(error2)
            end

            return result
        end):andThen(function<T>(arg2: T): T
            if response.status ~= nil and response.status >= 300 then
                local var1 = throwServerError
                local var2 = response

                local status = response.status
                var1(var2, arg2, ("Response not successful: Received status code %s"):format(tostring(status)))
            end

            if not (Array.isArray(arg2) or hasOwnProperty(arg2, "data") or hasOwnProperty(arg2, "errors")) then
                throwServerError(
                    response,
                    arg2,
                    ("Server response was missing for query '%s'."):format(
                        Array.isArray(arg1) and Array.join(Array.map(arg1, function(arg3)
                            return arg3.operationName
                        end), ", ") or arg1.operationName
                    )
                )
            end
            return arg2
        end)
    end
end

return module
