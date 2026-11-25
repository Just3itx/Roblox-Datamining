-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T20:01:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local function buildQueryString(tbl1): string
    local tbl2 = {}
    for k, value in pairs(tbl1) do
        local format = string.format
        local str1 = HttpService:UrlEncode(tostring(k))
        local httpService = HttpService
        local input = tostring(value)
        table.insert(tbl2, format("%s=%s", str1, httpService:UrlEncode(input)))
    end

    if #tbl2 == 0 then
        return ""
    end

    return "?" .. table.concat(tbl2, "&")
end

return buildQueryString
