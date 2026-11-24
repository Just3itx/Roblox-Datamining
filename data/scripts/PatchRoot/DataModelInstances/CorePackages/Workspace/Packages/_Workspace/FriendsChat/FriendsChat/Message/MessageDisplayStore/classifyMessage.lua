-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T13:20:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function isPartySystemMessage(arg1)
    local cards = arg1.cards
    if type(cards) ~= "table" then
        return false
    end
    for _, card in cards do
        if type(card) ~= "table" or type(card.components) ~= "table" then
            continue
        end

        for _, component in card.components do
            if type(component) ~= "table" then
                continue
            end

            local type = component.type
            if type == "group_up" or type == "scheduled_group_up" then
                return true
            end
        end
    end

    return false
end

local function getSystemMessageBody(arg1) -- Luacid: unused: defined but never referenced
    local cards = arg1.cards
    local card = if type(cards) == "table" then cards[1] else nil
    return if type(card) == "table" and type(card.alt_text) == "string" and card.alt_text ~= "" then card.alt_text else arg1.content or ""
end

local function classifySystemMessage(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    local tbl1 = { kind = "systemMessage", body = 0, variant = 0 }
    local cards = arg1.cards
    local card = if type(cards) == "table" then cards[1] else nil
    tbl1.body = if type(card) == "table" and type(card.alt_text) == "string" and card.alt_text ~= "" then card.alt_text else arg1.content or ""
    tbl1.variant = if isPartySystemMessage(arg1) then "party" else "default"
    return tbl1
end

local function classifyMessage(arg1)
    if arg1.type == "system" or arg1.sender_user_id == nil then
        local tbl1 = classifySystemMessage(arg1)
        return { tbl1 }
    end

    local senderUserId = arg1.sender_user_id

    local result = {}

    local repliesTo = arg1.replies_to
    if type(repliesTo) == "table" and repliesTo.sender_user_id ~= nil then
        table.insert(result, { kind = "replyHeader", senderUserId = senderUserId, repliedToUserId = repliesTo.sender_user_id })
    end

    local status = arg1.status
    local moderated = status == "Moderated" or status == "Failed"

    if arg1.visibility == "hidden" then
        table.insert(result, { kind = "hiddenUser", senderUserId = senderUserId })
    else
        table.insert(result, {
            kind = "userText",
            senderUserId = senderUserId,
            body = arg1.content or "",
            moderated = moderated,
            messageId = arg1.id
        })
    end

    if moderated then
        table.insert(result, { kind = "moderationNotice" })
    end

    return result
end

return classifyMessage
