-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:11:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local React = require(AppChatParent.React)
local useLocalization = require(AppChatParent.Localization).Hooks.useLocalization
local Foundation = require(AppChatParent.Foundation)

local GetFFlagIsSquadEnabled = require(AppChatParent.SharedFlags).GetFFlagIsSquadEnabled

local tbl1 = {
    friends = {
        icon = "rbxasset://textures/ui/LuaChat/icons/ic-friends.png",
        copy = if GetFFlagIsSquadEnabled() then "Feature.Chat.Message.MakeFriendsToParty" else "Feature.Chat.Message.MakeConnectionsToChat",
        cta = "Feature.SettingsHub.Label.NoFriendsScreen"
    },
    regional = {
        icon = "icons/status/oof_xlarge",
        copy = if GetFFlagIsSquadEnabled() then "Feature.Chat.Message.PartyUnavailableRegion" else "Feature.Chat.Message.ChatUnavailableRegion",
        cta = nil
    },
    privacy = {
        icon = "rbxasset://textures/ui/LuaChat/icons/ic-friends.png",
        copy = if GetFFlagIsSquadEnabled() then "Feature.Chat.Message.EnableParty.FriendsRename" else "Feature.Chat.Message.EnableChat.FriendsRename",
        cta = "Feature.Chat.Label.PrivacySettings"
    },
    thirdParty = {
        icon = "rbxasset://textures/ui/LuaChat/icons/ic-friends.png",
        copy = "Feature.Chat.Message.ChatIsDisabledByPrivacySetting",
        cta = nil
    },
    fallback = {
        icon = "icons/status/oof_xlarge",
        copy = "CommonUI.Messages.Response.PageError",
        cta = nil
    }
}

local function getEmptyStateFromProps(tbl2): string -- Luacid: Inlined by compiler; 1 call site recovered
    if tbl2.chatEnabled then
        return "friends"
    end

    if not tbl2.globalRulesEnabled then
        return "regional"
    end

    if tbl2.privacySettingsEnabled then
        if tbl2.thirdPartyPrivacySettingsEnabled then
            return "fallback"
        end

        return "thirdParty"
    end

    return "privacy"
end

local function NoConversationsLanding(tbl2)
    local emptyStateFromProps = getEmptyStateFromProps(tbl2)
    local var1 = tbl1[emptyStateFromProps]
    local bool1 = var1.cta ~= nil
    if emptyStateFromProps == "friends" and not tbl2.canNavigateToAddFriends
        or emptyStateFromProps == "privacy" and not tbl2.canNavigateToPrivacySettings
    then
        bool1 = false
    end

    local var2 = useLocalization({ callToAction = var1.cta or "Feature.Chat.Label.PrivacySettings", copy = var1.copy })

    React.useEffect(function()
        if tbl2.fireRenderEvent then
            tbl2.fireRenderEvent(emptyStateFromProps)
        end
    end, { tbl2.fireRenderEvent, emptyStateFromProps })

    return React.createElement(Foundation.Empty, {
        icon = {
            name = var1.icon,
            size = "XLarge"
        },
        text = var2.copy,
        button = bool1 and {
            text = var2.callToAction,
            icon = "icons/navigation/externallink_medium",
            onActivated = function()
                tbl2.onCallToAction(emptyStateFromProps)
            end
        } or nil
    })
end

return NoConversationsLanding
