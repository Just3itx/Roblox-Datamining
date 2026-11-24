-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T13:21:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local FriendsChat = script:FindFirstAncestor("FriendsChat")
local FriendsChatParent = FriendsChat.Parent

local Signals = require(FriendsChatParent.Signals)
local SharedFlags = require(FriendsChatParent.SharedFlags)

local GetFriendsChatSettingsStore = require(FriendsChatParent.AppChat.GetFriendsChatSettingsStore)
local getLocalUserId = require(script.Parent.Parent.Parent.Utils.getLocalUserId)
local FFlagExpChatFriendsRespectWindowEnabled = require(FriendsChat.Flags.FFlagExpChatFriendsRespectWindowEnabled)

local FFlagExpChatFriendsTabUsePolicy = SharedFlags.FFlagExpChatFriendsTabUsePolicy
local FFlagExpChatCanShowFriendsTab = SharedFlags.FFlagExpChatCanShowFriendsTab
local FFlagExpChatFriendsTabRequireDefaultChannels = SharedFlags.FFlagExpChatFriendsTabRequireDefaultChannels
local FFlagFriendsChatHasFriendsGate = SharedFlags.FFlagFriendsChatHasFriendsGate

local TextChatService = game:GetService("TextChatService")

local GetAppPolicyStore = if FFlagExpChatFriendsTabUsePolicy then require(FriendsChatParent.UniversalAppPolicy).GetAppPolicyStore else nil

local var1 = if FFlagFriendsChatHasFriendsGate then require(FriendsChatParent.DataHydration).Friends.FriendsStore.get() else nil

local function createFriendsTabVisibilityStore()
    local friendsChatSettingsStore = GetFriendsChatSettingsStore(false)

    local createDefaultTextChannels = TextChatService.CreateDefaultTextChannels
    local var2 = nil
    local connection = nil
    if FFlagExpChatFriendsRespectWindowEnabled then
        local chatWindowConfiguration = TextChatService:FindFirstChildOfClass("ChatWindowConfiguration")
        local var3, var4 = Signals.createSignal(chatWindowConfiguration == nil or chatWindowConfiguration.Enabled)
        var2 = var3
        if chatWindowConfiguration then
            connection = chatWindowConfiguration:GetPropertyChangedSignal("Enabled"):Connect(function()
                var4(chatWindowConfiguration.Enabled)
            end)
        end
    end

    return {
        getIsFriendsTabVisible = Signals.createComputed(function(arg1)
            if FFlagExpChatFriendsRespectWindowEnabled and not var2(arg1) then
                return false
            end

            local var3 = not FFlagExpChatFriendsTabUsePolicy or GetAppPolicyStore(false).getAppPolicy(arg1).getCanSeeFriendsTab()
            local bool1

            if FFlagFriendsChatHasFriendsGate and FFlagExpChatCanShowFriendsTab then
                local localUserId = getLocalUserId()
                if localUserId == nil then
                    bool1 = false
                else
                    local friendsCountByUserId = var1.GetFriendsCountByUserId(tostring(localUserId))
                    local var4 = if friendsCountByUserId then friendsCountByUserId.data(arg1) else nil

                    if var4 == nil then
                        bool1 = false
                    else
                        bool1 = var4 > 0
                    end
                end
            else
                bool1 = true
            end

            local chatEnabled = FFlagExpChatCanShowFriendsTab and var3 and bool1 and friendsChatSettingsStore.getChatEnabled(arg1)
            return chatEnabled
                and friendsChatSettingsStore.getChatUserMessagesEnabled(arg1) ~= false
                and (not FFlagExpChatFriendsTabRequireDefaultChannels or createDefaultTextChannels)
        end),
        dispose = function()
            if connection then
                connection:Disconnect()
                connection = nil
            end
        end
    }
end

return createFriendsTabVisibilityStore
