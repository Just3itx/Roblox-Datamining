-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:40:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommonParent = script:FindFirstAncestor("AuthCommon").Parent

local HttpService = game:GetService("HttpService")
local UrlBuilder = require(AuthCommonParent.UrlBuilder).UrlBuilder

return function(arg1, code: string)
    assert(type(code) == "string", "invalid login code")
    local string2 = UrlBuilder.fromString("apis:auth-token-service/v1/login/entercode")
    local postBody = HttpService:JSONEncode({ code = code })

    return arg1(string2(), "POST", { postBody = postBody })
end
