-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T13:01:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsChat = script:FindFirstAncestor("FriendsChat")
local FriendsChatParent = FriendsChat.Parent
local React = require(FriendsChatParent.React)
local Signals = require(FriendsChatParent.Signals)

local GetFriendsChatNavigationStore = require(FriendsChat.Stores.GetFriendsChatNavigationStore)
local isFocusRequestFresh = require(FriendsChat.Focus.isFocusRequestFresh)

local function useConsumeFocusInputBarRequest(callback: (...any) -> (...any))
    React.useEffect(function()
        local friendsChatNavigationStore = GetFriendsChatNavigationStore(false)
        return Signals.createEffect(function(arg1)
            local focusInputBarRequestTime = friendsChatNavigationStore.getFocusInputBarRequestTime(arg1)
            if focusInputBarRequestTime == nil then
                return
            end
            if isFocusRequestFresh(focusInputBarRequestTime, os.clock(), 5) then
                callback()
            end
            friendsChatNavigationStore.clearFocusInputBarRequest()
        end)
    end, { callback })
end

return useConsumeFocusInputBarRequest
