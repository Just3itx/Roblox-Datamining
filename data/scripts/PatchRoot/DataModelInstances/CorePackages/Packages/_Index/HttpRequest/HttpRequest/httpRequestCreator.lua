-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:21:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpRequestParent = script:FindFirstAncestor("HttpRequest").Parent
local Promise = require(HttpRequestParent.Promise)

local HttpRequest = require(script.Parent.HttpRequest)

return function(arg1)
    assert(type(arg1.requestFunction) == "function", "Expected requestFunction to be a function")

    return function(str1: string, arg2, arg3)
        assert(type(str1) == "string", "Expected url to be a string")
        assert(type(arg2) == "string", "Expected requestMethod to be a string")
        assert(not arg3 or type(arg3) == "table", "Expected options to be a table")
        arg2 = string.upper(arg2)

        local httpRequest = HttpRequest.new(arg1, str1, arg2, arg3)

        local function cancel()
            httpRequest:cancel()
        end

        return Promise.new(function(arg4, arg5)
            coroutine.wrap(function()
                httpRequest:start(arg4, arg5)
            end)()
        end), cancel
    end
end
