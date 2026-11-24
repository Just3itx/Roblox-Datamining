-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T02:41:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local function makeHttpServiceMock(statusCode: number, arg1)
    local module = { lastRequestParams = nil, lastEncodedBody = nil }

    function module.RequestInternal(arg2, lastRequestParams)
        arg2.lastRequestParams = lastRequestParams
        return {
            Start = function(_, callback)
                task.defer(function()
                    local tbl1 = {
                        Body = HttpService:JSONEncode(arg1 or {}),
                        StatusCode = statusCode
                    }
                    callback(true, tbl1)
                end)
            end
        }
    end

    function module.JSONEncode(arg2, input): string
        arg2.lastEncodedBody = input
        return HttpService:JSONEncode(input)
    end

    function module.JSONDecode(_, input: string)
        return HttpService:JSONDecode(input)
    end

    return module
end

return makeHttpServiceMock
