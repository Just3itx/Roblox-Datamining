-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T23:49:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GroupPeekSduiParent = script:FindFirstAncestor("GroupPeekSdui").Parent

local UrlBuilder = require(GroupPeekSduiParent.UrlBuilder).UrlBuilder
local Url = require(GroupPeekSduiParent.Http).Url

local function getAnnouncementReactionUrl(tbl1)
    return UrlBuilder.new({
        base = Url.GROUPS_URL,
        path = "v1/groups/{groupId}/announcements/{announcementId}/messages/{messageId}/reactions/{emoteId}"
    })(
        tbl1
    )
end
return getAnnouncementReactionUrl
