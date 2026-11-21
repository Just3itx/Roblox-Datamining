-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:40:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommonParent = script:FindFirstAncestor("AuthCommon").Parent
local HttpService = game:GetService("HttpService")
local UrlBuilder = require(AuthCommonParent.UrlBuilder).UrlBuilder

return function(arg1, username: string, password: string)
    assert(type(username) == "string", "invalid username")
    assert(type(password) == "string", "invalid password")

    local string2 = UrlBuilder.fromString("auth:v2/passwords/validate")

    local postBody = HttpService:JSONEncode({ username = username, password = password })

    return arg1(string2(), "POST", { postBody = postBody })
end
