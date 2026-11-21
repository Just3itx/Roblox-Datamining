-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:31:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommonParent = script:FindFirstAncestor("AuthCommon").Parent

local HttpService = game:GetService("HttpService")

local UrlBuilder = require(AuthCommonParent.UrlBuilder).UrlBuilder

return function(arg1)
    local string2 = UrlBuilder.fromString("auth:/v1/logoutfromallsessionsandreauthenticate")
    local postBody = HttpService:JSONEncode({
        SecureAuthenticationIntent = {
            clientPublicKey = "",
            clientEpochTimestamp = "",
            saiSignature = "",
            serverNonce = ""
        }
    })

    return arg1(string2(), "POST", { postBody = postBody })
end
