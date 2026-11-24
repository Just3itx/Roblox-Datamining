-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T13:01:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsChat = script:FindFirstAncestor("FriendsChat")
local FriendsChatParent = FriendsChat.Parent

local React = require(FriendsChatParent.React)
local ReactFocusNavigation = require(FriendsChatParent.ReactFocusNavigation)
local GetFriendsChatNavigationStore = require(FriendsChat.Stores.GetFriendsChatNavigationStore)
local FFlagFriendsChatConversationListFocusNav = require(FriendsChatParent.SharedFlags).FFlagFriendsChatConversationListFocusNav

local function useFocusInputBarOnWindowEnter(tbl1, tbl2)
    local var1 = React.useContext(ReactFocusNavigation.FocusNavigationContext)
    React.useEffect(function()
        if not FFlagFriendsChatConversationListFocusNav or var1 == nil then
            return
        end

        local friendsChatNavigationStore = GetFriendsChatNavigationStore(false)
        local function isInsideWindow(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
            if arg1 == nil then
                return false
            end
            local current = tbl1.current
            local current2 = tbl2.current
            local isDescendantOf = current ~= nil and arg1:IsDescendantOf(current)
            return isDescendantOf or current2 ~= nil and arg1:IsDescendantOf(current2)
        end

        local value = var1.focusedGuiObject:getValue()
        local var2 = var1.focusedGuiObject:subscribe(function(arg1)
            if isInsideWindow(arg1) and value ~= nil and not isInsideWindow(value) then
                friendsChatNavigationStore.requestFocusInputBar()
            end
            value = arg1
        end)
        return function()
            var2:unsubscribe()
        end
    end, { var1 })
end

return useFocusInputBarOnWindowEnter
