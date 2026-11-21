-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T01:21:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthSignupParent = script:FindFirstAncestor("AuthSignup").Parent

local HttpService = game:GetService("HttpService")

local Url = require(AuthSignupParent.Http).Url
local var1 = require(AuthSignupParent.UrlBuilder).UrlBuilder.new({ base = Url.USERS_URL, path = "gender" })

return function(arg1, gender: string)
    return arg1(var1(), "POST", { postBody = HttpService:JSONEncode({ gender = gender }) })
end
