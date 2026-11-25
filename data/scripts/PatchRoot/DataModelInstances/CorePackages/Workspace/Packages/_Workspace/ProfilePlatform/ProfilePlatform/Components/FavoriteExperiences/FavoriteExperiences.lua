-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:01:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent
local React = require(ProfilePlatformParent.React)
local Cryo = require(ProfilePlatformParent.Cryo)

local useLocalization = require(ProfilePlatformParent.Localization).Hooks.useLocalization

local RoactUtils = require(ProfilePlatformParent.RoactUtils)
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local useSelector = RoactUtils.Hooks.RoactRodux.useSelector

local AppPage = require(ProfilePlatformParent.RobloxAppEnums).AppPage
local NavigateDown = require(ProfilePlatformParent.NavigationRodux).Thunks.NavigateDown
local Url = require(ProfilePlatformParent.Http).Url

local NetworkingGames = require(ProfilePlatform.Networking.NetworkingGames)

local getDeepValue = require(ProfilePlatformParent.LuaSocialLibrariesDeps).SocialLibraries.config({}).Dictionary.getDeepValue

local SquareCollectionGridView = require(ProfilePlatform.BaseComponents.CollectionGridViews.SquareCollectionGridView)

local useProfileJsonComponent = require(ProfilePlatform.Hooks.useProfileJsonComponent)
local useRenderExperienceTile = require(ProfilePlatform.Hooks.Tiles.useRenderExperienceTile)
local useRenderExperienceTile_DEPRECATED = require(ProfilePlatform.Hooks.Tiles.useRenderExperienceTile_DEPRECATED)
local useProfileWrapperContext = require(ProfilePlatform.Contexts.useProfileWrapperContext)
local useProfileAnalyticsContext = require(ProfilePlatform.Contexts.useProfileAnalyticsContext)
local useSendItemImpressions = require(ProfilePlatform.Hooks.useSendItemImpressions)
local useGenerateImpressionsTag = require(ProfilePlatform.Hooks.useGenerateImpressionsTag)
local formatExperienceDetailsForImpressions = require(ProfilePlatform.Hooks.formatExperienceDetailsForImpressions)

local Enums = require(ProfilePlatform.Common.Enums)
local EventNames = require(ProfilePlatform.Analytics.EventNames)
local TextKeys = require(ProfilePlatform.Common.TextKeys)
local _Types = require(ProfilePlatform.Common.Types)
local ContentType = require(ProfilePlatformParent.UnifiedLogging).ContentType

local RoactAnalyticsCommonGameEvents = require(ProfilePlatformParent.RoactServiceTags).RoactAnalyticsCommonGameEvents
local useRoactService = require(ProfilePlatformParent.RobloxAppHooks).useRoactService

local SharedFlags = require(ProfilePlatformParent.SharedFlags)

local bool1 = game:DefineFastFlag("ProfilePlatformFavoritesNavigateToWeb_V2", false)

local bool2 = game:DefineFastFlag("ProfilePlatformFavoritesEnableProfilePlatformClickAnalytics", false)

local FFlagProfilePlatformFavoritesEnableGameDetailAnalytics = SharedFlags.FFlagProfilePlatformFavoritesEnableGameDetailAnalytics
local FFlagProfilePlatformEnableImpressions = require(ProfilePlatformParent.SharedFlags).FFlagProfilePlatformEnableImpressions

local FFlagProfilePlatformImproveGameDetailsAnalytics = require(ProfilePlatformParent.SharedFlags).FFlagProfilePlatformImproveGameDetailsAnalytics
local FFlagSignalsNavP3Dispatch = SharedFlags.FFlagSignalsNavP3Dispatch
local NavigationCommands = if FFlagSignalsNavP3Dispatch then require(ProfilePlatformParent.RobloxAppNavigation).NavigationCommands else nil
local tbl1 = {}

local function getSquareExperienceTileHeight(num1: number): number
    return num1 + 42
end

local function useFavoriteExperiences(_: string)
    local var1 = useDispatch()

    local var2 = useProfileJsonComponent(Enums.Components.FavoriteExperiences).experiences or tbl1

    local var3 = React.useMemo(function()
        return Cryo.List.map(var2, function(arg1, _): string
            return tostring(arg1.universeId)
        end)
    end, { var2 })

    React.useEffect(function()
        if var3 ~= nil and not Cryo.isEmpty(var3) then
            var1(NetworkingGames.GetExperiencesDetails.API(var3)):catch(function(_) end)
        end
    end, { var3 })

    local var4 = useSelector(function(arg1)
        return getDeepValue(arg1, "ProfilePlatform.Games.byGameId") or tbl1
    end)

    local var5 = React.useMemo(function()
        local result = {}
        for _, value in var3 do
            if var4[value] then
                table.insert(result, var4[value])
            end
        end
        return result
    end, { var3, var4 })

    return if var2 and #var5 == #var3 then var5 else tbl1
