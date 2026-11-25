-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:30:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent
local React = require(ProfilePlatformParent.React)
local SharedFlags = require(ProfilePlatformParent.SharedFlags)
local View = require(ProfilePlatformParent.Foundation).View

local Constants = require(ProfilePlatform.Common.Constants)
local Enums = require(ProfilePlatform.Common.Enums)
local SocialIdentityContainer = require(ProfilePlatform.Components.UserProfileHeader.SocialIdentityContainer)
local ContextualInformation = require(ProfilePlatform.Components.UserProfileHeader.ContextualInformation)

local SocialChipCountsRowContainer = require(ProfilePlatform.Components.UserProfileHeader.SocialChipCountsRow).SocialChipCountsRowContainer
local UserProfileAvatar = require(ProfilePlatform.Components.UserProfileHeader.UserProfileAvatar)
local UserProfileSettingsToggle = require(ProfilePlatform.Components.UserProfileHeader.UserProfileSettingsToggle)
local AvatarHeadshotComponent = require(ProfilePlatform.Components.UserProfileHeader.AvatarHeadshotComponent)
local InspectAvatarTooltip = require(ProfilePlatform.Components.InspectAvatar.InspectAvatarTooltip)

local FFlagMoveInExperienceModeToEditProfile = require(ProfilePlatformParent.SharedFlags).FFlagMoveInExperienceModeToEditProfile
local bool1 = game:DefineFastFlag("DisableStreamerModeToggle", false)
local FFlagProfilePlatformNewProfileHeader = SharedFlags.FFlagProfilePlatformNewProfileHeader
local FFlagSwitchProfileWidthHookToSocialCommon = SharedFlags.FFlagSwitchProfileWidthHookToSocialCommon
local FFlagAddPlatformNameToProfileHeader = SharedFlags.FFlagAddPlatformNameToProfileHeader
local useProfileFormFactor = require(ProfilePlatform.Hooks.useProfileFormFactor)
local useProfileCardWidth = require(ProfilePlatform.Hooks.useProfileCardWidth)
local useProfileCardWidth2 = require(ProfilePlatformParent.ProfilePlatformCommon).Hooks.useProfileCardWidth
local useShouldShowContextualInformation = require(ProfilePlatform.Hooks.useShouldShowContextualInformation)
local useProfileWrapperContext = require(ProfilePlatform.Contexts.useProfileWrapperContext)
local useShouldResizeAvatar = require(ProfilePlatform.Hooks.useShouldResizeAvatar)
local FFlagProfilePlatformMeTabMobileProfileHero = SharedFlags.FFlagProfilePlatformMeTabMobileProfileHero
local Presence = require(ProfilePlatform.Rodux.Presence)
local convertPresenceEnum = require(ProfilePlatform.Utils.convertPresenceEnum)
local RoactUtils = require(ProfilePlatformParent.RoactUtils)
local useSelector = RoactUtils.Hooks.RoactRodux.useSelector
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local useEffectOnMount = RoactUtils.Hooks.useEffectOnMount
local NetworkingPresence = require(ProfilePlatform.Networking.NetworkingPresence)
local FFlagSocialEnableProfileInspectAndBuy = require(ProfilePlatformParent.SharedFlags).FFlagSocialEnableProfileInspectAndBuy
local FFlagProfileInspectAvatarCWEntry = require(ProfilePlatform.Flags.FFlagProfileInspectAvatarCWEntry)

local FFlagSocialEnableProfileInspectAndBuyAnalytics = require(ProfilePlatformParent.SharedFlags).FFlagSocialEnableProfileInspectAndBuyAnalytics
local FFlagEnableSocialTabsPage = require(ProfilePlatformParent.SharedFlags).FFlagEnableSocialTabsPage

local FFlagProfilePlatformPresenceStoreMigration = require(ProfilePlatform.Flags.FFlagProfilePlatformPresenceStoreMigration)
local useGetPresenceByUserId = if FFlagProfilePlatformPresenceStoreMigration then require(ProfilePlatformParent.FriendsCommon).Hooks.useGetPresenceByUserId else nil
local var1 = if FFlagProfilePlatformPresenceStoreMigration then require(ProfilePlatformParent.DataHydration).Presence.PresenceStore.get() else nil
local useNavigation = require(ProfilePlatformParent.Navigation).useNavigation
local useLocalUserId = require(ProfilePlatformParent.RobloxAppHooks).useLocalUserId
local useProfileAnalyticsContext = require(ProfilePlatform.Contexts.useProfileAnalyticsContext)
local EventNames = require(ProfilePlatform.Analytics.EventNames)

local tbl1 = { skipFetch = true }

