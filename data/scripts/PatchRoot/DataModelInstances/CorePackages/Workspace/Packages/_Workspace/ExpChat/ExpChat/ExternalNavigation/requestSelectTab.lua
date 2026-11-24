-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T08:11:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent

local ExpChatShared = require(ExpChatParent.ExpChatShared)
local SharedFlags = require(ExpChatParent.SharedFlags)

local GetChannelTabsStore = require(ExpChat.Stores.GetChannelTabsStore)

local FFlagExpChatUseChannelTabsStore = SharedFlags.FFlagExpChatUseChannelTabsStore

local function requestSelectTab(str1: string, bool1: boolean?): boolean
    local store = ExpChatShared.context.store
    if store == nil then
        return false
    end

    if not FFlagExpChatUseChannelTabsStore then
        local channelTabs = store:getState().ChannelTabs
        return channelTabs ~= nil and channelTabs.allChannelTabs[str1] ~= nil
    end

    local channelTabsStore = GetChannelTabsStore(false)
    if channelTabsStore.getChannelTabsState(false).allChannelTabs[str1] == nil then
        return false
    end
    channelTabsStore.setTargetChannel(str1, false, bool1)
    return true
end

return requestSelectTab
