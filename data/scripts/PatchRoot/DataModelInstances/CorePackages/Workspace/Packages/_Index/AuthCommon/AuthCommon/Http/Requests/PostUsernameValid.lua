-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:40:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommon = script:FindFirstAncestor("AuthCommon")
local HttpService = game:GetService("HttpService")
local AuthCommonParent = AuthCommon.Parent
local UrlBuilder = require(AuthCommonParent.UrlBuilder).UrlBuilder
local UsernameValidationContext = require(AuthCommon.Enums.UsernameValidationContext)

return function(arg1, username, birthday, context)
    context = context or UsernameValidationContext.Unknown

    assert(type(username) == "string", "invalid username")
    assert(type(birthday) == "string", "invalid birthday")

    local string2 = UrlBuilder.fromString("auth:v2/usernames/validate")

    local postBody = HttpService:JSONEncode({ username = username, birthday = birthday, context = context })

    return arg1(string2(), "POST", { postBody = postBody })
end
