-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:51:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent
local React = require(ProfilePlatformParent.React)
local RoactUtils = require(ProfilePlatformParent.RoactUtils)
local Navigation = require(ProfilePlatformParent.Navigation)
local SocialExperienceJoin = require(ProfilePlatformParent.SocialExperienceJoin)
local SharedFlags = require(ProfilePlatformParent.SharedFlags)

local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local useSelector = RoactUtils.Hooks.RoactRodux.useSelector
local useProfileWrapperContext = require(ProfilePlatform.Contexts.useProfileWrapperContext)
local useNavigation = Navigation.useNavigation

local useLocalization = require(ProfilePlatformParent.Localization).Hooks.useLocalization
local useJoinUserInExperience = SocialExperienceJoin.useJoinUserInExperience
local useLocalUserId = require(ProfilePlatformParent.RobloxAppHooks).useLocalUserId
local ProfileShareLinks = require(ProfilePlatformParent.ProfileShareLinks)
local Contexts = require(ProfilePlatformParent.SocialLuaAnalytics).Analytics.Enums.Contexts

local TextKeys = require(ProfilePlatform.Common.TextKeys)

local useAboutSections = require(ProfilePlatform.Hooks.useAboutSections)
local useActionsComponentRequest = require(ProfilePlatform.Hooks.useActionsComponentRequest)
local useProfileAnalyticsContext = require(ProfilePlatform.Contexts.useProfileAnalyticsContext)
local useProfileJson = require(ProfilePlatform.Hooks.useProfileJson)
local viewerOwnsOpenCommunity = require(ProfilePlatform.Utils.viewerOwnsOpenCommunity)
local Enums = require(ProfilePlatform.Common.Enums)
local useProfileShareLink = ProfileShareLinks.Hooks.useProfileShareLink
local useShortUrl = ProfileShareLinks.Hooks.useShortUrl
local useGetOrGenerateLinkUrl = ProfileShareLinks.Hooks.useGetOrGenerateLinkUrl
local useEffectOnce = RoactUtils.Hooks.useEffectOnce

local FFlagProfilePlatformAddTC = SharedFlags.FFlagProfilePlatformAddTC

local FFlagEnablePlatformProfileContextualMenuOption = require(ProfilePlatformParent.SharedFlags).FFlagEnablePlatformProfileContextualMenuOption
local FFlagProfilePlatformNewProfileHeader = SharedFlags.FFlagProfilePlatformNewProfileHeader
local FFlagProfileAboutDetailsUseSheet = SharedFlags.FFlagProfileAboutDetailsUseSheet

local FFlagProfilePlatformPassPresenceToJoinUserInExperience = SharedFlags.FFlagProfilePlatformPassPresenceToJoinUserInExperience

local FFlagProfilePlatformPresenceStoreMigration = require(ProfilePlatform.Flags.FFlagProfilePlatformPresenceStoreMigration)
local useGetPresenceByUserId = if FFlagProfilePlatformPresenceStoreMigration then require(ProfilePlatformParent.FriendsCommon).Hooks.useGetPresenceByUserId else nil
local FFlagProfilePlatformRefreshActionsRespectPolicies = require(ProfilePlatform.Flags.FFlagProfilePlatformRefreshActionsRespectPolicies)

local FFlagProfilePlatformEnableCurrencyTransfer = SharedFlags.FFlagProfilePlatformEnableCurrencyTransfer
local FFlagProfilePlatformEnableTradeItems = require(ProfilePlatform.Flags.FFlagProfilePlatformEnableTradeItems)

local FFlagProfilePlatformEnableEditAppearanceMenu = require(ProfilePlatform.Flags.FFlagProfilePlatformEnableEditAppearanceMenu)

local FFlagProfilePlatformEditBackgroundMenuItem = require(ProfilePlatform.Flags.FFlagProfilePlatformEditBackgroundMenuItem)
local FFlagProfilePlatformEnableEditLook = require(ProfilePlatform.Flags.FFlagProfilePlatformEnableEditLook)
local FFlagHideLeaveFromOpenCommunityOwner = require(ProfilePlatform.Flags.FFlagHideLeaveFromOpenCommunityOwner)
local FFlagJoinabilityCTARefactor = SharedFlags.FFlagJoinabilityCTARefactor
local FFlagJoinabilityCTAContextCopy = SharedFlags.FFlagJoinabilityCTAContextCopy

local ProfileActions = require(ProfilePlatform.Components.CTARow.ProfileActions)
local _AbuseVector = require(ProfilePlatformParent.GenericAbuseReporting.AbuseVector)

