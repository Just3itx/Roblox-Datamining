-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:40:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommonParent = script:FindFirstAncestor("AuthCommon").Parent

local HttpService = game:GetService("HttpService")
local UrlBuilder = require(AuthCommonParent.UrlBuilder).UrlBuilder
local Promise = require(AuthCommonParent.Promise)

return function(arg1, code, privateKey)
    if type(code) == "string" and type(privateKey) == "string" then
        local string2 = UrlBuilder.fromString("apis:auth-token-service/v1/login/status")
        local postBody = HttpService:JSONEncode({ code = code, privateKey = privateKey })

        return arg1(string2(), "POST", { postBody = postBody })
    elseif type(code) ~= "string" then
        return Promise.reject("invalid login code")
    else
        return Promise.reject("invalid private key")
    end
end
