-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T13:20:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChatConversationListAdapter = require(script.Parent.Parent.ConversationList.ExpChatConversationListAdapter)

local function getParticipantUserIds(tbl1)
    local participantUserIds = {}
    local participants = tbl1.participants
    if participants == nil then
        return participantUserIds
    end

    for _, participant in participants do
        local var1 = tonumber(participant)
        if var1 ~= nil then
            table.insert(participantUserIds, var1)
        end
    end
    return participantUserIds
end

local function getFriendsChatHeaderProps(tbl1, _: number)
    return {
        participantUserIds = getParticipantUserIds(tbl1),
        titleText = ExpChatConversationListAdapter.getConversationTitle(tbl1)
    }
end

return getFriendsChatHeaderProps
