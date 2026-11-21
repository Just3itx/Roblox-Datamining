-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T23:49:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GroupPeekSduiParent = script:FindFirstAncestor("GroupPeekSdui").Parent

local UrlBuilder = require(GroupPeekSduiParent.UrlBuilder).UrlBuilder
local Url = require(GroupPeekSduiParent.Http).Url

local function getGroupPeekPageUrl(groupId: string)
    return UrlBuilder.new({ base = Url.GROUPS_URL, path = "v1/groups/{groupId}/pages/peek" })({ groupId = groupId })
end

return getGroupPeekPageUrl
