-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:40:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommonParent = script:FindFirstAncestor("AuthCommon").Parent

local HttpService = game:GetService("HttpService")

local Url = require(AuthCommonParent.Http).Url
local _Http = require(AuthCommonParent.Http)
local var1 = require(AuthCommonParent.UrlBuilder).UrlBuilder.new({ base = Url.USERS_URL, path = "usernames/users" })

return function(arg1, str1: string, excludeBannedUsers: boolean?)
    return arg1(
        var1(),
        "POST",
        {
            postBody = HttpService:JSONEncode({ usernames = { str1 }, excludeBannedUsers = excludeBannedUsers or false })
        }
    )
end
