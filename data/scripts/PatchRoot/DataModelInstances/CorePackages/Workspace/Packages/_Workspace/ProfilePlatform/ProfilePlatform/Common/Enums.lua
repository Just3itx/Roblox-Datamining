-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T04:40:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent
local FFlagAddIEMProfilePage = require(ProfilePlatformParent.SharedFlags).FFlagAddIEMProfilePage

local FFlagProfilePlatformEnableCurrencyTransfer = require(ProfilePlatformParent.SharedFlags).FFlagProfilePlatformEnableCurrencyTransfer
local FFlagProfilePlatformEnableTradeItems = require(ProfilePlatform.Flags.FFlagProfilePlatformEnableTradeItems)
local FFlagEnableProfileCompletion = require(ProfilePlatformParent.SharedFlags).FFlagEnableProfileCompletion

local FFlagProfilePlatformEnableEditAppearanceMenu = require(ProfilePlatform.Flags.FFlagProfilePlatformEnableEditAppearanceMenu)

local FFlagProfilePlatformEditBackgroundMenuItem = require(ProfilePlatform.Flags.FFlagProfilePlatformEditBackgroundMenuItem)
local FFlagSocialEnableProfileInspectAndBuy = require(ProfilePlatformParent.SharedFlags).FFlagSocialEnableProfileInspectAndBuy
local FFlagProfilePlatformEnableMoments = require(ProfilePlatform.Flags.FFlagProfilePlatformEnableMoments)
local FFlagFriendsCallingClientGate_DEV = require(ProfilePlatformParent.SharedFlags).FFlagFriendsCallingClientGate_DEV
local FFlagUseUserCtaCommonEnums = require(ProfilePlatformParent.SharedFlags).FFlagUseUserCtaCommonEnums
local FFlagJoinabilityCTARefactor = require(ProfilePlatformParent.SharedFlags).FFlagJoinabilityCTARefactor

local UserCtaCommon = require(ProfilePlatformParent.UserCtaCommon)
local UserCtaAction = if FFlagUseUserCtaCommonEnums then UserCtaCommon.Enums.UserCtaAction else nil

