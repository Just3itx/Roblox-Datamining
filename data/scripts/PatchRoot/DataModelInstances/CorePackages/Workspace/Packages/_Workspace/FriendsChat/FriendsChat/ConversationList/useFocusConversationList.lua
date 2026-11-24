-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T13:01:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsChatParent = script:FindFirstAncestor("FriendsChat").Parent

local React = require(FriendsChatParent.React)
local useStableSignal = require(FriendsChatParent.ChatUIPrimitives).Hooks.useStableSignal
local ReactFocusNavigation = require(FriendsChatParent.ReactFocusNavigation)
local useFocusGuiObject = ReactFocusNavigation.useFocusGuiObject
local useContainerFocusBehavior = ReactFocusNavigation.useContainerFocusBehavior

local FFlagFriendsChatConversationListFocusNav = require(FriendsChatParent.SharedFlags).FFlagFriendsChatConversationListFocusNav
local useConsumeFocusConversationListRequest = require(script.Parent.useConsumeFocusConversationListRequest)

local function useFocusConversationList(func1: (...any) -> (...any))
    local var1, var2

    if FFlagFriendsChatConversationListFocusNav then
        local var3 = useFocusGuiObject()
        local var4
        var4, var1 = useStableSignal(nil)

        local var5 = React.useCallback(function(arg1)
            func1(false).resetAllTransparency()
            var3(arg1)
        end, { func1, var3 })

        useConsumeFocusConversationListRequest(var4, var5)

        local var6 = React.useMemo(function()
            return {
                getTargets = function(): {[any]: any} | {any}
                    local var6 = var4(false)
                    return if var6 == nil then {} else { var6 }
                end
            }
        end, { var4 })

        var2 = useContainerFocusBehavior(var6, nil)
    else
        var2 = nil
        var1 = nil
    end
    return var2, var1
end

return useFocusConversationList
