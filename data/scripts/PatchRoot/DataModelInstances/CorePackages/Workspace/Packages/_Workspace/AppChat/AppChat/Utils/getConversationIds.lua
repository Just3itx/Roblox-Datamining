-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:40:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function getConversationIds(tbl1)
    local conversationIds = ({})
    for value, value2 in tbl1 do
        local id = value2.id
        conversationIds[value] = tostring(id)
    end
    return conversationIds
end

return getConversationIds
