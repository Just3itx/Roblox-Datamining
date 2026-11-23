-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T04:11:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local function getAuthorizedVideoUri(str1: string, input: string?): string
    if input == nil or input == "" then
        return str1
    end

    return `{str1}&accessContext={HttpService:UrlEncode(input)}`
end

return getAuthorizedVideoUri
