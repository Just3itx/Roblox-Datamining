-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T04:31:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent

local SocialLuaAnalytics = require(ProfilePlatformParent.SocialLuaAnalytics)
local AnalyticsConstants = require(script.Parent.AnalyticsConstants)

local Enums = SocialLuaAnalytics.Analytics.Enums
local Contexts = Enums.Contexts
local EventTypes = Enums.EventTypes
local EventNames = require(script.Parent.EventNames)

local FFlagProfilePlatformUseProfileTypeContext = require(ProfilePlatform.Flags.FFlagProfilePlatformUseProfileTypeContext)

local FFlagEnablePlatformProfileContextualMenuOption = require(ProfilePlatformParent.SharedFlags).FFlagEnablePlatformProfileContextualMenuOption

local FFlagProfilePlatformUseCatalogItemOpenedNewFields = require(ProfilePlatform.Flags.FFlagProfilePlatformUseCatalogItemOpenedNewFields)
local FFlagFriendsCallingClientGate_DEV = require(ProfilePlatformParent.SharedFlags).FFlagFriendsCallingClientGate_DEV

local FFlagProfilePlatformEnableCurrencyTransfer = require(ProfilePlatformParent.SharedFlags).FFlagProfilePlatformEnableCurrencyTransfer
local FFlagProfilePlatformEnableTradeItems = require(ProfilePlatform.Flags.FFlagProfilePlatformEnableTradeItems)
local FFlagProfileTradeItemsImpressionLogging = require(ProfilePlatform.Flags.FFlagProfileTradeItemsImpressionLogging)

local FFlagProfilePlatformEnableEditAppearanceMenu = require(ProfilePlatform.Flags.FFlagProfilePlatformEnableEditAppearanceMenu)

local FFlagProfilePlatformEditBackgroundMenuItem = require(ProfilePlatform.Flags.FFlagProfilePlatformEditBackgroundMenuItem)

local FFlagSocialEnableProfileInspectAndBuyAnalytics = require(ProfilePlatformParent.SharedFlags).FFlagSocialEnableProfileInspectAndBuyAnalytics

local function func1<T>(arg1: T): T
    return arg1
end

