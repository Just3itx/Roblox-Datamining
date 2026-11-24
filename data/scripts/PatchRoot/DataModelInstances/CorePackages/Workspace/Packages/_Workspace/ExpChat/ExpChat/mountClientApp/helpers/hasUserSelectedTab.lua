-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:10:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent

local FFlagExpChatUseChannelTabsStore = require(ExpChatParent.SharedFlags).FFlagExpChatUseChannelTabsStore
local GetChannelTabsStore = require(ExpChat.Stores.GetChannelTabsStore)

return function(arg1): boolean
    if FFlagExpChatUseChannelTabsStore then
        return GetChannelTabsStore(false).getChannelTabsState(false).hasUserSelectedTab == true
    end

    local channelTabs = arg1:getState().ChannelTabs
    return not (channelTabs == nil) and channelTabs.hasUserSelectedTab == true
end
