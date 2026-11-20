-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:30:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

return function(arg1, arg2)
    if arg2 == "POST" or arg2 == "PATCH" then
        if type(arg1) == "table" then
            return HttpService:JSONEncode(arg1)
        end

        if type(arg1) == "string" then
            return arg1
        end
        error("Expected postBody to be a string or table")
    end

    return nil
end