local Presence = require(ProfilePlatform.Rodux.Presence)
local FFlagProfilePlatformEnableUserFollow = require(ProfilePlatform.Flags.FFlagProfilePlatformEnableUserFollow)

local str1 = tostring(DateTime.now().UnixTimestampMillis)

local tbl1 = { skipFetch = true }

return function(buttonSurface)
    local localUserId = useLocalUserId()
    local dispatch = useDispatch()
    local navigation = useNavigation()
    local profileWrapperContext = useProfileWrapperContext()
    local navigateToTransfer = if profileWrapperContext.navigateTo then profileWrapperContext.navigateTo.navigateToTransfer or nil else nil
    local analytics = useProfileAnalyticsContext()
    local var6 = useShortUrl()
    local var7 = useGetOrGenerateLinkUrl()
    useEffectOnce(var7, var6 == nil)

    local profileShareLinkUrl = React.useMemo(function(): string
        return string.format("%s&source=ProfileShare&stamp=%s", var6 or "", str1)
    end, { var6 })

    local acceptFriend = TextKeys.AcceptFriend
    local addFriend = TextKeys.AddFriend

    local localized = useLocalization({
        [Enums.ProfileActions.AcceptFriendRequest] = acceptFriend,
        [Enums.ProfileActions.AcceptOffNetworkFriendRequest] = acceptFriend,
        [Enums.ProfileActions.AddFriend] = addFriend,
        [Enums.ProfileActions.AddFriendFromContacts] = addFriend,
        [Enums.ProfileActions.AddFriendFromContactsSent] = TextKeys.PendingRequest,
        [Enums.ProfileActions.AddTrustedConnection] = if FFlagProfilePlatformAddTC then TextKeys.AddTrustedConnection else nil,
        [Enums.ProfileActions.AddIncomingTrustedConnection] = if FFlagProfilePlatformAddTC then TextKeys.AcceptTrustedConnection else nil,
        [Enums.ProfileActions.Block] = TextKeys.Block,
        [Enums.ProfileActions.CannotAddFriend] = addFriend,
        [Enums.ProfileActions.Chat] = TextKeys.Chat,
        [Enums.ProfileActions.UnlockChat] = TextKeys.UnlockChat,
        [Enums.ProfileActions.EditAlias] = TextKeys.CustomizeName,
        [Enums.ProfileActions.EditAppearance] = if FFlagProfilePlatformEnableEditAppearanceMenu then TextKeys.EditAppearance else nil,
        [Enums.ProfileActions.EditEmotes] = if FFlagProfilePlatformEnableEditAppearanceMenu then TextKeys.EditEmotes else nil,
        [Enums.ProfileActions.SwitchAvatar] = if FFlagProfilePlatformEnableEditAppearanceMenu then TextKeys.SwitchAvatar else nil,
        [Enums.ProfileActions.EditBackground] = if FFlagProfilePlatformEnableEditAppearanceMenu and FFlagProfilePlatformEditBackgroundMenuItem then TextKeys.EditBackground else nil,
        [Enums.ProfileActions.EditAvatar] = TextKeys.EditAvatar,
        [Enums.ProfileActions.EditLook] = if FFlagProfilePlatformEnableEditLook then TextKeys.EditLook else nil,
        [Enums.ProfileActions.EditProfile] = TextKeys.EditProfile,
        [Enums.ProfileActions.IgnoreFriendRequest] = TextKeys.IgnoreFriendRequest,
        [Enums.ProfileActions.JoinExperience] = TextKeys.Join,
        [Enums.ProfileActions.PlayExperience] = if FFlagJoinabilityCTAContextCopy then TextKeys.Play elseif FFlagJoinabilityCTARefactor then TextKeys.Join else nil,
        [Enums.ProfileActions.PendingFriendRequest] = TextKeys.PendingRequest,
        [Enums.ProfileActions.QrCode] = TextKeys.ToQRCode,
        [Enums.ProfileActions.Report] = TextKeys.Report,
        [Enums.ProfileActions.ShareProfile] = TextKeys.ShareProfile,
        [Enums.ProfileActions.Unblock] = TextKeys.Unblock,
        [Enums.ProfileActions.Unfriend] = TextKeys.Unfriend,
        [Enums.ProfileActions.CopyLink] = TextKeys.CopyLink,
        [Enums.ProfileActions.JoinCommunity] = TextKeys.JoinCommunity,
        [Enums.ProfileActions.CancelJoinCommunityRequest] = TextKeys.CancelJoinCommunityRequest,
        [Enums.ProfileActions.ViewCommunity] = TextKeys.ViewCommunity,
        [Enums.ProfileActions.ViewFullProfile] = TextKeys.ViewFullProfile,
        [Enums.ProfileActions.LeaveCommunity] = TextKeys.LeaveCommunity,
        [Enums.ProfileActions.MakePrimaryCommunity] = TextKeys.MakePrimaryCommunity,
        [Enums.ProfileActions.RemovePrimaryCommunity] = TextKeys.RemovePrimaryCommunity,
        [Enums.ProfileActions.Follow] = TextKeys.Follow,
        [Enums.ProfileActions.Unfollow] = TextKeys.Unfollow,
        [Enums.ProfileActions.RemoveTrustedConnection] = TextKeys.RemoveTrustedConnection,
        [Enums.ProfileActions.ViewAbout] = if FFlagProfilePlatformNewProfileHeader then TextKeys.AboutThisProfile else nil,
        [Enums.ProfileActions.ViewPlatformProfile] = if FFlagEnablePlatformProfileContextualMenuOption then TextKeys.ViewPlatformProfile else nil,
        [Enums.ProfileActions.CurrencyTransfer] = if FFlagProfilePlatformEnableCurrencyTransfer then TextKeys.CurrencyTransfer else nil,
        [Enums.ProfileActions.TradeItems] = if FFlagProfilePlatformEnableTradeItems then TextKeys.TradeItems else nil,
        friendAcceptedToast = TextKeys.FriendAdded,
        friendRemovedToast = TextKeys.FriendRemoved,
        trustedConnectionRemovedToast = TextKeys.TrustedConnectionRemoved,
        friendRequestSentToast = TextKeys.FriendRequestSent,
        friendRequestIgnoredToast = TextKeys.RequestIgnored,
        followedToast = if FFlagProfilePlatformEnableUserFollow then TextKeys.Followed else nil,
        unfollowedToast = if FFlagProfilePlatformEnableUserFollow then TextKeys.Unfollowed else nil,
        userBlockedToast = TextKeys.UserBlocked,
        blockLimitReachedToast = TextKeys.BlockLimitReached,
        blocktargetAlreadyBlockedToast = TextKeys.BlockTargetAlreadyBlocked,
        blockedOnPlatformToast = TextKeys.UnblockTargetBlockedOnPlatform,
        unblockTargetNotBlockedToast = TextKeys.UnblockTargetNotBlocked,
        unblockTargetParentManagedToast = TextKeys.UnblockTargetParentManaged,
        somethingIsWrongToast = TextKeys.SomethingIsWrong,
        alreadyFriendError = TextKeys.AlreadyFriendError,
        defaultFriendingError = TextKeys.DefaultFriendingError,
        invalidNicknameError = TextKeys.InvalidNicknameError,
        invalidTargetUserError = TextKeys.InvalidTargetUserError,
        maxFriendsError = TextKeys.MaxFriendsError,
        unauthorizedError = TextKeys.UnauthorizedError,
        userBannedError = TextKeys.UserBannedError,
        userBlockedError = TextKeys.UserBlockedError,
        userNotPassedCaptchaError = TextKeys.UserNotPassedCaptchaError,
        tooManyRequestsError = TextKeys.TooManyRequestsError
    })
    local openGameDetailsPeekViewClosed = React.useCallback(function()
        profileWrapperContext.navigateTo.previousView(true)
    end, { profileWrapperContext.navigateTo.previousView })
    local profileId = profileWrapperContext.profileId
    local profileType = profileWrapperContext.profileType

    local var11 = if FFlagProfilePlatformPresenceStoreMigration then useGetPresenceByUserId(profileId, tbl1) elseif FFlagProfilePlatformPassPresenceToJoinUserInExperience then useSelector(function(arg1)
        return Presence.Selectors.getUserPresenceByUserId(arg1, profileId)
            or {
                userPresenceType = Presence.Enums.PresenceType.Offline,
                lastLocation = ""
            }
    end) else nil

    local aboutSections, profileName

    if FFlagProfilePlatformNewProfileHeader then
        local var12 = useAboutSections()
        aboutSections = var12.aboutSections
        if FFlagProfileAboutDetailsUseSheet then
            profileName = var12.profileName
        else
            profileName = nil
        end
    else
        aboutSections = nil
        profileName = nil
    end

    local var12 = if FFlagProfilePlatformRefreshActionsRespectPolicies then useActionsComponentRequest() else nil
    local var13 = if FFlagHideLeaveFromOpenCommunityOwner then useProfileJson() else nil
    local var1 = if FFlagHideLeaveFromOpenCommunityOwner and profileType == Enums.ProfileTypes.Community then viewerOwnsOpenCommunity(var13, localUserId) else false
    local var15 = useJoinUserInExperience
    local tbl2 = {
        isHomePageCarousel = profileWrapperContext.sourceInfo.source == Enums.Sources.HomepageFriendsCarousel,
        homepageCarouselAbsolutePosition = profileWrapperContext.sourceInfo.homepageCarouselAbsolutePosition,
        openGameDetailsPeekViewClosed = openGameDetailsPeekViewClosed,
        presence = 0
    }

    if not FFlagProfilePlatformPassPresenceToJoinUserInExperience then
        var11 = nil
    end

    tbl2.presence = var11
    local experienceUtilities = var15(profileId, tbl2)

    local qRCodePage = profileWrapperContext.navigateTo.qRCodePage
    local editUsername = profileWrapperContext.navigateTo.editUsername
    local editEmotes = if FFlagProfilePlatformEnableEditAppearanceMenu then profileWrapperContext.navigateTo.editEmotes else nil
    local switchAvatar = if FFlagProfilePlatformEnableEditAppearanceMenu then profileWrapperContext.navigateTo.switchAvatar else nil
    local editAvatar = profileWrapperContext.navigateTo.editAvatar

    local profileShareLink = useProfileShareLink({ context = Contexts.ProfileCard })

    local tbl3 = {
        localized = localized,
        analytics = analytics,
        buttonSurface = buttonSurface,
        profileWrapperContext = profileWrapperContext,
        navigateTo = profileWrapperContext.navigateTo,
        dispatch = dispatch,
        profileId = profileId,
        localUserId = localUserId,
        navigation = navigation,
        profileType = profileType,
        experienceUtilities = experienceUtilities,
        profileShareLink = profileShareLink,
        PROFILE_SHARE_LINK_URL = profileShareLinkUrl,
        aboutSections = if FFlagProfilePlatformNewProfileHeader then aboutSections else nil,
        aboutProfileName = if FFlagProfileAboutDetailsUseSheet then profileName else nil,
        actionsComponentRequest = if FFlagProfilePlatformRefreshActionsRespectPolicies then var12 else nil,
        viewerOwnsOpenCommunity = var1
    }

    local useMemo = React.useMemo

    local function func1()
        local result = ({})
        for k, profileAction in ProfileActions do
            local var18 = profileAction(tbl3)
            if var18 ~= nil then
                result[k] = var18
            end
        end
        return result
    end

    if not FFlagProfilePlatformEnableCurrencyTransfer then
        navigateToTransfer = nil
    end

    local joinExperience = experienceUtilities.joinExperience
    local playExperience = if FFlagJoinabilityCTARefactor then experienceUtilities.playExperience else nil
    local isLoading = experienceUtilities.isLoading

    if not FFlagProfilePlatformNewProfileHeader then
        aboutSections = nil
    end

    if not FFlagProfileAboutDetailsUseSheet then
        profileName = nil
    end

    local tableValue1 = dispatch
    local tableValue2 = profileId
    local tableValue3 = profileWrapperContext
    local tableValue4 = navigateToTransfer
    local tableValue5 = qRCodePage
    local tableValue6 = localized
    local tableValue7 = localUserId
    local tableValue8 = navigation
    local tableValue9 = editUsername
    local tableValue10 = joinExperience
    local tableValue11 = playExperience
    local tableValue12 = isLoading
    local tableValue13 = analytics
    local tableValue14 = buttonSurface
    local tableValue15 = aboutSections
    local tableValue16 = profileName

    if not FFlagProfilePlatformEnableEditAppearanceMenu then
        editEmotes = nil
    end

    if not FFlagProfilePlatformEnableEditAppearanceMenu then
        switchAvatar = nil
    end
    local isInExperience = experienceUtilities.isInExperience

    if not FFlagProfilePlatformRefreshActionsRespectPolicies then
        var12 = nil
    end

    return (useMemo(func1, {
        tableValue1,
        tableValue2,
        tableValue3,
        tableValue4,
        tableValue5,
        tableValue6,
        tableValue7,
        tableValue8,
        tableValue9,
        tableValue10,
        tableValue11,
        tableValue12,
        tableValue13,
        tableValue14,
        tableValue15,
        tableValue16,
        profileType,
        editAvatar,
        editEmotes,
        switchAvatar,
        profileShareLinkUrl,
        isInExperience,
        tbl3,
        var12,
        var1
    }))
end
