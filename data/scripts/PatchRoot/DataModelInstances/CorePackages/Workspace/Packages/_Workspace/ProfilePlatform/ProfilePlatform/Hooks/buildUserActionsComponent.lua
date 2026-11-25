-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:50:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent
local SocialCommon = require(ProfilePlatformParent.SocialCommon)
local Cryo = require(ProfilePlatformParent.Cryo)

local _Component = require(ProfilePlatform.Types.Component)
local Enums = require(ProfilePlatform.Common.Enums)
local getSupportedActionsForProfileType = require(ProfilePlatform.Hooks.getSupportedActionsForProfileType)

local FFlagProfilePlatformEnableVR = require(ProfilePlatform.Flags.FFlagProfilePlatformEnableVR)

local FFlagProfilePlatformEnableCurrencyTransfer = require(ProfilePlatformParent.SharedFlags).FFlagProfilePlatformEnableCurrencyTransfer
local FFlagProfilePlatformEnableTradeItems = require(ProfilePlatform.Flags.FFlagProfilePlatformEnableTradeItems)

local function filterSupportedActions(tbl1) -- Luacid: Inlined by compiler; 1 call site recovered
    local supportedActionsForProfileType = getSupportedActionsForProfileType(Enums.ProfileTypes.User)

    return Cryo.List.filter(supportedActionsForProfileType, function(arg1): boolean
        if arg1 == Enums.ProfileActions.QrCode then
            return not not (tbl1 and tbl1.isProfileQrCodeEnabled)
        end

        if arg1 == Enums.ProfileActions.EditProfile then
            return not not (tbl1 and tbl1.areWebViewsSupported)
        end

        if FFlagProfilePlatformEnableCurrencyTransfer and arg1 == Enums.ProfileActions.CurrencyTransfer then
            return not not (tbl1 and tbl1.canRenderTransferInProfile)
        end

        if FFlagProfilePlatformEnableTradeItems and arg1 == Enums.ProfileActions.TradeItems then
            return not not (tbl1 and tbl1.areWebViewsSupported)
        end

        if arg1 == Enums.ProfileActions.Chat then
            return not not (tbl1 and tbl1.canSeeChatTab ~= false)
        end

        return true
    end)
end

local function buildUserActionsComponent(offNetworkFriendRequest, tbl1)
    local offNetworkFriendRequest2 = if offNetworkFriendRequest == SocialCommon.Enums.ContextualInfoTypes.OffNetworkFriendRequest then Enums.ContextualTypes.OffNetworkFriendRequest else nil
    local excludeContextualActions = if tbl1 then if tbl1.isSelfView then true else nil else nil

    if FFlagProfilePlatformEnableVR then
        return {
            component = Enums.Components.Actions,
            context = offNetworkFriendRequest2,
            supportedActions = filterSupportedActions(tbl1),
            excludeContextualActions = excludeContextualActions,
            isActionsV2Supported = true
        }
    end

    return {
        component = Enums.Components.Actions,
        context = offNetworkFriendRequest2,
        supportedActions = getSupportedActionsForProfileType(Enums.ProfileTypes.User),
        excludeContextualActions = excludeContextualActions,
        isActionsV2Supported = true
    }
end

return buildUserActionsComponent
