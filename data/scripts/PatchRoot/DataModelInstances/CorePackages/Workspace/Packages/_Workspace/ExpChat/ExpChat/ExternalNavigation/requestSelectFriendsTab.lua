-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T08:11:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent

local ExpChatShared = require(ExpChatParent.ExpChatShared)
local SharedFlags = require(ExpChatParent.SharedFlags)
local FriendsChatTabName = require(ExpChatParent.FriendsChat.FriendsChatTabName)
local requestSelectTab = require(ExpChat.ExternalNavigation.requestSelectTab)

local FriendsChatChannelSelected = ExpChatShared.Actions.FriendsChatChannelSelected
local FFlagExpChatUseChannelTabsStore = SharedFlags.FFlagExpChatUseChannelTabsStore
local FFlagExpChatStickyTabs = SharedFlags.FFlagExpChatStickyTabs

local function requestSelectFriendsTab(): boolean
    local store = ExpChatShared.context.store
    if store == nil then
        return false
    end

    if not requestSelectTab(FriendsChatTabName, if FFlagExpChatStickyTabs then true else nil) then
        return false
    end

    if not FFlagExpChatUseChannelTabsStore then
        store:dispatch(FriendsChatChannelSelected(FriendsChatTabName))
    end
    return true
end

return requestSelectFriendsTab
