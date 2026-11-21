-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:31:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommonParent = script:FindFirstAncestor("AuthCommon").Parent

local Url = require(AuthCommonParent.Http).Url
local _Http = require(AuthCommonParent.Http)
local UrlBuilder = require(AuthCommonParent.UrlBuilder).UrlBuilder

return function(arg1, str1: string)
    return arg1(UrlBuilder.new({ base = Url.USERS_URL, path = `users/{str1}` })(), "GET")
end