return {
    Components = {
        About = "About",
        Actions = "Actions",
        CoverPhoto = "CoverPhoto",
        CurrentlyWearing = "CurrentlyWearing",
        FavoriteExperiences = "FavoriteExperiences",
        Store = "Store",
        SocialLinks = "SocialLinks",
        UserProfileHeader = "UserProfileHeader",
        ViewFullProfile = "ViewFullProfile",
        Inventory = "Inventory",
        CommunityProfileHeader = "CommunityProfileHeader",
        Experiences = "Experiences",
        ContactProfileHeader = "ContactProfileHeader",
        ContactDescription = "ContactDescription",
        CommunityLocked = "CommunityLocked",
        CommunityDeactivated = "CommunityDeactivated",
        ProfileBackground = "ProfileBackground",
        ProfileCompletion = if FFlagEnableProfileCompletion then "ProfileCompletion" else "",
        Events = "Events",
        CurrentlyPlaying = "CurrentlyPlaying",
        Friends = "Friends",
        Moments = if FFlagProfilePlatformEnableMoments then "UserMoments" else "",
        Announcements = "Announcements",
        GroupForumsDiscovery = "ForumsDiscovery"
    },
    ProfileActions = not FFlagUseUserCtaCommonEnums
        and {
            AcceptFriendRequest = "AcceptFriendRequest",
            AcceptOffNetworkFriendRequest = "AcceptOffNetworkFriendRequest",
            AddFriend = "AddFriend",
            AddFriendFromContacts = "AddFriendFromContacts",
            AddFriendFromContactsSent = "AddFriendFromContactsSent",
            AddTrustedConnection = "AddTrustedConnection",
            AddTrustedConnectionViaLink = "AddTrustedConnectionViaLink",
            AddIncomingTrustedConnection = "AddIncomingTrustedConnection",
            PendingTrustedConnection = "PendingTrustedConnection",
            PendingIncomingTrustedConnection = "PendingIncomingTrustedConnection",
            Block = "Block",
            CannotAddFriend = "CannotAddFriend",
            Call = if FFlagFriendsCallingClientGate_DEV then "Call" else "",
            Chat = "Chat",
            EditAlias = "EditAlias",
            EditAppearance = if FFlagProfilePlatformEnableEditAppearanceMenu then "EditAppearance" else "",
            EditAvatar = "EditAvatar",
            EditLook = "EditLook",
            EditEmotes = if FFlagProfilePlatformEnableEditAppearanceMenu then "EditEmotes" else "",
            SwitchAvatar = if FFlagProfilePlatformEnableEditAppearanceMenu then "SwitchAvatar" else "",
            EditBackground = if FFlagProfilePlatformEnableEditAppearanceMenu and FFlagProfilePlatformEditBackgroundMenuItem then "EditBackground" else "",
            EditProfile = "EditProfile",
            IgnoreFriendRequest = "IgnoreFriendRequest",
            JoinExperience = "JoinExperience",
            PendingFriendRequest = "PendingFriendRequest",
            QrCode = "QrCode",
            Report = "Report",
            ShareProfile = "ShareProfile",
            Unblock = "Unblock",
            Unfriend = "Unfriend",
            CopyLink = "CopyLink",
            JoinCommunity = "JoinCommunity",
            CancelJoinCommunityRequest = "CancelJoinCommunityRequest",
            ViewCommunity = "ViewCommunity",
            ViewFullProfile = "ViewFullProfile",
            LeaveCommunity = "LeaveCommunity",
            MakePrimaryCommunity = "MakePrimaryCommunity",
            RemovePrimaryCommunity = "RemovePrimaryCommunity",
            Follow = "Follow",
            Unfollow = "Unfollow",
            RemoveTrustedConnection = "RemoveTrustedConnection",
            ViewPlatformProfile = "ViewPlatformProfile",
            ViewAbout = "ViewAbout",
            CurrencyTransfer = if FFlagProfilePlatformEnableCurrencyTransfer then "CurrencyTransfer" else "",
            TradeItems = if FFlagProfilePlatformEnableTradeItems then "TradeItems" else "",
            ContextualOverflow = "ContextualOverflow",
            UnlockChat = "UnlockChat",
            PlayExperience = if FFlagJoinabilityCTARefactor then "PlayExperience" else "",
            ViewProfile = "",
            UnlockExperience = ""
        }
        or (function() -- name: buildSharedProfileActions
            local var1 = table.clone(UserCtaAction)

            var1.Call = if FFlagFriendsCallingClientGate_DEV then UserCtaAction.Call else ""
            var1.EditAppearance = if FFlagProfilePlatformEnableEditAppearanceMenu then UserCtaAction.EditAppearance else ""

            var1.EditEmotes = if FFlagProfilePlatformEnableEditAppearanceMenu then UserCtaAction.EditEmotes else ""
            var1.SwitchAvatar = if FFlagProfilePlatformEnableEditAppearanceMenu then UserCtaAction.SwitchAvatar else ""

            var1.EditBackground = if FFlagProfilePlatformEnableEditAppearanceMenu and FFlagProfilePlatformEditBackgroundMenuItem then UserCtaAction.EditBackground else ""

            var1.CurrencyTransfer = if FFlagProfilePlatformEnableCurrencyTransfer then UserCtaAction.CurrencyTransfer else ""

            var1.TradeItems = if FFlagProfilePlatformEnableTradeItems then UserCtaAction.TradeItems else ""
            var1.ContextualOverflow = UserCtaAction.ContextualOverflow

            var1.PlayExperience = if FFlagJoinabilityCTARefactor then UserCtaAction.PlayExperience else ""
            var1.ViewProfile = if FFlagJoinabilityCTARefactor then UserCtaAction.ViewProfile else ""
            var1.UnlockExperience = if FFlagJoinabilityCTARefactor then UserCtaAction.UnlockExperience else ""

            return var1
        end)(),
    DisabledReasons = {
        BannedFromCommunity = "BannedFromCommunity",
        CommunityIsClosed = "CommunityIsClosed",
        MaxCommunitiesJoined = "MaxCommunitiesJoined",
        InsufficientVerificationLevelLow = "InsufficientVerificationLevelLow",
        InsufficientVerificationLevelMedium = "InsufficientVerificationLevelMedium",
        InsufficientVerificationLevelHigh = "InsufficientVerificationLevelHigh",
        AccountCreatedLessThanOneDay = "AccountCreatedLessThanOneDay",
        AccountCreatedLessThanThreeDays = "AccountCreatedLessThanThreeDays",
        AccountCreatedLessThanOneWeek = "AccountCreatedLessThanOneWeek",
        AccountCreatedLessThanOneMonth = "AccountCreatedLessThanOneMonth",
        AccountCreatedLessThanThreeMonths = "AccountCreatedLessThanThreeMonths"
    },
    ProfileTypes = { User = "User", Community = "Community", Contact = "Contact" },
    Sources = {
        HomepageFriendsCarousel = "HomepageFriendsCarousel",
        OffNetworkFriendRequest = "OffNetworkFriendRequest",
        PlayerSearch = "PlayerSearch",
        ProfileDeepLink = "ProfileDeepLink",
        ProfileShare = "ProfileShare",
        QrCode = "QrCode",
        HomepageAd = "HomepageAd",
        ItemDetailsPage = "ItemDetailsPage",
        MutualConnectionsList = "MutualConnectionsList",
        InExperienceProfile = if FFlagAddIEMProfilePage then "InExperienceProfile" else "",
        JoinGameCard = "JoinGameCard",
        MomentsFeed = if FFlagProfilePlatformEnableMoments then "MomentsFeed" else "",
        SchoolMemberList = "SchoolMemberList"
    },
    ContextualTypes = {
        AccountDeleted = "AccountDeleted",
        Presence = "Presence",
        IsYourself = "IsYourself",
        PreviousUsername = "PreviousUsername",
        YouAreFollowing = "YouAreFollowing",
        FollowsYou = "FollowsYou",
        MutualFriends = "MutualFriends",
        PlayedTogether = "PlayedTogether",
        OffNetworkFriendRequest = "OffNetworkFriendRequest",
        SentFromQrCode = "SentFromQrCode",
        SentFromExperience = "SentFromExperience"
    },
    PresenceTypes = {
        Online = "Online",
        Offline = "Offline",
        InGame = "InGame",
        InStudio = "InStudio"
    },
    Screens = {
        ProfileMain = "ProfileMain",
        ItemDetails = "ItemDetails",
        ItemOrBundleDetails = "ItemOrBundleDetails",
        EditProfilePage = "EditProfilePage",
        EditDisplayNameErrorModal = "EditDisplayNameErrorModal",
        UsernameInsufficientFundsModal = "UsernameInsufficientFundsModal",
        SetAliasModal = "SetAliasModal",
        SetNicknameModal = "SetNicknameModal",
        ContextualMenu = "ContextualMenu",
        EditProfileBackground = "EditProfileBackground",
        CommunityVerificationModal = "CommunityVerificationModal",
        TransferRobuxFlow = if FFlagProfilePlatformEnableCurrencyTransfer then "TransferRobuxFlow" else "",
        PurchaseConfirmationModal = "PurchaseConfirmationModal",
        InsufficientRobuxDialog = if FFlagSocialEnableProfileInspectAndBuy then "InsufficientRobuxDialog" else "",
        InspectAvatarSheet = if FFlagSocialEnableProfileInspectAndBuy then "InspectAvatarSheet" else "",
        MomentsAll = if FFlagProfilePlatformEnableMoments then "MomentsAll" else "",
        MomentsFeed = if FFlagProfilePlatformEnableMoments then "MomentsFeed" else ""
    },
    NameTypes = { Alias = "Alias", DisplayName = "DisplayName", Username = "Username" },
    ButtonSurface = { Actions = "Actions", ContextualMenu = "ContextualMenu" },
    ItemTypes = { Asset = "Asset", Bundle = "Bundle" },
    FriendStatus = {
        Self = "self",
        NotFriends = "nonfriend",
        Friends = "friend",
        RequestSent = "requestSent",
        RequestReceived = "requestReceived",
        Ineligible = "ineligible",
        Unknown = "unknown"
    },
    PriceLineContentType = { Price = "price", Text = "text" },
    SocialMediaTypes = {
        Twitter = "twitter",
        Facebook = "facebook",
        Discord = "discord",
        YouTube = "youtube",
        Twitch = "twitch",
        Guilded = "guilded",
        X = "x"
    },
    ViewFullProfileTypes = { Profile = "Profile", Community = "Community" },
    ProfileFormFactor = { Wide = "Wide", PeekView = "PeekView" },
    ProfileTabVariants = { Default = "Default", MeTab = "MeTab" },
    ProfileAvatarLayoutVariant = { Default = "Default", MeTabMobile = "MeTabMobile" },
    LoadingState = { Failed = "Failed", Finished = "Finished", Loading = "Loading" },
    SocialCountEnableKeys = {
        IsFriendsCountEnabled = "isFriendsCountEnabled",
        IsFollowersCountEnabled = "isFollowersCountEnabled",
        IsFollowingsCountEnabled = "isFollowingsCountEnabled",
        IsMutualFriendsCountEnabled = "isMutualFriendsCountEnabled"
    }
}
