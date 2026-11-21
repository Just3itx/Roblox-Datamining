-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T01:21:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthSignupParent = script:FindFirstAncestor("AuthSignup").Parent

local HttpService = game:GetService("HttpService")
local UrlBuilder = require(AuthSignupParent.UrlBuilder).UrlBuilder

return function(arg1, username: string, birthday: string)
    assert(type(username) == "string", "invalid username")
    assert(type(birthday) == "string", "invalid birthday")

    local string2 = UrlBuilder.fromString("auth:v1/validators/username")

    local postBody = HttpService:JSONEncode({ username = username, birthday = birthday })

    return arg1(string2(), "POST", { postBody = postBody, maxRetryCount = 0 })
end
