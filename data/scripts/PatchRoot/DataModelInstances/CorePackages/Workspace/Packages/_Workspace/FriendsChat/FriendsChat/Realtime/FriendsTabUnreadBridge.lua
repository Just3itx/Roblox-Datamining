-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T13:21:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsChatParent = script:FindFirstAncestor("FriendsChat").Parent

local React = require(FriendsChatParent.React)
local Signals = require(FriendsChatParent.Signals)
local SignalsReact = require(FriendsChatParent.SignalsReact)
local ExpChatShared = require(FriendsChatParent.ExpChatShared)

local InExperienceAppChatModal = require(FriendsChatParent.AppChat.InExperienceAppChatModal)
local AppChatNetworking = require(FriendsChatParent.AppChatNetworking)
local GetFriendsChatRealtimeStore = require(script.Parent.Parent.Stores.GetFriendsChatRealtimeStore)
local GetFriendsChatNavigationStore = require(script.Parent.Parent.Stores.GetFriendsChatNavigationStore)
local FriendsChatTabName = require(script.Parent.Parent.FriendsChatTabName)

local var1 = ExpChatShared.Logger:new(script.Name)

local function FriendsTabUnreadBridge(tbl1)
    local setTabUnread = tbl1.setTabUnread
    local selectedTabName = tbl1.selectedTabName
    local isChatWindowVisible = tbl1.isChatWindowVisible
    local friendsChatRealtimeStore = GetFriendsChatRealtimeStore(false)
    local friendsChatNavigationStore = GetFriendsChatNavigationStore(false)
    local var2 = SignalsReact.useSignalState(friendsChatNavigationStore.getEffectiveConversationId)

    local function readHasLocalUnread(): boolean -- Luacid: Inlined by compiler; 1 call site recovered
        return next(friendsChatRealtimeStore.getLocalUnreadConversationIds(false)) ~= nil
    end

    local bool1 = isChatWindowVisible == true and selectedTabName == FriendsChatTabName
    local bool2 = bool1 and var2 == nil

    React.useEffect(function()
        local function onGlobalCount()
            if bool1 and (InExperienceAppChatModal.default.unreadCount or 0) > 0 then
                InExperienceAppChatModal:setUnreadCount(0)
                AppChatNetworking.http.ClearGlobalUnreadCount():catch(function(arg1)
                    var1:warning(`Failed to clear global unread count: {tostring(arg1)}`)
                end)
            end

            setTabUnread((InExperienceAppChatModal.default.unreadCount or 0) > 0 or not not readHasLocalUnread())
        end

        onGlobalCount()
        local connection = InExperienceAppChatModal.default.unreadCountSignal.Event:Connect(onGlobalCount)
        return function()
            connection:Disconnect()
        end
    end, { bool1, setTabUnread })

    React.useEffect(function()
        local effect = Signals.createEffect(function(arg1)
            local localUnreadConversationIds = friendsChatRealtimeStore.getLocalUnreadConversationIds(arg1)

            local bool3 = bool1

            if bool3 then
                if var2 == nil then
                    bool3 = false
                else
                    bool3 = localUnreadConversationIds[var2] == true
                end
            end

            if bool3 or bool2 and next(localUnreadConversationIds) ~= nil then
                friendsChatRealtimeStore.clearLocalUnread()
            end
            setTabUnread(
                (InExperienceAppChatModal.default.unreadCount or 0) > 0
                    or next(friendsChatRealtimeStore.getLocalUnreadConversationIds(false)) ~= nil
            )
        end)

        return function()
            effect()
        end
    end, {
        bool2,
        bool1,
        var2,
        setTabUnread
    })

    return nil
end

return FriendsTabUnreadBridge
