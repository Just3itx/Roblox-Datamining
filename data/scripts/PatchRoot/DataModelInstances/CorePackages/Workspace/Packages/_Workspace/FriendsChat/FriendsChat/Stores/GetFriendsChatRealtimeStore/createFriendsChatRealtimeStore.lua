-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T13:21:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsChatParent = script:FindFirstAncestor("FriendsChat").Parent
local createSignal = require(FriendsChatParent.Signals).createSignal

return function()
    local getHasEnteredFriendsTab, var2 = createSignal(false)
    local getActiveConversationId, var4 = createSignal(nil)

    local getLocalUnreadConversationIds, var6 = createSignal({})

    return {
        getHasEnteredFriendsTab = getHasEnteredFriendsTab,
        getActiveConversationId = getActiveConversationId,
        getLocalUnreadConversationIds = getLocalUnreadConversationIds,
        markFriendsTabEntered = function()
            var2(true)
        end,
        setActiveConversationId = function(str1: string?)
            var4(str1)
        end,
        addLocalUnread = function(str1: string)
            var6(function(arg1)
                if arg1[str1] then
                    return arg1
                end
                local var7 = table.clone(arg1)
                var7[str1] = true
                return var7
            end)
        end,
        clearLocalUnread = function()
            var6(function(arg1)
                return if next(arg1) == nil then arg1 else {}
            end)
        end
    }
end
