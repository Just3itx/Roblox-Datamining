-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:21:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local React = require(AppChatParent.React)
local Signals = require(AppChatParent.Signals)
local SignalsReact = require(AppChatParent.SignalsReact)

local SharedFlags = require(AppChatParent.SharedFlags)
local FStringAppChatFriendsTabIxpLayer = require(AppChat.Flags.FStringAppChatFriendsTabIxpLayer)
local GetFriendsChatSettingsStore = require(AppChat.Stores.GetFriendsChatSettingsStore)
local IXPNavigationUtils = require(AppChat.Utils.IXPNavigationUtils)

local FFlagExpChatFriendsTabUsePolicy = SharedFlags.FFlagExpChatFriendsTabUsePolicy
local FFlagExpChatFriendsTabRequireDefaultChannels = SharedFlags.FFlagExpChatFriendsTabRequireDefaultChannels
local FFlagFriendsChatHasFriendsGate = SharedFlags.FFlagFriendsChatHasFriendsGate

local Players = game:GetService("Players")

local GetAppPolicyStore = if FFlagExpChatFriendsTabUsePolicy then require(AppChatParent.UniversalAppPolicy).GetAppPolicyStore else nil

local var1 = if FFlagFriendsChatHasFriendsGate then require(AppChatParent.DataHydration).Friends.FriendsStore.get() else nil

local exposureHandler = IXPNavigationUtils.createExposureHandler(FStringAppChatFriendsTabIxpLayer)

local function FriendsChatExperimentExposureEventReceiver()
    local friendsChatSettingsStore = GetFriendsChatSettingsStore(false)

    local var2 = React.useMemo(function(): boolean
        return game:GetService("TextChatService").CreateDefaultTextChannels
    end, {})
    local var3 = React.useMemo(function()
        return Signals.createComputed(function(arg1)
            local var3 = not FFlagExpChatFriendsTabUsePolicy or GetAppPolicyStore(false).getAppPolicy(arg1).getCanSeeFriendsTab()
            local bool1

            if FFlagFriendsChatHasFriendsGate then
                local localPlayer = Players.LocalPlayer
                if localPlayer then
                    local friendsCountByUserId = var1.GetFriendsCountByUserId(tostring(localPlayer.UserId))
                    local var4 = if friendsCountByUserId then friendsCountByUserId.data(arg1) else nil

                    if var4 == nil then
                        bool1 = false
                    else
                        bool1 = var4 > 0
                    end
                else
                    bool1 = false
                end
            else
                bool1 = true
            end

            local chatEnabled = var3 and bool1 and friendsChatSettingsStore.getChatEnabled(arg1)
            return chatEnabled
                and friendsChatSettingsStore.getChatUserMessagesEnabled(arg1) ~= false
                and (not FFlagExpChatFriendsTabRequireDefaultChannels or var2)
        end)
    end, { friendsChatSettingsStore, var2 })
    local var4 = SignalsReact.useSignalState(var3)

    React.useEffect(function()
        if var4 then
            exposureHandler()
        end
    end, { var4 })

    return nil
end

return FriendsChatExperimentExposureEventReceiver
