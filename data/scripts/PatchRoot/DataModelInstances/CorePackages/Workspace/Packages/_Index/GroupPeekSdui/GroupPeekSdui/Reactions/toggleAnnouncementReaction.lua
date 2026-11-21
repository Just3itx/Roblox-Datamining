-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T23:49:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GroupPeekSdui = script:FindFirstAncestor("GroupPeekSdui")
local GroupPeekSduiParent = GroupPeekSdui.Parent

local Promise = require(GroupPeekSduiParent.Promise)
local _SduiSharedContent = require(GroupPeekSduiParent.SduiSharedContent)

local AnnouncementReactionRequests = require(GroupPeekSdui.Reactions.AnnouncementReactionRequests)

return function(arg1)
    local tbl1 = string.split(arg1.entityId, "/")
    if #tbl1 ~= 3 or table.find(tbl1, "") ~= nil then
        return Promise.reject(`entityId must be groupId/announcementId/messageId: {arg1.entityId}`)
    end

    local tbl2 = {
        groupId = tbl1[1],
        announcementId = tbl1[2],
        messageId = tbl1[3],
        emoteId = arg1.emoteId
    }
    if arg1.shouldAdd then
        return (AnnouncementReactionRequests.addAnnouncementReaction(tbl2))
    end

    return (AnnouncementReactionRequests.removeAnnouncementReaction(tbl2))
end