local function UserProfileHeader(arg1)
    local userThumbnail = arg1.userThumbnail
    local var2 = nil
    local var3 = nil
    local meTabMobile = nil
    local bool2 = false
    local var4 = nil
    local var5 = if FFlagSocialEnableProfileInspectAndBuy then useLocalUserId() else nil
    local bool3 = if FFlagSocialEnableProfileInspectAndBuy then tostring(arg1.userId) == tostring(var5) else nil
    local var6 = if FFlagSocialEnableProfileInspectAndBuy then useNavigation() else nil
    local var7 = if FFlagSocialEnableProfileInspectAndBuy then React.useRef(nil) else nil
    local ref = if FFlagSocialEnableProfileInspectAndBuy then React.useRef(nil) else nil
    local var9 = if FFlagSocialEnableProfileInspectAndBuyAnalytics then useProfileAnalyticsContext() else nil
    local profileSessionId = if FFlagSocialEnableProfileInspectAndBuyAnalytics then useProfileWrapperContext().profileSessionId else nil

    local var10 = if FFlagSocialEnableProfileInspectAndBuy then React.useCallback(function()
        if FFlagSocialEnableProfileInspectAndBuyAnalytics then
            var9.fireAnalyticsEvent(EventNames.InspectAvatarOpened, { profileSessionId = profileSessionId })
        end

        if ref.current then
            ref.current.onDismiss()
        end
        var6.navigate(Enums.Screens.InspectAvatarSheet)
    end, {
        var9,
        profileSessionId,
        var6,
        ref
    }) else nil

    if FFlagProfilePlatformNewProfileHeader then
        local var11 = useProfileFormFactor()
        var2 = var11.formFactor == Enums.ProfileFormFactor.PeekView

        local bool4 = var11.formFactor == Enums.ProfileFormFactor.Wide
        local var12 = if FFlagSwitchProfileWidthHookToSocialCommon then useProfileCardWidth2() else useProfileCardWidth(bool4)
        local profileId = useProfileWrapperContext().profileId

        if FFlagProfilePlatformPresenceStoreMigration then
            useEffectOnMount(function()
                var1.RefreshPresenceByUserId(tostring(profileId))
            end)
            local var13 = useGetPresenceByUserId(profileId, tbl1)
            local var14 = convertPresenceEnum
            local var15 = if var13 then var13.userPresenceType else Presence.Enums.PresenceType.Offline
            local var16 = if var13 and var13.universeId ~= "" then tonumber(var13.universeId) else nil
            var4 = var14(var15, var16)
        else
            local var13 = useDispatch()

            useEffectOnMount(function()
                var13(NetworkingPresence.GetPresencesFromUserIds.API({ profileId })):catch(function(_) end)
            end)

            local var14 = useSelector(function(arg2)
                return Presence.Selectors.getUserPresenceByUserId(arg2, profileId)
                    or {
                        userPresenceType = Presence.Enums.PresenceType.Offline,
                        lastLocation = ""
                    }
            end)

            var4 = convertPresenceEnum(var14.userPresenceType, var14.universeId)
        end

        bool2 = useShouldShowContextualInformation(var4)
        local var13 = if FFlagProfilePlatformMeTabMobileProfileHero then useShouldResizeAvatar() else false

        if FFlagProfilePlatformMeTabMobileProfileHero and var13 then
            var3 = var12 * (Constants.ME_TAB_MOBILE_AVATAR_HEIGHT_ASPECT + Constants.ME_TAB_MOBILE_TOP_BACKGROUND_INSET_RATIO)
        else
            var3 = var12 * 0.75
        end

        if FFlagProfilePlatformMeTabMobileProfileHero and var13 then
            meTabMobile = Enums.ProfileAvatarLayoutVariant.MeTabMobile
        else
            meTabMobile = nil
        end
    end

    if not FFlagProfilePlatformNewProfileHeader then
        local createElement = React.createElement
        local str1 = "Frame"
        local tbl2 = {
            Size = UDim2.new(1, 0, 0, Constants.USER_PROFILE_HEADER_HEIGHT),
            BackgroundTransparency = 1,
            LayoutOrder = arg1.layoutOrder
        }
        local tbl3 = { UserProfileAvatar = 0, ProfileTextFrame = 0 }
        local element

        if FFlagSocialEnableProfileInspectAndBuy and not bool3 then
            element = React.createElement(
                "TextButton",
                {
                    Size = UDim2.fromScale(1, 1),
                    BackgroundTransparency = 1,
                    Text = "",
                    [React.Event.Activated] = var10
                },
                {
                    Avatar = React.createElement(UserProfileAvatar, { userThumbnail = userThumbnail, userId = arg1.userId }),
                    TooltipAnchor = if FFlagProfileInspectAvatarCWEntry then nil else React.createElement(
                        View,
                        {
                            tag = "position-center-center anchor-center-center size-50",
                            BackgroundTransparency = 1,
                            ref = var7
                        }
                    ),
                    Tooltip = if FFlagProfileInspectAvatarCWEntry then nil else React.createElement(InspectAvatarTooltip, { anchorRef = var7, ref = ref })
                }
            )
        else
            element = React.createElement(UserProfileAvatar, { userThumbnail = userThumbnail, userId = arg1.userId })
        end

        tbl3.UserProfileAvatar = element

        local createElement2 = React.createElement
        local str2 = "Frame"
        local tbl4 = {
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            Position = UDim2.new(0, 0, 1, 0),
            AnchorPoint = Vector2.new(0, 1),
            BackgroundTransparency = 1,
            ZIndex = 10
        }

        local tbl5 = {
            UIListLayoutOrder = React.createElement(
                "UIListLayout",
                {
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    FillDirection = Enum.FillDirection.Vertical,
                    Padding = UDim.new(0, 8)
                }
            ),
            SocialIdentity = React.createElement(SocialIdentityContainer, {
                size = UDim2.fromScale(1, 0),
                layoutOrder = 1,
                primaryName = arg1.primaryName,
                username = arg1.username,
                isPremium = arg1.isPremium,
                isVerified = arg1.isVerified,
                isRobloxAdmin = arg1.isRobloxAdmin,
                isEdited = arg1.isEdited,
                openEditName = arg1.openEditName,
                platformName = if FFlagAddPlatformNameToProfileHeader then arg1.platformName else nil
            }),
            UserProfileSettingsToggle = if FFlagMoveInExperienceModeToEditProfile or bool1 or not arg1.shouldDisplayUserProfileSettings then nil else React.createElement(
                UserProfileSettingsToggle,
                {
                    size = UDim2.new(1, 0, 0, 30),
                    layoutOrder = 2,
                    isInExperienceNameEnabled = arg1.isInExperienceNameEnabled
                }
            ),
            ContextualInformation = React.createElement(
                ContextualInformation,
                {
                    size = UDim2.fromScale(1, 0),
                    layoutOrder = if FFlagMoveInExperienceModeToEditProfile then 2 else 3
                }
            ),
            SocialCountsRow = if arg1.shouldDisplayCounts then React.createElement(SocialChipCountsRowContainer, {
                size = UDim2.fromScale(1, 0),
                layoutOrder = if FFlagMoveInExperienceModeToEditProfile then 3 else 4,
                title = if FFlagEnableSocialTabsPage then `@{arg1.username}` else nil
            }) else nil
        }
        tbl3.ProfileTextFrame = createElement2(str2, tbl4, tbl5)
        return createElement(str1, tbl2, tbl3)
    end

    local createElement = React.createElement
    local var11 = View
    local tbl2 = {
        tag = "col gap-large size-full-0 auto-y",
        BackgroundTransparency = 1,
        LayoutOrder = arg1.layoutOrder
    }
    local tbl3 = {
        UserProfileAvatar = 0,
        AvatarHeadshotContainer = 0,
        ContextualInformation = 0,
        SocialCountsRow = 0
    }
    local element

    if FFlagSocialEnableProfileInspectAndBuy and not bool3 then
        element = React.createElement("TextButton", {
            Size = UDim2.new(1, 0, 0, var3 or 0),
            BackgroundTransparency = 1,
            Text = "",
            LayoutOrder = 1,
            [React.Event.Activated] = var10
        }, {
            Avatar = React.createElement(UserProfileAvatar, {
                userThumbnail = userThumbnail,
                userId = arg1.userId,
                isPeekView = var2,
                height = var3,
                layoutVariant = meTabMobile,
                layoutOrder = 1
            }),
            TooltipAnchor = if FFlagProfileInspectAvatarCWEntry then nil else React.createElement(
                View,
                {
                    tag = "position-center-center anchor-center-center size-50",
                    BackgroundTransparency = 1,
                    ref = var7
                }
            ),
            Tooltip = if FFlagProfileInspectAvatarCWEntry then nil else React.createElement(InspectAvatarTooltip, { anchorRef = var7, ref = ref })
        })
    else
        element = React.createElement(UserProfileAvatar, {
            userThumbnail = userThumbnail,
            userId = arg1.userId,
            isPeekView = var2,
            height = var3,
            layoutVariant = meTabMobile,
            layoutOrder = 1
        })
    end

    tbl3.UserProfileAvatar = element

    local createElement2 = React.createElement
    local var12 = View
    local tbl4 = {
        tag = { ["size-full-0 auto-y"] = true },
        BackgroundTransparency = 1,
        LayoutOrder = 2
    }

    local tbl5 = {
        AvatarHeadshotComponent = React.createElement(AvatarHeadshotComponent, {
            layoutOrder = 1,
            userId = tostring(arg1.userId),
            primaryName = arg1.primaryName,
            username = arg1.username,
            userPresenceType = var4,
            isPremium = arg1.isPremium,
            isVerified = arg1.isVerified,
            isRobloxAdmin = arg1.isRobloxAdmin,
            platformName = if FFlagAddPlatformNameToProfileHeader then arg1.platformName else nil
        })
    }
    tbl3.AvatarHeadshotContainer = createElement2(var12, tbl4, tbl5)

    tbl3.ContextualInformation = if bool2 then React.createElement(ContextualInformation, { size = UDim2.fromScale(1, 0), layoutOrder = 3 }) else nil
    local element2 = if arg1.shouldDisplayCounts then React.createElement(SocialChipCountsRowContainer, {
        size = UDim2.fromScale(1, 0),
        layoutOrder = 4,
        title = if FFlagEnableSocialTabsPage then `@{arg1.username}` else nil
    }) else nil
    tbl3.SocialCountsRow = element2
    return createElement(var11, tbl2, tbl3)
end

return UserProfileHeader