end

local function FavoriteExperiences(tbl2)
    local var1 = useDispatch()
    local var2 = useProfileWrapperContext()
    local var3 = if bool2 then useProfileAnalyticsContext() else nil
    local var4 = if FFlagProfilePlatformEnableImpressions then useGenerateImpressionsTag(Enums.Components.FavoriteExperiences) else nil
    local profileId = var2.profileId

    local var5 = useLocalization({ title = TextKeys.Favorites })

    local onActivateHeader = React.useCallback(function()
        if bool2 and var3 then
            var3.fireAnalyticsEvent(EventNames.FavoriteExperienceSeeAll)
        end

        if not bool1 then
            return
        end

        local tbl3 = {
            name = AppPage.GenericWebPage,
            detail = string.format("%susers/%s/favorites#!/places", Url.BASE_URL, profileId),
            extraProps = {
                titleKey = TextKeys.Favorites
            }
        }
        if FFlagSignalsNavP3Dispatch then
            NavigationCommands.down(NavigationCommands.fromLegacyPage(tbl3))
            return
        end
        var1(NavigateDown(tbl3, nil))
    end, bool2 and { profileId, var3 } or nil)

    local hideHeaderButton = not bool1
    local getItemHeight = getSquareExperienceTileHeight
    local items = useFavoriteExperiences(profileId)
    local var8 = if FFlagProfilePlatformFavoritesEnableGameDetailAnalytics then useRoactService(RoactAnalyticsCommonGameEvents) else nil

    local var9 = React.useCallback(function(arg1, positionInComponent: number, num1: number?)
        if bool2 then
            var3.fireAnalyticsEvent(
                EventNames.FavoriteExperienceOpened,
                {
                    experienceId = arg1.experienceId,
                    positionInComponent = positionInComponent
                }
            )
        end

        if FFlagProfilePlatformFavoritesEnableGameDetailAnalytics then
            local num2 = items and #items or 0

            var8.reportOpenGameDetailFromProfile(
                arg1.rootPlaceId,
                positionInComponent,
                num2,
                arg1.experienceId,
                AppPage.ProfilePlatform,
                tbl2.layoutOrder,
                num1 or 1,
                if FFlagProfilePlatformImproveGameDetailsAnalytics then profileId else nil
            )
        end
    end, FFlagProfilePlatformFavoritesEnableGameDetailAnalytics and {
        var3,
        items,
        var8,
        tbl2.layoutOrder
    } or { var3 })

    local renderItem = if FFlagProfilePlatformEnableImpressions then useRenderExperienceTile(var4, "ProfileFavoriteExperienceTile", var9) else useRenderExperienceTile_DEPRECATED("ProfileFavoriteExperienceTile", var9)

    local var11 = if FFlagProfilePlatformEnableImpressions then React.useMemo(function()
        return formatExperienceDetailsForImpressions(items)
    end, { items }) else nil

    local var12 = if FFlagProfilePlatformEnableImpressions then useSendItemImpressions(var11, 3, ContentType.Game, tbl2.layoutOrder, Enums.Components.FavoriteExperiences) else nil

    if Cryo.isEmpty(items) then
        return nil
    end

    local createElement = React.createElement
    local var13 = SquareCollectionGridView
    local tbl3 = {
        getItemHeight = getItemHeight,
        hideHeaderButton = hideHeaderButton,
        items = items,
        layoutOrder = tbl2.layoutOrder,
        onActivateHeader = onActivateHeader,
        renderItem = renderItem,
        title = var5.title,
        impressionsTag = 0,
        sendImpressions = 0,
        overrides = 0
    }

    if not FFlagProfilePlatformEnableImpressions then
        var4 = nil
    end

    tbl3.impressionsTag = var4
    if not FFlagProfilePlatformEnableImpressions then
        var12 = nil
    end

    tbl3.sendImpressions = var12
    tbl3.overrides = { numColumns = 3 }
    return (createElement(var13, tbl3))
end

return FavoriteExperiences
