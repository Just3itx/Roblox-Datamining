-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T13:20:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsChatParent = script:FindFirstAncestor("FriendsChat").Parent

local GetConversationMessageStore = require(FriendsChatParent.AppChat.GetConversationMessageStore)

local function messageSortTime(arg1): number -- Luacid: Inlined by compiler; 1 call site recovered
    local createdAt = if arg1 then arg1.created_at else nil

    if createdAt == nil then
        return math.huge
    end
    local dateTime = DateTime.fromIsoDate(createdAt)
    if dateTime then
        return dateTime.UnixTimestampMillis
    end
    local var1 = tonumber(createdAt)
    return if var1 then var1 * 1000 else math.huge
end

local function createFrozenSortTimes(tbl1)
    local tbl2 = ({})
    local now = if tbl1 == nil then nil else tbl1.now

    return function(str1: string, arg1)
        local var1 = tbl2[str1]
        if var1 ~= nil then
            return var1
        end
        local var2 = GetConversationMessageStore(arg1).getMessage(str1, arg1)
        if var2 == nil then
            return math.huge
        end

        local num1 = messageSortTime(var2)

        if num1 == math.huge and now ~= nil then
            num1 = now()
        end
        tbl2[str1] = num1
        return num1
    end
end

return createFrozenSortTimes
