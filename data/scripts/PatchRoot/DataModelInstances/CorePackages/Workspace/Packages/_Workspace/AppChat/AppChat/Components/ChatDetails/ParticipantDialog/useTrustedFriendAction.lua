-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:00:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local React = require(AppChatParent.React)
local useLocalization = require(AppChatParent.Localization).Hooks.useLocalization

local getTrustedFriendAction = require(script.Parent.getTrustedFriendAction)

local function useTrustedFriendAction(str1: string)
    local action, var2 = React.useState(nil)
    local var3, var4 = React.useState(0)

    local var5 = useLocalization({
        addTrustedFriendText = "Feature.Friends.TrustedFriend.Label.AddTrustedFriend",
        acceptTrustedFriendText = "Feature.Friends.TrustedFriend.AcceptTrustedRequest",
        removeTrustedFriendText = "Feature.Friends.TrustedFriend.Action.RemoveTrustedFriend",
        removeTrustedFriendToastText = "Feature.Friends.TrustedFriend.Toast.TrustedFriendRemoved"
    })

    local refetch = React.useCallback(function()
        var4(function(arg1): number
            return arg1 + 1
        end)
    end, {})

    React.useEffect(function()
        if str1 == "" then
            var2(nil)
            return
        end

        local bool1 = true
        var2(nil)

        getTrustedFriendAction(str1):andThen(function(arg1)
            if bool1 then
                var2(arg1)
            end
        end):catch(function()
            if bool1 then
                var2(nil)
            end
        end)

        return function()
            bool1 = false
        end
    end, { str1, var3 })

    local actionType = if action == nil then nil else action.actionType
    return {
        action = action,
        actionText = if actionType == "RemoveTrustedConnection" then var5.removeTrustedFriendText elseif actionType == "AddIncomingTrustedConnection" then var5.acceptTrustedFriendText elseif actionType == "AddTrustedConnection" then var5.addTrustedFriendText else nil,
        toastText = var5.removeTrustedFriendToastText,
        refetch = refetch
    }
end

return useTrustedFriendAction
