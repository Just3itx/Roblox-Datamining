-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T11:11:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ContentProvider = game:GetService("ContentProvider")

local function parseBaseUrlInformation(): (string, string, string)
    local baseUrl = ContentProvider.BaseUrl

    if baseUrl:sub(#baseUrl) ~= "/" then
        baseUrl ..= "/"
    end

    local _, var1 = baseUrl:find("://")

    local var2, var3 = baseUrl:find("%.", var1 + 1)
    return baseUrl, baseUrl:sub(var1 + 1, var2 - 1), (baseUrl:sub(var3 + 1))
end

local _, _, str1 = parseBaseUrlInformation()

return function(arg1): string
    return string.format("https://%s.%s", arg1, str1)
end
