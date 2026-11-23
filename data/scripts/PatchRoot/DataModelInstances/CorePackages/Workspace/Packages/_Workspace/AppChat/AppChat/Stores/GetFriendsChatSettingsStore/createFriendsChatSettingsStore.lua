-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:11:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local RetrievalStatus = require(AppChatParent.Http).Enum.RetrievalStatus
local SharedFlags = require(AppChatParent.SharedFlags)
local Signals = require(AppChatParent.Signals)

local GetFriendsChatMetadataStore = require(AppChat.Stores.GetFriendsChatMetadataStore)
local FFlagAppChatUseSignalsForChatSettings = require(AppChat.Flags.FFlagAppChatUseSignalsForChatSettings)
local var1 = require(AppChat.Logger):new(script.Name)

local function createFriendsChatSettingsStore()
    local friendsChatMetadataStore = GetFriendsChatMetadataStore(false)

    local getThirdPartyChatRestrictionStatus, var3 = Signals.createSignal(Enum.ChatRestrictionStatus.Unknown)

    local var4, var5 = Signals.createSignal(nil)
    local var6, var7 = Signals.createSignal(false)

    local getChatEnabled = Signals.createComputed(function(arg1): boolean
        local var8 = friendsChatMetadataStore.getCachedFriendsChatMetadata(arg1).data(arg1)
        local var9 = getThirdPartyChatRestrictionStatus(arg1)
        if FFlagAppChatUseSignalsForChatSettings and var9 == Enum.ChatRestrictionStatus.Unknown then
            var9 = var4(arg1) or var9
        end

        return not (var8 == nil or var9 == Enum.ChatRestrictionStatus.Unknown or var8.isChatEnabled ~= true)
            and var9 == Enum.ChatRestrictionStatus.NotRestricted
    end)

    local getGroupChatEnabled = Signals.createComputed(function(arg1): boolean
        local var8 = friendsChatMetadataStore.getCachedFriendsChatMetadata(arg1).data(arg1)

        return (not (var8 == nil or var8.isChatEnabled ~= true) and var8.isGroupChatEnabledByPrivacySetting == "enabled") ~= var6(arg1)
    end)

    local getChatUserMessagesEnabled = Signals.createComputed(function(arg1)
        local var8 = friendsChatMetadataStore.getCachedFriendsChatMetadata(arg1).data(arg1)
        return if var8 then var8.isChatUserMessagesEnabled else nil
    end)

    return {
        getThirdPartyChatRestrictionStatus = getThirdPartyChatRestrictionStatus,
        getChatEnabled = getChatEnabled,
        getGroupChatEnabled = getGroupChatEnabled,
        getChatUserMessagesEnabled = getChatUserMessagesEnabled,
        getRetrievalStatus = Signals.createComputed(function(arg1)
            return if friendsChatMetadataStore.getCachedFriendsChatMetadata(arg1).data(arg1) == nil or var4(arg1) == nil then RetrievalStatus.NotStarted else RetrievalStatus.Done
        end),
        getPrivacySettingsEnabled = Signals.createComputed(function(arg1): boolean
            local var8 = friendsChatMetadataStore.getCachedFriendsChatMetadata(arg1).data(arg1)
            return not (var8 == nil) and var8.isChatEnabledByPrivacySetting == "enabled"
        end),
        getGlobalRulesEnabled = Signals.createComputed(function(arg1): boolean
            local var8 = friendsChatMetadataStore.getCachedFriendsChatMetadata(arg1).data(arg1)
            return not (var8 == nil) and var8.isChatEnabledByGlobalRules == "enabled"
        end),
        getThirdPartyPrivacySettingsEnabled = Signals.createComputed(function(arg1): boolean
            return getThirdPartyChatRestrictionStatus(arg1) == Enum.ChatRestrictionStatus.NotRestricted
        end),
        setThirdPartyChatRestrictionStatus = function(chatRestrictionStatus)
            var3(chatRestrictionStatus)
            if chatRestrictionStatus ~= Enum.ChatRestrictionStatus.Unknown then
                var5(chatRestrictionStatus)
            elseif friendsChatMetadataStore.getCachedFriendsChatMetadata(false).data(false) == nil then
                var5(nil)
            end
        end,
        toggleDebugGroupChatEnabled = function()
            var7(not var6(false))
        end,
        clearDebugGroupChatToggle = function()
            var7(false)
        end,
        reset = function()
            var3(Enum.ChatRestrictionStatus.Unknown)
            var5(nil)
            var7(false)
        end,
        dispose = not SharedFlags.FFlagDebugFriendsChat and function() end or Signals.createEffect(function(arg1)
            local var8 = friendsChatMetadataStore.getCachedFriendsChatMetadata(arg1).data(arg1)
            local var9 = var1
            local str1 = `Friends Chat eligibility: chatEnabled={tostring(getChatEnabled(arg1))}`
            local str2 = " (accountChatEnabled=%*,"
            local isChatEnabled = if var8 then var8.isChatEnabled else nil
            local str3 = str2:format(tostring(isChatEnabled))
            local str4 = " privacySetting=%*,"
            local isChatEnabledByPrivacySetting = if var8 then var8.isChatEnabledByPrivacySetting else nil
            local str5 = str4:format(tostring(isChatEnabledByPrivacySetting))
            local str6 = " globalRules=%*,"
            local isChatEnabledByGlobalRules = if var8 then var8.isChatEnabledByGlobalRules else nil
            var9:debug(
                str1
                    .. str3
                        .. str5 .. str6:format(tostring(isChatEnabledByGlobalRules)) .. ` thirdPartyStatus={tostring(getThirdPartyChatRestrictionStatus(arg1))});` .. ` chatUserMessagesEnabled={tostring(getChatUserMessagesEnabled(arg1))}`
            )
        end)
    }
end

return createFriendsChatSettingsStore
