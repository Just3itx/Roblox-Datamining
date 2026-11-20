-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:30:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local getHeaders = require(script.Parent.Util.getHeaders)
local getPostBody = require(script.Parent.Util.getPostBody)

return function(url, method, arg1)
    return {
        Start = function(_, callback)
            local success, result = pcall(function()
                return HttpService:RequestAsync(
                    {
                        Url = url,
                        Method = method,
                        Body = getPostBody(arg1.postBody, method),
                        Headers = getHeaders(arg1.headers, method)
                    }
                )
            end)
            callback(success, result)
        end,
        Cancel = function() end
    }
end
