-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:31:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent
local ExpChatShared = require(ExpChatParent.ExpChatShared)

local TargetTextChannelPropertyChanged = ExpChatShared.Actions.TargetTextChannelPropertyChanged
local UniverseChatChannelSelected = ExpChatShared.Actions.UniverseChatChannelSelected
local FriendsChatChannelSelected = ExpChatShared.Actions.FriendsChatChannelSelected
local TextChatChannelSelected = ExpChatShared.Actions.TextChatChannelSelected

local SharedFlags = require(ExpChatParent.SharedFlags)
local FFlagExpChatUseChannelTabsStore = SharedFlags.FFlagExpChatUseChannelTabsStore
local FFlagExpChatSelectTextChatTabByName = SharedFlags.FFlagExpChatSelectTextChatTabByName
local FFlagExpChatStickyTabs = SharedFlags.FFlagExpChatStickyTabs

local GetChannelTabsStore = require(ExpChat.Stores.GetChannelTabsStore)

local isUserSelectedTabTracked = require(ExpChat.isUserSelectedTabTracked)

local function selectTabByType(callback: (...any) -> (...any), tbl1)
    local channelName = tbl1.channelName
    local tabType = tbl1.tabType
    local shouldReorderTabs = tbl1.shouldReorderTabs

    if tabType == "UniverseChat" then
        if isUserSelectedTabTracked() then
            callback(UniverseChatChannelSelected(channelName, true))
        else
            callback(UniverseChatChannelSelected(channelName))
        end
    elseif not FFlagExpChatUseChannelTabsStore and tabType == "FriendsChat" then
        callback(FriendsChatChannelSelected(channelName))
    elseif FFlagExpChatSelectTextChatTabByName and tabType == "TextChat" then
        callback(TextChatChannelSelected(channelName, shouldReorderTabs))
    elseif tbl1.textChannel then
        if FFlagExpChatStickyTabs then
            callback(TargetTextChannelPropertyChanged(tbl1.textChannel, shouldReorderTabs, true))
        else
            callback(TargetTextChannelPropertyChanged(tbl1.textChannel, shouldReorderTabs))
        end
    end

    if not FFlagExpChatUseChannelTabsStore then
        return
    end

    local channelTabsStore = GetChannelTabsStore(false)

    if isUserSelectedTabTracked() then
        channelTabsStore.setTargetChannel(channelName, shouldReorderTabs, true)
        return
    end
    channelTabsStore.setTargetChannel(channelName, shouldReorderTabs)
end

return selectTabByType
