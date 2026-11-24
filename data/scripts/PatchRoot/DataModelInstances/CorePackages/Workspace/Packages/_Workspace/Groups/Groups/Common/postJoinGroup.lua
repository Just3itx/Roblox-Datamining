-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T17:40:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Groups = script:FindFirstAncestor("Groups")

local HttpService = game:GetService("HttpService")

local GroupsParent = Groups.Parent
local UrlBuilder = require(GroupsParent.UrlBuilder).UrlBuilder
local Url = require(GroupsParent.Http).Url

return function(arg1, num1: number)
    local string2 = UrlBuilder.fromString(Url.GROUPS_URL .. "v1/groups/{id}/users")

    local postBody = HttpService:JSONEncode({})

    return arg1(string2({ id = tostring(num1) }), "POST", { postBody = postBody }):andThen(function(arg2)
        return arg2.responseBody
    end)
end
