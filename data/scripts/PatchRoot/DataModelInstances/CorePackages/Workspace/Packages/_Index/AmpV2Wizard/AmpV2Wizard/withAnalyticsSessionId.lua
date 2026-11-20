-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T21:50:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local function withAnalyticsSessionId(str1: string, input: string?): string
    if input == nil or input == "" then
        return str1
    end

    local var1 = string.find(str1, "#", 1, true)
    local var2 = if var1 == nil then str1 else string.sub(str1, 1, var1 - 1)
    local str2 = if var1 == nil then "" else string.sub(str1, var1)
    if string.match(var2, "[?&]analyticsSessionId=") ~= nil then
        return str1
    end
    return `{var2}{if string.find(var2, "?", 1, true) == nil then "?" else "&"}analyticsSessionId={HttpService:UrlEncode(input)}{str2}`
end

return withAnalyticsSessionId
