-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:01:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent
local FFlagExpChatUseChannelTabsStore = require(ExpChatParent.SharedFlags).FFlagExpChatUseChannelTabsStore
local GetChannelTabsStore = if FFlagExpChatUseChannelTabsStore then require(ExpChat.Stores.GetChannelTabsStore) else nil

local function getOpenChannelName(arg1)
    local textChannels = arg1.TextChannels
    if textChannels == nil then
        return nil
    end

    local targetTextChannel = textChannels.targetTextChannel
    if targetTextChannel ~= nil and targetTextChannel.Name ~= nil then
        return targetTextChannel.Name
    end

    local selectedChannelName = textChannels.selectedChannelName
    local var1 = if FFlagExpChatUseChannelTabsStore then GetChannelTabsStore(false).getChannelTabsState(false) else arg1.ChannelTabs

    if selectedChannelName == nil or var1 == nil or var1.allChannelTabs[selectedChannelName] == nil then
        if var1 == nil then
            return selectedChannelName
        end

        return var1.selectedTabName or "RBXGeneral"
    end

    return selectedChannelName
end

local function getMessageChannelName(arg1, str1: string?) -- Luacid: Inlined by compiler; 1 call site recovered
    if str1 == nil then
        if arg1.TextChannel == nil then
            return nil
        end

        str1 = arg1.TextChannel.Name
    end

    return if str1 == "RBXSystem" then "RBXGeneral" else str1
end

local function isMessageForOpenChannel(arg1, arg2, str1: string?): boolean
    local openChannelName = getOpenChannelName(arg1)
    local messageChannelName = getMessageChannelName(arg2, str1)
    return openChannelName == nil or messageChannelName == nil or messageChannelName == openChannelName
end

return isMessageForOpenChannel
