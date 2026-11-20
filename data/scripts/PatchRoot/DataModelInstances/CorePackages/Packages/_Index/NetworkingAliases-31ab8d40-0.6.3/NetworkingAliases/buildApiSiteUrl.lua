-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T10:50:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ContentProvider = game:GetService("ContentProvider")

local function parseBaseUrlInformation(): (string, string, string)
    local baseUrl = ContentProvider.BaseUrl

    if baseUrl:sub(#baseUrl) ~= "/" then
        baseUrl ..= "/"
    end

    local _, var1 = baseUrl:find("://")
    assert(type(var1) == "number", "Expected schemeEnd to be a number")

    local var2, var3 = baseUrl:find("%.", var1 + 1)
    assert(type(var2) == "number", "Expected prefixIndex to be a number")
    assert(type(var3) == "number", "Expected prefixEnd to be a number")

    return baseUrl, baseUrl:sub(var1 + 1, var2 - 1), (baseUrl:sub(var3 + 1))
end

local _, _, str1 = parseBaseUrlInformation()

return function(str2: string): string
    return string.format("https://%s.%s", str2, str1)
end
