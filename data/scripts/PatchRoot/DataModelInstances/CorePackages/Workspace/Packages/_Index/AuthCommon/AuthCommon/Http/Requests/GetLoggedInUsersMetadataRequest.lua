-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:31:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommonParent = script:FindFirstAncestor("AuthCommon").Parent

local HttpService = game:GetService("HttpService")

local UrlBuilder = require(AuthCommonParent.UrlBuilder).UrlBuilder

return function(arg1, encryptedUsersDataBlob)
    local string2 = UrlBuilder.fromString("apis:account-switcher/v1/getLoggedInUsersMetadata")
    local postBody = HttpService:JSONEncode({ encrypted_users_data_blob = encryptedUsersDataBlob, remove_invalid_active_user = false })

    return arg1(string2(), "POST", { postBody = postBody })
end
