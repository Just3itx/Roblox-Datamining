-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:50:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent
local SocialCommon = require(ProfilePlatformParent.SocialCommon)
local Cryo = require(ProfilePlatformParent.Cryo)

local _Component = require(ProfilePlatform.Types.Component)
local Enums = require(ProfilePlatform.Common.Enums)
local buildUserActionsComponent = require(ProfilePlatform.Hooks.buildUserActionsComponent)
local getSupportedActionsForProfileType = require(ProfilePlatform.Hooks.getSupportedActionsForProfileType)

local FFlagProfilePlatformEnableFavoriteExperiences = require(ProfilePlatform.Flags.FFlagProfilePlatformEnableFavoriteExperiences)
local FFlagProfilePlatformEnableInventory = require(ProfilePlatformParent.SharedFlags).FFlagProfilePlatformEnableInventory
local FFlagProfilePlatformEnableStore = require(ProfilePlatformParent.SharedFlags).FFlagProfilePlatformEnableStore
local FFlagProfilePlatformEnableVR = require(ProfilePlatform.Flags.FFlagProfilePlatformEnableVR)
local FFlagExperiencesOnProfile = require(ProfilePlatformParent.SharedFlags).FFlagExperiencesOnProfile
local FFlagProfilePlatformAddCurrentlyPlaying = require(ProfilePlatform.Flags.FFlagProfilePlatformAddCurrentlyPlaying)
local FFlagProfilePlatformEnableMoments = require(ProfilePlatform.Flags.FFlagProfilePlatformEnableMoments)

local FFlagProfilePlatformEnableCurrencyTransfer = require(ProfilePlatformParent.SharedFlags).FFlagProfilePlatformEnableCurrencyTransfer
local FFlagProfilePlatformEnableTradeItems = require(ProfilePlatform.Flags.FFlagProfilePlatformEnableTradeItems)
local FFlagEnableProfileCompletion = require(ProfilePlatformParent.SharedFlags).FFlagEnableProfileCompletion

local FFlagProfilePlatformRefreshActionsRespectPolicies = require(ProfilePlatform.Flags.FFlagProfilePlatformRefreshActionsRespectPolicies)
local FFlagProfilePlatformGracefulVisibility = require(ProfilePlatform.Flags.FFlagProfilePlatformGracefulVisibility)

local tbl1 = {
    [SocialCommon.Enums.ContextualInfoTypes.MutualFriends] = Enums.ContextualTypes.MutualFriends,
    [SocialCommon.Enums.ContextualInfoTypes.Frequents] = Enums.ContextualTypes.PlayedTogether
}

return function(arg1, tbl2)
    local tbl3

    if FFlagProfilePlatformEnableVR then
        local userActionsComponent

        if FFlagProfilePlatformRefreshActionsRespectPolicies then
            userActionsComponent = buildUserActionsComponent(arg1, tbl2)
        else
            local supportedActionsForProfileType = getSupportedActionsForProfileType(Enums.ProfileTypes.User)
            local supportedActions = Cryo.List.filter(supportedActionsForProfileType, function(arg2): boolean
                if arg2 == Enums.ProfileActions.QrCode then
                    return not not (tbl2 and tbl2.isProfileQrCodeEnabled)
                end

                if arg2 == Enums.ProfileActions.EditProfile then
                    return not not (tbl2 and tbl2.areWebViewsSupported)
                end

                if FFlagProfilePlatformEnableCurrencyTransfer and arg2 == Enums.ProfileActions.CurrencyTransfer then
                    return not not (tbl2 and tbl2.canRenderTransferInProfile)
                end

                if FFlagProfilePlatformEnableTradeItems and arg2 == Enums.ProfileActions.TradeItems then
                    return not not (tbl2 and tbl2.areWebViewsSupported)
                end

                if arg2 == Enums.ProfileActions.Chat then
                    return not not (tbl2 and tbl2.canSeeChatTab ~= false)
                end

                return true
            end)

            userActionsComponent = {
                component = Enums.Components.Actions,
                context = if arg1 == SocialCommon.Enums.ContextualInfoTypes.OffNetworkFriendRequest then Enums.ContextualTypes.OffNetworkFriendRequest else nil,
                supportedActions = supportedActions,
                excludeContextualActions = if tbl2 and tbl2.isSelfView then true else nil,
                isActionsV2Supported = true
            }
        end

        tbl3 = {
            {
                component = Enums.Components.UserProfileHeader,
                context = tbl1[arg1]
            },
            {
                component = Enums.Components.SocialLinks
            },
            {
                component = Enums.Components.About
            },
            {
                component = Enums.Components.CurrentlyWearing
            },
            userActionsComponent
        }

        table.insert(tbl3, { component = Enums.Components.ProfileBackground })

        if tbl2 and tbl2.areWebViewsSupported then
            table.insert(tbl3, { component = Enums.Components.ViewFullProfile })
        end
    else
        local userActionsComponent

        if FFlagProfilePlatformRefreshActionsRespectPolicies then
            userActionsComponent = buildUserActionsComponent(arg1, tbl2)
        else
            userActionsComponent = {
                component = Enums.Components.Actions,
                context = if arg1 == SocialCommon.Enums.ContextualInfoTypes.OffNetworkFriendRequest then Enums.ContextualTypes.OffNetworkFriendRequest else nil,
                supportedActions = getSupportedActionsForProfileType(Enums.ProfileTypes.User),
                excludeContextualActions = if tbl2 and tbl2.isSelfView then true else nil,
                isActionsV2Supported = true
            }
        end

        tbl3 = {
            {
                component = Enums.Components.UserProfileHeader,
                context = if arg1 == SocialCommon.Enums.ContextualInfoTypes.MutualFriends then Enums.ContextualTypes.MutualFriends else nil
            },
            {
                component = Enums.Components.SocialLinks
            },
            {
                component = Enums.Components.About
            },
            {
                component = Enums.Components.CurrentlyWearing
            },
            {
                component = Enums.Components.ViewFullProfile
            },
            userActionsComponent
        }

        table.insert(tbl3, { component = Enums.Components.ProfileBackground })
    end

    if FFlagProfilePlatformEnableFavoriteExperiences and (not FFlagProfilePlatformEnableVR or tbl2 and tbl2.areWebViewsSupported) then
        table.insert(tbl3, { component = Enums.Components.FavoriteExperiences })
    end

    if FFlagProfilePlatformEnableInventory and (not FFlagProfilePlatformEnableVR or tbl2 and tbl2.areWebViewsSupported) then
        table.insert(tbl3, { component = Enums.Components.Inventory })
    end

    if FFlagProfilePlatformEnableStore and (not FFlagProfilePlatformEnableVR or tbl2 and tbl2.areWebViewsSupported) then
        table.insert(tbl3, { component = Enums.Components.Store })
    end

    if FFlagExperiencesOnProfile then
        table.insert(tbl3, { component = Enums.Components.Experiences })
    end

    if FFlagEnableProfileCompletion then
        table.insert(tbl3, { component = Enums.Components.ProfileCompletion })
    end

    if FFlagProfilePlatformAddCurrentlyPlaying then
        table.insert(tbl3, { component = Enums.Components.CurrentlyPlaying })
    end

    if FFlagProfilePlatformGracefulVisibility then
        table.insert(tbl3, { component = Enums.Components.Friends })
    end

    if FFlagProfilePlatformEnableMoments then
        table.insert(tbl3, { component = Enums.Components.Moments })
    end

    return tbl3
end
