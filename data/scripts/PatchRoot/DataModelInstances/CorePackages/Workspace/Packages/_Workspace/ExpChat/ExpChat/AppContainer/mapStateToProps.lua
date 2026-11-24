-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T07:30:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent

local ExpChatShared = require(ExpChatParent.ExpChatShared)
local SharedFlags = require(ExpChatParent.SharedFlags)

local FFlagExpChatNewInputBar = require(ExpChat.Flags.FFlagExpChatNewInputBar)
local FFlagExpChatFixInputBarOrphanBorder = require(ExpChat.Flags.FFlagExpChatFixInputBarOrphanBorder)
local selectSelectedTabName = require(ExpChat.selectSelectedTabName)
local FriendsChatTabName = require(ExpChatParent.FriendsChat.FriendsChatTabName)

local FFlagExpChatPresetChatEnabled = ExpChatShared.Flags.FFlagExpChatPresetChatEnabled
local GetFFlagTextChatEnableUniverseChatTabs = ExpChatShared.Flags.GetFFlagTextChatEnableUniverseChatTabs
local FFlagExpChatUseChatConfigStore = SharedFlags.FFlagExpChatUseChatConfigStore
local FFlagExpChatUseChannelTabsStore = SharedFlags.FFlagExpChatUseChannelTabsStore

local function getIsChatInputBarVisible(arg1, bool1: boolean) -- Luacid: Inlined by compiler; 2 call sites recovered
    local isChatInputBarEnabled = arg1.ChatVisibility.isChatInputBarEnabled

    if GetFFlagTextChatEnableUniverseChatTabs() and bool1 and isChatInputBarEnabled._propertyEnabled ~= nil then
        return isChatInputBarEnabled._topBarVisibility
            and isChatInputBarEnabled._coreGuiEnabled
            and not isChatInputBarEnabled._devTextBoxEnabled
    end

    return isChatInputBarEnabled.value
end

local function getSelectedTabType(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    local channelTabs = arg1.ChannelTabs
    if channelTabs == nil or channelTabs.allChannelTabs == nil or channelTabs.selectedTabName == nil then
        return nil
    end
    local allChannelTab = channelTabs.allChannelTabs[channelTabs.selectedTabName]
    return allChannelTab and allChannelTab.Type or nil
end

return function(arg1, arg2)
    local channelTabs = if FFlagExpChatUseChannelTabsStore then nil else arg1.ChannelTabs
    local var1 = if FFlagExpChatUseChannelTabsStore or not GetFFlagTextChatEnableUniverseChatTabs() then nil else selectSelectedTabName(arg1)
    local bool1 = if FFlagExpChatUseChannelTabsStore then arg2.isGlobalTabSelected == true else var1 == "RBXGlobal"
    local hasGlobalChannelTab = if FFlagExpChatUseChannelTabsStore then arg2.hasGlobalChannelTab else false

    if not FFlagExpChatUseChannelTabsStore and GetFFlagTextChatEnableUniverseChatTabs() then
        if channelTabs == nil or channelTabs.allChannelTabs == nil then
            hasGlobalChannelTab = false
        else
            hasGlobalChannelTab = channelTabs.allChannelTabs.RBXGlobal ~= nil
        end
    end

    local hasFriendsChannelTab = if FFlagExpChatUseChannelTabsStore then arg2.hasFriendsChannelTab else false

    if not FFlagExpChatUseChannelTabsStore then
        if channelTabs == nil or channelTabs.allChannelTabs == nil then
            hasFriendsChannelTab = false
        else
            hasFriendsChannelTab = channelTabs.allChannelTabs[FriendsChatTabName] ~= nil
        end
    end

    local selectedTabType = if FFlagExpChatUseChannelTabsStore then arg2.selectedTabType else getSelectedTabType(arg1)
    local renderingFriends = selectedTabType == "FriendsChat"
    local isExperienceChatRendered = not renderingFriends

    local tbl1 = {
        isChatInputBarVisible = if FFlagExpChatFixInputBarOrphanBorder then getIsChatInputBarVisible(arg1, bool1) and isExperienceChatRendered else getIsChatInputBarVisible(arg1, bool1),
        isChatWindowVisible = arg1.ChatVisibility.isChatWindowEnabled.value,
        isChannelBarVisible = arg1.ChatVisibility.isChannelBarEnabled.value
            or GetFFlagTextChatEnableUniverseChatTabs() and hasGlobalChannelTab and arg1.ChatVisibility.isChatWindowEnabled.value
            or hasFriendsChannelTab and arg1.ChatVisibility.isChatWindowEnabled.value,
        chatTopBarVisibility = arg1.ChatVisibility.isChatInputBarEnabled._topBarVisibility
            and arg1.ChatVisibility.isChatWindowEnabled._topBarVisibility,
        chatLayoutAlignment = arg1.ChatLayout.Alignment,
        chatWindowSettings = if FFlagExpChatUseChatConfigStore then nil else arg1.ChatLayout.ChatWindowSettings,
        clientSettings = arg1.ClientSettings,
        selectedTabType = 0,
        renderingFriends = 0,
        isExperienceChatRendered = 0,
        targetTextChannel = 0
    }

    if FFlagExpChatUseChannelTabsStore then
        selectedTabType = nil
    end

    tbl1.selectedTabType = selectedTabType
    tbl1.renderingFriends = renderingFriends
    tbl1.isExperienceChatRendered = isExperienceChatRendered
    tbl1.targetTextChannel = if FFlagExpChatPresetChatEnabled or FFlagExpChatNewInputBar then arg1.TextChannels and arg1.TextChannels.targetTextChannel else nil
    return tbl1
end
