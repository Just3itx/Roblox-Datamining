-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:30:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpRequestParent = script:FindFirstAncestor("HttpRequest").Parent
local Cryo = require(HttpRequestParent.Cryo)

return function(url, method, arg1)
    return {
        Start = function(_, callback)
            local tbl1 = {}
            if type(arg1.mockResponse) == "function" then
                tbl1 = arg1.mockResponse()
            elseif arg1.mockResponse then
                tbl1 = arg1.mockResponse
            end

            local var1 = Cryo.Dictionary.join({ Url = url, Method = method }, tbl1)

            callback(arg1.success, var1)
        end,
        Cancel = function()
            if arg1.cancel then
                arg1.cancel()
            end
        end
    }
end
