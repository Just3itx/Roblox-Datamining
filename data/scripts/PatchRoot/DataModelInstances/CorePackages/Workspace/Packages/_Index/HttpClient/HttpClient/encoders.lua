-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T00:41:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local _types = require(script.Parent.types)

return {
    encodeJson = function(input): (string, string)
        return HttpService:JSONEncode(input), "application/json"
    end,
    encodeRaw = function(str1: string)
        return function<T>(arg1: T)
            local str2 = typeof(arg1)
            if str2 ~= "string" and str2 ~= "buffer" then
                error(`encodeRaw: expected string or buffer body, got {str2}`)
            end
            return arg1, str1
        end
    end
}