return {
    [EventNames.ProfilePageLoadedWithData] = {
        context = Contexts.PlayerProfile,
        eventType = EventTypes.PageLoad,
        formatRulesForAdditionalInfo = {
            friendStatus = func1,
            playerPresence = func1,
            absolutePosition = func1,
            isHomePageCarousel = func1,
            isRecommendation = func1,
            recommendationContextType = func1,
            recommendationRank = func1,
            recommendationSessionId = func1,
            source = func1,
            profileType = func1,
            shareLinkId = func1,
            primaryAction = func1
        }
    },
    [EventNames.ProfilePresenceLoaded] = {
        context = Contexts.PlayerProfile,
        eventType = EventTypes.PresenceLoaded,
        formatRulesForAdditionalInfo = { presenceType = func1, universeId = func1 }
    },
    [EventNames.ContextualMenuButtonCall] = FFlagFriendsCallingClientGate_DEV
        and {
            context = Contexts.PlayerProfile,
            eventType = EventTypes.ButtonClick,
            additionalInfo = {
                btn = AnalyticsConstants.ContextualMenuButtons.Call,
                optionType = "CTAType"
            },
            formatRulesForAdditionalInfo = { buttonSurface = func1 }
        }
        or nil,
    [EventNames.ContextualMenuButtonChat] = {
        context = Contexts.PlayerProfile,
        eventType = EventTypes.ButtonClick,
        additionalInfo = {
            btn = AnalyticsConstants.ContextualMenuButtons.Chat,
            optionType = "CTAType"
        },
        formatRulesForAdditionalInfo = { buttonSurface = func1 }
    },
    [EventNames.ContextualMenuButtonIgnoreFriendRequest] = {
        context = Contexts.PlayerProfile,
        eventType = EventTypes.ButtonClick,
        additionalInfo = {
            btn = AnalyticsConstants.ContextualMenuButtons.IgnoreFriendRequest,
            optionType = "CTAType"
        },
        formatRulesForAdditionalInfo = { buttonSurface = func1 }
    },
    [EventNames.ContextualMenuButtonReport] = {
        context = Contexts.PlayerProfile,
        eventType = EventTypes.ButtonClick,
        additionalInfo = {
            btn = AnalyticsConstants.ContextualMenuButtons.Report,
            optionType = "CTAType"
        },
        formatRulesForAdditionalInfo = { buttonSurface = func1 }
    },
    [EventNames.ContextualMenuButtonUnfriend] = {
        context = Contexts.PlayerProfile,
        eventType = EventTypes.ButtonClick,
        additionalInfo = {
            btn = AnalyticsConstants.ContextualMenuButtons.Unfriend,
            optionType = "CTAType"
        },
        formatRulesForAdditionalInfo = { buttonSurface = func1 }
    },
    [EventNames.ContextualMenuButtonBlock] = {
        context = Contexts.PlayerProfile,
        eventType = EventTypes.ButtonClick,
        additionalInfo = {
            btn = AnalyticsConstants.ContextualMenuButtons.Block,
            optionType = "CTAType"
        },
        formatRulesForAdditionalInfo = { buttonSurface = func1 }
    },
    [EventNames.ContextualMenuButtonSetAlias] = {
        context = Contexts.PlayerProfile,
        eventType = EventTypes.ButtonClick,
        additionalInfo = {
            btn = AnalyticsConstants.ContextualMenuButtons.SetAlias,
            optionType = "CTAType"
        },
        formatRulesForAdditionalInfo = { buttonSurface = func1 }
    },
    [EventNames.ContextualMenuButtonCopyLink] = {
        context = Contexts.PlayerProfile,
        eventType = EventTypes.ButtonClick,
        additionalInfo = {
            btn = AnalyticsConstants.ContextualMenuButtons.CopyLink,
            optionType = "CTAType"
        },
        formatRulesForAdditionalInfo = { buttonSurface = func1 }
    },
    [EventNames.ContextualMenuButtonLeaveCommunity] = {
        context = if FFlagProfilePlatformUseProfileTypeContext then Contexts.CommunityProfile else Contexts.PlayerProfile,
        eventType = EventTypes.ButtonClick,
        additionalInfo = {
            btn = AnalyticsConstants.ContextualMenuButtons.LeaveCommunity,
            optionType = "CTAType"
        },
        formatRulesForAdditionalInfo = { buttonSurface = func1, btnContext = func1 }
    },
    [EventNames.ContextualMenuButtonUnfollow] = {
        context = Contexts.PlayerProfile,
        eventType = EventTypes.ButtonClick,
        additionalInfo = {
            btn = AnalyticsConstants.ContextualMenuButtons.Unfollow,
            optionType = "CTAType"
        },
        formatRulesForAdditionalInfo = { buttonSurface = func1 }
    },
    [EventNames.ContextualMenuButtonRemoveTrustedConnection] = {
        context = Contexts.PlayerProfile,
        eventType = EventTypes.ButtonClick,
        additionalInfo = {
            btn = AnalyticsConstants.ContextualMenuButtons.RemoveTrustedConnection,
            optionType = "CTAType"
        },
        formatRulesForAdditionalInfo = { buttonSurface = func1 }
    },
    [EventNames.ContextualMenuButtonAddTrustedConnection] = {
        context = Contexts.PlayerProfile,
        eventType = EventTypes.ButtonClick,
        additionalInfo = {
            btn = AnalyticsConstants.ContextualMenuButtons.AddTrustedConnection,
            optionType = "CTAType"
        },
        formatRulesForAdditionalInfo = { buttonSurface = func1, modalVariantOverride = func1 }
    },
    [EventNames.ContextualMenuButtonAddIncomingTrustedConnection] = {
        context = Contexts.PlayerProfile,
        eventType = EventTypes.ButtonClick,
        additionalInfo = {
            btn = AnalyticsConstants.ContextualMenuButtons.AddIncomingTrustedConnection,
            optionType = "CTAType"
        },
        formatRulesForAdditionalInfo = { buttonSurface = func1 }
    },
    [EventNames.ContextualMenuButtonMakePrimaryCommunity] = {
        context = if FFlagProfilePlatformUseProfileTypeContext then Contexts.CommunityProfile else Contexts.PlayerProfile,
        eventType = EventTypes.ButtonClick,
        additionalInfo = {
            btn = AnalyticsConstants.ContextualMenuButtons.MakePrimaryCommunity,
            optionType = "CTAType"
        },
        formatRulesForAdditionalInfo = { buttonSurface = func1, btnContext = func1 }
    },
    [EventNames.ContextualMenuButtonRemovePrimaryCommunity] = {
        context = if FFlagProfilePlatformUseProfileTypeContext then Contexts.CommunityProfile else Contexts.PlayerProfile,
        eventType = EventTypes.ButtonClick,
        additionalInfo = {
            btn = AnalyticsConstants.ContextualMenuButtons.RemovePrimaryCommunity,
            optionType = "CTAType"
        },
        formatRulesForAdditionalInfo = { buttonSurface = func1, btnContext = func1 }
    },
    [EventNames.ContextualMenuButtonCurrencyTransfer] = FFlagProfilePlatformEnableCurrencyTransfer
        and {
            context = Contexts.PlayerProfile,
            eventType = EventTypes.ButtonClick,
            additionalInfo = {
                btn = AnalyticsConstants.ContextualMenuButtons.CurrencyTransfer,
                optionType = "CTAType"
            },
            formatRulesForAdditionalInfo = { buttonSurface = func1 }
        }
        or nil,
    [EventNames.ContextualMenuButtonTradeItems] = FFlagProfilePlatformEnableTradeItems
        and {
            context = Contexts.PlayerProfile,
            eventType = EventTypes.ButtonClick,
            additionalInfo = {
                btn = AnalyticsConstants.ContextualMenuButtons.TradeItems,
                optionType = "CTAType"
            },
            formatRulesForAdditionalInfo = { buttonSurface = func1 }
        }
        or nil,
    [EventNames.ContextualMenuTradeItemsImpression] = FFlagProfilePlatformEnableTradeItems
        and FFlagProfileTradeItemsImpressionLogging
        and {
            context = Contexts.PlayerProfile,
            eventType = EventTypes.UserSeen,
            additionalInfo = {
                btn = AnalyticsConstants.ContextualMenuButtons.TradeItems,
                optionType = "CTAType"
            },
            formatRulesForAdditionalInfo = { buttonSurface = func1 }
        }
        or nil,
    [EventNames.CTAButtonOpenEditProfilePage] = {
        context = Contexts.PlayerProfile,
        eventType = EventTypes.ButtonClick,
        additionalInfo = {
            btn = AnalyticsConstants.CTAButtons.OpenEditProfilePage
        },
        formatRulesForAdditionalInfo = { buttonSurface = func1 }
    },
    [EventNames.CTAButtonCall] = FFlagFriendsCallingClientGate_DEV
        and {
            context = Contexts.PlayerProfile,
            eventType = EventTypes.ButtonClick,
            additionalInfo = {
                btn = AnalyticsConstants.CTAButtons.Call
            },
            formatRulesForAdditionalInfo = { buttonSurface = func1 }
        }
        or nil,
    [EventNames.CTAButtonChat] = {
        context = Contexts.PlayerProfile,
        eventType = EventTypes.ButtonClick,
        additionalInfo = {
            btn = AnalyticsConstants.CTAButtons.Chat
        },
        formatRulesForAdditionalInfo = { buttonSurface = func1 }
    },
    [EventNames.CTAButtonUnlockChat] = {
        context = Contexts.PlayerProfile,
        eventType = EventTypes.ButtonClick,
        additionalInfo = {
            btn = AnalyticsConstants.CTAButtons.UnlockChat
        },
        formatRulesForAdditionalInfo = { buttonSurface = func1 }
    },
    [EventNames.CTAButtonUnfriend] = {
        context = Contexts.PlayerProfile,
        eventType = EventTypes.ButtonClick,
        additionalInfo = {
            btn = AnalyticsConstants.CTAButtons.Unfriend
        },
        formatRulesForAdditionalInfo = { buttonSurface = func1 }
    },
    [EventNames.CTAButtonUnblock] = {
        context = Contexts.PlayerProfile,
        eventType = EventTypes.ButtonClick,
        additionalInfo = {
            btn = AnalyticsConstants.CTAButtons.Unblock
        },
        formatRulesForAdditionalInfo = { buttonSurface = func1 }
    },
    [EventNames.CTAButtonAddFriend] = {
        context = Contexts.PlayerProfile,
        eventType = EventTypes.ButtonClick,
        additionalInfo = {
            btn = AnalyticsConstants.CTAButtons.AddFriend
        },
        formatRulesForAdditionalInfo = {
            absolutePosition = func1,
            isHomePageCarousel = func1,
            isRecommendation = func1,
            recommendationContextType = func1,
            recommendationRank = func1,
            recommendationSessionId = func1,
            source = func1,
            contextualInfoType = func1,
            shareLinkId = func1,
            profileType = func1
        }
    },
    [EventNames.CTAButtonAddFriendFromContacts] = {
        context = Contexts.ContactImport,
        eventType = EventTypes.ButtonClick,
        additionalInfo = {
            btn = AnalyticsConstants.CTAButtons.AddFriendFromContacts
        },
        formatRulesForAdditionalInfo = { shareLinkId = func1 }
    },
    [EventNames.CTAButtonAcceptFriendRequest] = {
        context = Contexts.PlayerProfile,
        eventType = EventTypes.ButtonClick,
        additionalInfo = {
            btn = AnalyticsConstants.CTAButtons.AcceptFriendRequest
        },
        formatRulesForAdditionalInfo = {
            absolutePosition = func1,
            contextualInfoType = func1,
            isHomePageCarousel = func1,
            isRecommendation = func1,
            recommendationContextType = func1,
            recommendationRank = func1,
            recommendationSessionId = func1,
            source = func1,
            buttonSurface = func1,
            shareLinkId = func1,
            profileType = func1
        }
    },
    [EventNames.CTAButtonEditAvatar] = {
        context = Contexts.PlayerProfile,
        eventType = EventTypes.ButtonClick,
        additionalInfo = {
            btn = AnalyticsConstants.CTAButtons.EditAvatar
        },
        formatRulesForAdditionalInfo = { buttonSurface = func1 }
    },
    [EventNames.CTAButtonEditLook] = {
        context = Contexts.PlayerProfile,
        eventType = EventTypes.ButtonClick,
        additionalInfo = {
            btn = AnalyticsConstants.CTAButtons.EditLook
        },
        formatRulesForAdditionalInfo = { buttonSurface = func1 }
    },
    [EventNames.CTAButtonShareProfile] = {
        context = Contexts.PlayerProfile,
        eventType = EventTypes.ButtonClick,
        additionalInfo = {
            btn = AnalyticsConstants.CTAButtons.ShareProfile
        },
        formatRulesForAdditionalInfo = { buttonSurface = func1 }
    },
    [EventNames.CTAButtonShareProfileQRCode] = {
        context = Contexts.PlayerProfile,
        eventType = EventTypes.ButtonClick,
        additionalInfo = {
            btn = AnalyticsConstants.CTAButtons.ShareProfileQRCode
        },
        formatRulesForAdditionalInfo = { buttonSurface = func1 }
    },
    [EventNames.CTAButtonJoinCommunity] = {
        context = if FFlagProfilePlatformUseProfileTypeContext then Contexts.CommunityProfile else Contexts.PlayerProfile,
        eventType = EventTypes.ButtonClick,
        additionalInfo = {
            btn = AnalyticsConstants.CTAButtons.JoinCommunity,
            optionType = "CTAType"
        },
        formatRulesForAdditionalInfo = { buttonSurface = func1, btnContext = func1 }
    },
    [EventNames.CTAButtonFollow] = {
        context = Contexts.PlayerProfile,
        eventType = EventTypes.ButtonClick,
        additionalInfo = {
            btn = AnalyticsConstants.CTAButtons.Follow,
            optionType = "CTAType"
        },
        formatRulesForAdditionalInfo = { buttonSurface = func1 }
    },
    [EventNames.CTAButtonViewCommunity] = {
        context = if FFlagProfilePlatformUseProfileTypeContext then Contexts.CommunityProfile else Contexts.PlayerProfile,
        eventType = EventTypes.ButtonClick,
        additionalInfo = {
            btn = AnalyticsConstants.CTAButtons.ViewCommunity,
            optionType = "CTAType"
        },
        formatRulesForAdditionalInfo = { buttonSurface = func1, btnContext = func1 }
    },
    [EventNames.CTAButtonViewFullProfile] = {
        context = Contexts.PlayerProfile,
        eventType = EventTypes.ButtonClick,
        additionalInfo = {
            btn = AnalyticsConstants.CTAButtons.ViewFullProfile,
            optionType = "CTAType"
        },
        formatRulesForAdditionalInfo = { buttonSurface = func1, btnContext = func1 }
    },
    [EventNames.CTAButtonCurrencyTransfer] = FFlagProfilePlatformEnableCurrencyTransfer
        and {
            context = Contexts.PlayerProfile,
            eventType = EventTypes.ButtonClick,
            additionalInfo = {
                btn = AnalyticsConstants.CTAButtons.CurrencyTransfer,
                optionType = "CTAType"
            },
            formatRulesForAdditionalInfo = { buttonSurface = func1 }
        }
        or nil,
    [EventNames.CTAButtonTradeItems] = FFlagProfilePlatformEnableTradeItems
        and {
            context = Contexts.PlayerProfile,
            eventType = EventTypes.ButtonClick,
            additionalInfo = {
                btn = AnalyticsConstants.CTAButtons.TradeItems,
                optionType = "CTAType"
            },
            formatRulesForAdditionalInfo = { buttonSurface = func1 }
        }
        or nil,
    [EventNames.CTAButtonCancelJoinCommunityRequest] = {
        context = if FFlagProfilePlatformUseProfileTypeContext then Contexts.CommunityProfile else Contexts.PlayerProfile,
        eventType = EventTypes.ButtonClick,
        additionalInfo = {
            btn = AnalyticsConstants.CTAButtons.CancelJoinCommunityRequest,
            optionType = "CTAType"
        },
        formatRulesForAdditionalInfo = { buttonSurface = func1, btnContext = func1 }
    },
    [EventNames.SchoolButton] = {
        context = Contexts.PlayerProfile,
        eventType = EventTypes.ButtonClick,
        additionalInfo = {
            btn = AnalyticsConstants.Btns.School
        }
    },
    [EventNames.FriendsButton] = {
        context = Contexts.PlayerProfile,
        eventType = EventTypes.ButtonClick,
        additionalInfo = {
            btn = AnalyticsConstants.Btns.Friends
        }
    },
    [EventNames.FollowersButton] = {
        context = Contexts.PlayerProfile,
        eventType = EventTypes.ButtonClick,
        additionalInfo = {
            btn = AnalyticsConstants.Btns.Followers
        }
    },
    [EventNames.FollowingsButton] = {
        context = Contexts.PlayerProfile,
        eventType = EventTypes.ButtonClick,
        additionalInfo = {
            btn = AnalyticsConstants.Btns.Following
        }
    },
    [EventNames.MutualFriendsButton] = {
        context = Contexts.PlayerProfile,
        eventType = EventTypes.ButtonClick,
        additionalInfo = {
            btn = AnalyticsConstants.Btns.MutualFriends
        }
    },
    [EventNames.ViewPlayerProfileButton] = {
        context = Contexts.PlayerProfile,
        eventType = EventTypes.ButtonClick,
        additionalInfo = {
            btn = AnalyticsConstants.Btns.ViewPlayerProfile
        },
        formatRulesForAdditionalInfo = {
            absolutePosition = func1,
            friendStatus = func1,
            isHomePageCarousel = func1,
            isRecommendation = func1,
            recommendationContextType = func1,
            recommendationRank = func1,
            recommendationSessionId = func1,
            source = func1,
            buttonSurface = func1
        }
    },
    [EventNames.ContextualMenuButton] = {
        context = Contexts.PlayerProfile,
        eventType = EventTypes.ButtonClick,
        additionalInfo = {
            btn = AnalyticsConstants.Btns.ContextualMenu
        }
    },
    [EventNames.GameDetailsButton] = {
        context = Contexts.PlayerProfile,
        eventType = EventTypes.ButtonClick,
        additionalInfo = {
            btn = AnalyticsConstants.Btns.GameDetails
        }
    },
    [EventNames.EditDisplayNameButton] = {
        context = Contexts.PlayerProfile,
        eventType = EventTypes.ButtonClick,
        additionalInfo = {
            btn = AnalyticsConstants.Btns.EditDisplayName
        },
        formatRulesForAdditionalInfo = { canSetDisplayName = func1 }
    },
    [EventNames.SetAliasButton] = {
        context = Contexts.PlayerProfile,
        eventType = EventTypes.ButtonClick,
        additionalInfo = {
            btn = AnalyticsConstants.Btns.SetAlias
        }
    },
    [EventNames.ProfileClosed] = {
        context = Contexts.PlayerProfile,
        eventType = EventTypes.Dismissed
    },
    [EventNames.StoreHeaderButton] = {
        context = Contexts.PlayerProfile,
        eventType = EventTypes.ButtonClick,
        additionalInfo = {
            btn = AnalyticsConstants.Btns.StoreHeader
        }
    },
    [EventNames.FavoriteExperienceOpened] = {
        context = Contexts.PlayerProfile,
        eventType = EventTypes.ButtonClick,
        additionalInfo = {
            btn = AnalyticsConstants.Btns.FavoriteExperience
        },
        formatRulesForAdditionalInfo = { experienceId = func1, positionInComponent = func1 }
    },
    [EventNames.FavoriteExperienceSeeAll] = {
        context = Contexts.PlayerProfile,
        eventType = EventTypes.ButtonClick,
        additionalInfo = {
            btn = AnalyticsConstants.Btns.FavoriteExperienceSeeAll
        }
    },
    [EventNames.ExperienceOpened] = {
        context = if FFlagProfilePlatformUseProfileTypeContext then Contexts.CommunityProfile else Contexts.PlayerProfile,
        eventType = EventTypes.ButtonClick,
        additionalInfo = {
            btn = AnalyticsConstants.Btns.Experience
        },
        formatRulesForAdditionalInfo = { experienceId = func1, positionInComponent = func1 }
    },
    [EventNames.EventOpened] = {
        context = Contexts.CommunityProfile,
        eventType = EventTypes.ButtonClick,
        additionalInfo = {
            btn = AnalyticsConstants.Btns.Event
        },
        formatRulesForAdditionalInfo = { virtualEventId = func1 }
    },
    [EventNames.EventRSVP] = {
        context = Contexts.CommunityProfile,
        eventType = EventTypes.ButtonClick,
        additionalInfo = {
            btn = AnalyticsConstants.Btns.EventRSVP
        },
        formatRulesForAdditionalInfo = { virtualEventId = func1, status = func1 }
    },
    [EventNames.EventJoined] = {
        context = Contexts.CommunityProfile,
        eventType = EventTypes.ButtonClick,
        additionalInfo = {
            btn = AnalyticsConstants.Btns.EventJoin
        },
        formatRulesForAdditionalInfo = { virtualEventId = func1 }
    },
    [EventNames.CatalogItemOpened] = {
        context = Contexts.PlayerProfile,
        eventType = EventTypes.ButtonClick,
        additionalInfo = {
            btn = AnalyticsConstants.Btns.ViewCatalogItem
        },
        formatRulesForAdditionalInfo = FFlagProfilePlatformUseCatalogItemOpenedNewFields and {
            btnContext = func1,
            btnUnitId = func1,
            btnSortPosition = func1
        }
            or { itemId = func1, positionInComponent = func1, component = func1 }
    },
    [EventNames.UsernameCopied] = {
        context = Contexts.PlayerProfile,
        eventType = EventTypes.ButtonClick,
        additionalInfo = {
            btn = AnalyticsConstants.Btns.Username
        }
    },
    [EventNames.ContextualMenuButtonViewPlatformProfile] = FFlagEnablePlatformProfileContextualMenuOption
        and {
            context = Contexts.PlayerProfile,
            eventType = EventTypes.ButtonClick,
            additionalInfo = {
                btn = AnalyticsConstants.ContextualMenuButtons.ViewPlatformProfile,
                optionType = "CTAType"
            },
            formatRulesForAdditionalInfo = { buttonSurface = func1 }
        }
        or nil,
    [EventNames.CTAButtonEditAppearance] = FFlagProfilePlatformEnableEditAppearanceMenu
        and {
            context = Contexts.PlayerProfile,
            eventType = EventTypes.ButtonClick,
            additionalInfo = {
                btn = AnalyticsConstants.CTAButtons.EditAppearance
            },
            formatRulesForAdditionalInfo = { buttonSurface = func1 }
        }
        or nil,
    [EventNames.EditAppearanceMenuEditAvatar] = FFlagProfilePlatformEnableEditAppearanceMenu
        and {
            context = Contexts.PlayerProfile,
            eventType = EventTypes.ButtonClick,
            additionalInfo = {
                btn = AnalyticsConstants.Btns.EditAppearanceEditAvatar
            },
            formatRulesForAdditionalInfo = { buttonSurface = func1 }
        }
        or nil,
    [EventNames.EditAppearanceMenuEditEmote] = FFlagProfilePlatformEnableEditAppearanceMenu
        and {
            context = Contexts.PlayerProfile,
            eventType = EventTypes.ButtonClick,
            additionalInfo = {
                btn = AnalyticsConstants.Btns.EditAppearanceEditEmote
            },
            formatRulesForAdditionalInfo = { buttonSurface = func1 }
        }
        or nil,
    [EventNames.EditAppearanceMenuSwitchAvatar] = FFlagProfilePlatformEnableEditAppearanceMenu
        and {
            context = Contexts.PlayerProfile,
            eventType = EventTypes.ButtonClick,
            additionalInfo = {
                btn = AnalyticsConstants.Btns.EditAppearanceSwitchAvatar
            },
            formatRulesForAdditionalInfo = { buttonSurface = func1 }
        }
        or nil,
    [EventNames.EditAppearanceMenuEditBackground] = FFlagProfilePlatformEnableEditAppearanceMenu
        and FFlagProfilePlatformEditBackgroundMenuItem
        and {
            context = Contexts.PlayerProfile,
            eventType = EventTypes.ButtonClick,
            additionalInfo = {
                btn = AnalyticsConstants.Btns.EditAppearanceEditBackground
            },
            formatRulesForAdditionalInfo = { buttonSurface = func1 }
        }
        or nil,
    [EventNames.InspectAvatarOpened] = FFlagSocialEnableProfileInspectAndBuyAnalytics
        and {
            context = Contexts.PlayerProfile,
            eventType = EventTypes.ButtonClick,
            additionalInfo = {
                btn = AnalyticsConstants.Btns.InspectAvatar
            },
            formatRulesForAdditionalInfo = { profileSessionId = func1 }
        }
        or nil,
    [EventNames.InspectAvatarBuyClicked] = FFlagSocialEnableProfileInspectAndBuyAnalytics
        and {
            context = Contexts.PlayerProfile,
            eventType = EventTypes.ButtonClick,
            additionalInfo = {
                btn = AnalyticsConstants.Btns.InspectAvatarBuyItems
            },
            formatRulesForAdditionalInfo = {
                profileSessionId = func1,
                itemIds = func1,
                totalPrice = func1
            }
        }
        or nil,
    [EventNames.InspectAvatarPurchaseConfirmed] = FFlagSocialEnableProfileInspectAndBuyAnalytics
        and {
            context = Contexts.PlayerProfile,
            eventType = EventTypes.ButtonClick,
            additionalInfo = {
                btn = AnalyticsConstants.Btns.InspectAvatarConfirmBuy
            },
            formatRulesForAdditionalInfo = { profileSessionId = func1 }
        }
        or nil,
    [EventNames.MomentsSeeAll] = {
        context = Contexts.PlayerProfile,
        eventType = EventTypes.ButtonClick,
        additionalInfo = {
            btn = AnalyticsConstants.Btns.MomentsSeeAll
        }
    },
    [EventNames.MomentOpened] = {
        context = Contexts.PlayerProfile,
        eventType = EventTypes.ButtonClick,
        additionalInfo = {
            btn = AnalyticsConstants.Btns.Moment
        }
    }
}
