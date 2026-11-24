-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T13:01:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsChatParent = script:FindFirstAncestor("FriendsChat").Parent

local React = require(FriendsChatParent.React)
local ChatUIPrimitives = require(FriendsChatParent.ChatUIPrimitives)
local useFocusGuiObject = require(FriendsChatParent.ReactFocusNavigation).useFocusGuiObject
local getFirstFocusableDescendant = require(FriendsChatParent.FocusNavigationUtils).getFirstFocusableDescendant
local FFlagFriendsChatConversationListFocusNav = require(FriendsChatParent.SharedFlags).FFlagFriendsChatConversationListFocusNav

local function useFocusConversationInput(tbl1, bool1: boolean, tbl2)
    local var1 = ChatUIPrimitives.Hooks.useFocusInputBar()
    local focus = var1.focus
    if FFlagFriendsChatConversationListFocusNav then
        local var2 = useFocusGuiObject()

        focus = React.useCallback(function()
            if bool1 then
                var1.focus()
                return
            end

            local current = if tbl2 == nil then nil else tbl2.current
            local current2 = if tbl1 == nil then nil else tbl1.current

            if current == nil and current2 ~= nil then
                current = getFirstFocusableDescendant(current2)
            end
            if current ~= nil then
                var2(current)
            end
        end, {
            bool1,
            var1.focus,
            var2,
            tbl1,
            tbl2
        })
    end
    return {
        ref = var1.ref,
        focus = focus
    }
end

return useFocusConversationInput
