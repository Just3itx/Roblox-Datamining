-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:10:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent

local Signals = require(ExpChatParent.Signals)
local SharedFlags = require(ExpChatParent.SharedFlags)

local FriendsChatChannelAdded = require(ExpChat.Actions.FriendsChatChannelAdded)
local FriendsChatChannelRemoved = require(ExpChat.Actions.FriendsChatChannelRemoved)
local GetChannelTabsStore = require(ExpChat.Stores.GetChannelTabsStore)
local GetFriendsTabVisibilityStore = require(ExpChatParent.FriendsChat.GetFriendsTabVisibilityStore)
local FriendsChatTabName = require(ExpChatParent.FriendsChat.FriendsChatTabName)

local FFlagExpChatUseChannelTabsStore = SharedFlags.FFlagExpChatUseChannelTabsStore

local function syncFriendsTabVisibility(arg1)
    local friendsTabVisibilityStore = GetFriendsTabVisibilityStore(false)
    local channelTabsStore = if FFlagExpChatUseChannelTabsStore then GetChannelTabsStore(false) else nil

    return Signals.createEffect(function(arg2)
        if friendsTabVisibilityStore.getIsFriendsTabVisible(arg2) then
            if channelTabsStore then
                channelTabsStore.addChannelTab({ type = "FriendsChat", name = FriendsChatTabName }, nil)
                return
            end
            arg1:dispatch(FriendsChatChannelAdded(FriendsChatTabName))
        elseif channelTabsStore then
            channelTabsStore.handleChannelRemoved(FriendsChatTabName)
        else
            arg1:dispatch(FriendsChatChannelRemoved(FriendsChatTabName))
        end
    end)
end

return syncFriendsTabVisibility
