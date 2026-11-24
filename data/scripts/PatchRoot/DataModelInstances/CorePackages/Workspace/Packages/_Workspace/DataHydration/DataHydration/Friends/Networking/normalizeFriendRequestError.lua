-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:01:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

return function(arg1)
    local statusCode = if type(arg1) == "table" then arg1.StatusCode else nil
    local code = nil
    local body = if type(arg1) == "table" then arg1.Body else nil

    if type(body) == "string" then
        local success, result = pcall(HttpService.JSONDecode, HttpService, body)
        if success and type(result) == "table" then
            local errors = result.errors
            if type(errors) == "table" and errors[1] then
                code = errors[1].code
            end
        end
    end
    return { statusCode = statusCode, firstErrorCode = code }
end
