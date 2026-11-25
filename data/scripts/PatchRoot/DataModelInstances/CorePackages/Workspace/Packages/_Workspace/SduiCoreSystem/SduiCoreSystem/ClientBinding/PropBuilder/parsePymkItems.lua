-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T09:50:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function parsePymkItems(arg1)
    if typeof(arg1) ~= "table" then
        return nil
    end

    local var1 = arg1.items or arg1
    if typeof(var1) ~= "table" then
        return nil
    end

    local result = {}
    for rank, value2 in var1 do
        if typeof(value2) ~= "table" then
            continue
        end

        local itemId = value2.item_id
        if itemId == nil or itemId == "" then
            continue
        end

        table.insert(
            result,
            {
                id = tostring(itemId),
                rank = rank,
                hasPendingFriendRequest = value2.has_pending_friend_request == true
            }
        )
    end

    return result
end

return parsePymkItems
