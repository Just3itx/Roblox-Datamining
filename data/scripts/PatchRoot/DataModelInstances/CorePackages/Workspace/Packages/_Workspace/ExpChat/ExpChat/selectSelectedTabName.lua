-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:20:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent

local FFlagExpChatUseChannelTabsStore = require(ExpChatParent.SharedFlags).FFlagExpChatUseChannelTabsStore

local GetChannelTabsStore = require(ExpChat.Stores.GetChannelTabsStore)

return function(arg1)
    if FFlagExpChatUseChannelTabsStore then
        return GetChannelTabsStore(false).getSelectedTabName(false)
    end
    return if arg1 == nil then nil else arg1.ChannelTabs.selectedTabName
end
