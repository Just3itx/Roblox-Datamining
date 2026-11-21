-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:31:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommonParent = script:FindFirstAncestor("AuthCommon").Parent

local HttpService = game:GetService("HttpService")

local UrlBuilder = require(AuthCommonParent.UrlBuilder).UrlBuilder

return function(arg1, encryptedUsersDataBlob)
    local string2 = UrlBuilder.fromString("apis:account-switcher/v1/logoutAllLoggedInUsers")
    local postBody = HttpService:JSONEncode({ encrypted_users_data_blob = encryptedUsersDataBlob })

    return arg1(string2(), "POST", { postBody = postBody })
end
