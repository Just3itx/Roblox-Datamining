-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T13:11:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsChatParent = script:FindFirstAncestor("FriendsChat").Parent

local React = require(FriendsChatParent.React)
local UserTile = require(FriendsChatParent.UserTile).UserTile
local LayoutMode = require(FriendsChatParent.UserTile).LayoutMode
local escapeRichText = require(FriendsChatParent.ChatUIPrimitives).Utils.escapeRichText

local getFacePileParticipantIds = require(script.Parent.getFacePileParticipantIds)
local useFacePilePresence = require(script.Parent.useFacePilePresence)

local function FriendsChatFacePile(tbl1)
    local bool1 = not (tbl1.participantUserIds == nil) and #tbl1.participantUserIds > 0
    local facePileParticipantIds = getFacePileParticipantIds(tbl1.participantUserIds or {}, tbl1.localUserId)
    local userPresenceType = useFacePilePresence(facePileParticipantIds)

    if not bool1 then
        return nil
    end

    local createElement = React.createElement
    local var2 = UserTile
    local tbl2 = {
        userId = tostring(facePileParticipantIds[1]),
        facePileSecondUserId = if facePileParticipantIds[2] then tostring(facePileParticipantIds[2]) else nil,
        layoutMode = LayoutMode.wide,
        title = if tbl1.titleText then escapeRichText(tbl1.titleText) else tbl1.titleText,
        titleStyle = tbl1.titleStyle,
        userPresenceType = userPresenceType,
        onActivated = tbl1.onActivated,
        selectable = tbl1.selectable,
        customTextTruncation = Enum.TextTruncate.SplitWord
    }
    return createElement(var2, tbl2)
end

return FriendsChatFacePile
