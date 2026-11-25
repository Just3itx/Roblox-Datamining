-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:30:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent
local React = require(ProfilePlatformParent.React)
local UserLib = require(ProfilePlatformParent.UserLib)
local Navigation = require(ProfilePlatformParent.Navigation)
local RoactUtils = require(ProfilePlatformParent.RoactUtils)
local SetAlias = require(ProfilePlatformParent.SetAlias)

local NetworkingUsers = require(ProfilePlatform.Networking.NetworkingUsers)
local useEffectOnce = RoactUtils.Hooks.useEffectOnce
local Constants = UserLib.Utils.Constants
local getRbxthumbWithTypeSizeAndOptions = UserLib.Utils.getRbxthumbWithTypeSizeAndOptions
local useNavigation = Navigation.useNavigation

local _ProfileWrapperContext = require(ProfilePlatform.Contexts.ProfileWrapperContext)
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch

local SocialStopwatch = require(ProfilePlatformParent.SocialStopwatch)

local Constants2 = require(ProfilePlatform.Common.Constants)
local Enums = require(ProfilePlatform.Common.Enums)

local useProfileAnalyticsContext = require(ProfilePlatform.Contexts.useProfileAnalyticsContext)
local EventNames = require(ProfilePlatform.Analytics.EventNames)
local useProfileJsonComponent = require(ProfilePlatform.Hooks.useProfileJsonComponent)
local useProfileWrapperContext = require(ProfilePlatform.Contexts.useProfileWrapperContext)
local UserProfileHeader = require(ProfilePlatform.Components.UserProfileHeader.UserProfileHeader)
local FFlagMoveInExperienceModeToEditProfile = require(ProfilePlatformParent.SharedFlags).FFlagMoveInExperienceModeToEditProfile

local Enums2 = require(ProfilePlatformParent.EditProfile.Enums)
local FFlagAddPlatformNameToProfileHeader = require(ProfilePlatformParent.SharedFlags).FFlagAddPlatformNameToProfileHeader

local UserProfiles = require(ProfilePlatformParent.UserProfiles)
local useUserProfilesFetch = UserProfiles.Hooks.useUserProfilesFetch

local function _(tbl1, arg1, bool1: boolean?) -- Luacid: unused: defined but never referenced
    local primaryName = tbl1.names.primaryName or ""

    if arg1.profileUserNickname and bool1 and arg1.profileUserNickname ~= "" then
        return arg1.profileUserNickname .. " (" .. primaryName .. ")"
    end

    return primaryName
end

local function UserProfileHeaderContainer(tbl1)
    local var1 = useProfileWrapperContext()
    local var2 = useNavigation()
    local var3 = useDispatch()
    local var4 = React.useRef(false)
    local var5 = useProfileAnalyticsContext()

    local profileId = var1.profileId

    local userThumbnail = getRbxthumbWithTypeSizeAndOptions(profileId, Constants.RbxthumbTypes.Avatar, Constants2.AVATAR_THUMBNAIL_SIZE)

    local var6 = useProfileJsonComponent(Enums.Components.UserProfileHeader)

    local var7 = nil
    if FFlagAddPlatformNameToProfileHeader then
        local var8 = useUserProfilesFetch(
            {
                userIds = { profileId },
                query = UserProfiles.Queries.userProfilesDisplayUserPlatformNamesByUserIds
            }
        )

        if var8.data then
            local platformNameFromId = UserProfiles.Selectors.getPlatformNameFromId(var8.data, profileId)
            if platformNameFromId and platformNameFromId ~= "" then
                var7 = platformNameFromId
            end
        end
    end

    local var8 = React.useCallback(function()
        if not var6.editName then
            return
        end

        if var6.editName.field ~= Enums.NameTypes.DisplayName then
            SocialStopwatch.Stopwatch.start(SocialStopwatch.Events.CustomizeNameOpened)
            var5.fireAnalyticsEvent(EventNames.SetAliasButton)
            var2.navigate(
                Enums.Screens.SetAliasModal,
                {
                    profileUserId = profileId,
                    origin = SetAlias.Analytics.EntryPoints.ProfileCardName
                }
            )
            return
        end

        var5.fireAnalyticsEvent(EventNames.EditDisplayNameButton, { canSetDisplayName = var4.current })

        if not var4.current then
            var2.navigate(Enums.Screens.EditDisplayNameErrorModal)
            return
        end

        var2.navigate(
            Enums2.Screens.EditProfileSubScreen,
            {
                screen = Enums2.Screens.EditDisplayName,
                initialDisplayName = var6.names.primaryName
            }
        )
    end, { var2, var6.editName, var6.names })

    useEffectOnce(function()
        local function func1() -- Luacid: Inlined by compiler; 1 call site recovered
            return var3(NetworkingUsers.GetDisplayNameValidation.API(profileId, "testName"))
        end

        func1():andThen(function()
            var4.current = true
        end):catch(function()
            var4.current = false
        end)
    end, var6.editName and var6.editName.field == Enums.NameTypes.DisplayName)

    local shouldDisplayCounts = var6.counts ~= nil

    local isInExperienceNameEnabled = nil
    local bool2

    if FFlagMoveInExperienceModeToEditProfile then
        bool2 = nil
    else
        bool2 = var6.userProfileSettings ~= nil
        if bool2 then
            isInExperienceNameEnabled = var6.userProfileSettings.isInExperienceNameEnabled
        end
    end

    local createElement = React.createElement
    local var9 = UserProfileHeader
    local tbl2 = {
        userThumbnail = userThumbnail,
        layoutOrder = tbl1.layoutOrder,
        userId = tonumber(profileId),
        openEditName = 0,
        primaryName = 0,
        username = 0,
        isPremium = 0,
        isVerified = 0,
        isRobloxAdmin = 0,
        isEdited = 0,
        shouldDisplayUserProfileSettings = 0,
        isInExperienceNameEnabled = 0,
        shouldDisplayCounts = 0,
        platformName = 0
    }

    if not var6.editName then
        var8 = nil
    end

    tbl2.openEditName = var8
    local primaryName = var6.names.primaryName or ""

    local _profileUserNickname = var1.profileUserNickname

    tbl2.primaryName = primaryName
    tbl2.username = var6.names.username
    tbl2.isPremium = var6.isPremium
    tbl2.isVerified = var6.isVerified
    tbl2.isRobloxAdmin = var6.isRobloxAdmin
    tbl2.isEdited = var6.editName and var6.editName.isEdited
    if FFlagMoveInExperienceModeToEditProfile then
        bool2 = nil
    end

    tbl2.shouldDisplayUserProfileSettings = bool2

    if FFlagMoveInExperienceModeToEditProfile then
        isInExperienceNameEnabled = nil
    end

    tbl2.isInExperienceNameEnabled = isInExperienceNameEnabled
    tbl2.shouldDisplayCounts = shouldDisplayCounts
    if not FFlagAddPlatformNameToProfileHeader then
        var7 = nil
    end

    tbl2.platformName = var7
    return createElement(var9, tbl2)
end

return UserProfileHeaderContainer
