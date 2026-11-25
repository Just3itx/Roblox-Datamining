-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:30:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent
local React = require(ProfilePlatformParent.React)

local RoactUtils = require(ProfilePlatformParent.RoactUtils)
local AppPage = require(ProfilePlatformParent.RobloxAppEnums).AppPage
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local useLocalization = require(ProfilePlatformParent.Localization).Hooks.useLocalization
local NavigationRodux = require(ProfilePlatformParent.NavigationRodux)
local NavigateDown = NavigationRodux.Thunks.NavigateDown
local NavigateDownToViewUserProfile = NavigationRodux.Thunks.NavigateDownToViewUserProfile
local UrlBuilder = require(ProfilePlatformParent.UrlBuilder).UrlBuilder
local UrlBase = require(ProfilePlatformParent.UrlBuilder).UrlBase

local Constants = require(ProfilePlatform.Common.Constants)
local UIBlox = require(ProfilePlatformParent.UIBlox)
local HorizontalPageMargin = UIBlox.App.Container.HorizontalPageMargin
local Button = UIBlox.App.Button.Button
local ButtonType = UIBlox.App.Button.Enum.ButtonType
local Enums = require(ProfilePlatform.Common.Enums)

local useProfileJsonComponent = require(ProfilePlatform.Hooks.useProfileJsonComponent)
local useProfileWrapperContext = require(ProfilePlatform.Contexts.useProfileWrapperContext)
local useProfileAnalyticsContext = require(ProfilePlatform.Contexts.useProfileAnalyticsContext)
local EventNames = require(ProfilePlatform.Analytics.EventNames)
local TextKeys = require(ProfilePlatform.Common.TextKeys)
local makeViewGroupPage = require(ProfilePlatform.Utils.makeViewGroupPage)
local SharedFlags = require(ProfilePlatformParent.SharedFlags)
local FFlagEnableGroupOverviewPane = SharedFlags.FFlagEnableGroupOverviewPane
local FFlagSignalsNavP3Dispatch = SharedFlags.FFlagSignalsNavP3Dispatch
local NavigationCommands = if FFlagSignalsNavP3Dispatch then require(ProfilePlatformParent.RobloxAppNavigation).NavigationCommands else nil

function ViewFullProfile(arg1)
    local var1 = useProfileJsonComponent(Enums.Components.ViewFullProfile) or {}
    local var2 = useProfileWrapperContext()
    local profileId = var2.profileId
    local profileType = var2.profileType
    local var3 = useProfileAnalyticsContext()

    local var4 = useDispatch()
    local var5 = useLocalization({ viewFullProfileLabel = TextKeys.ViewFullProfile, viewCommunityLabel = TextKeys.ViewCommunity })

    local useMemo = React.useMemo

    local function func1()
        if profileType == Enums.ProfileTypes.User then
            return var5.viewFullProfileLabel
        end

        if profileType == Enums.ProfileTypes.Community then
            if var1.type == Enums.ViewFullProfileTypes.Profile then
                return var5.viewFullProfileLabel
            end

            if var1.type == Enums.ViewFullProfileTypes.Community then
                return var5.viewCommunityLabel
            end
        end

        return var5.viewFullProfileLabel
    end

    local var6 = if FFlagEnableGroupOverviewPane then profileType else nil
    local type = if FFlagEnableGroupOverviewPane then var1.type else nil
    local text = useMemo(func1, { var5, var6, type })

    local useCallback = React.useCallback

    local function func2()
        var3.fireAnalyticsEvent(EventNames.ViewPlayerProfileButton, {
            absolutePosition = var2.sourceInfo.homepageCarouselAbsolutePosition,
            isHomePageCarousel = var2.sourceInfo.source == Enums.Sources.HomepageFriendsCarousel,
            source = var2.sourceInfo.source,
            isRecommendation = var2.sourceInfo.isRecommendation,
            recommendationContextType = var2.sourceInfo.recommendationContextType,
            recommendationRank = var2.sourceInfo.recommendationRank,
            recommendationSessionId = var2.sourceInfo.recommendationSessionId
        })

        if profileType == Enums.ProfileTypes.User then
            var4(NavigateDownToViewUserProfile(profileId))
            return
        end

        if profileType ~= Enums.ProfileTypes.Community then
            return
        end
        local var8 = var1.type == Enums.ViewFullProfileTypes.Profile
            and {
                name = AppPage.GenericWebPage,
                detail = UrlBuilder.new({ base = UrlBase.WWW, path = `profiles/{profileId}` })(),
                extraProps = {
                    titleKey = TextKeys.Profile
                }
            }
            or makeViewGroupPage(profileId)

        if FFlagSignalsNavP3Dispatch then
            NavigationCommands.down(NavigationCommands.fromLegacyPage(var8))
            return
        end
        var4(NavigateDown(var8))
    end

    local var8 = if FFlagEnableGroupOverviewPane then profileType else nil
    local type2 = if FFlagEnableGroupOverviewPane then var1.type else nil
    local onActivated = useCallback(func2, { var4, profileId, var3, var2, var8, type2 })

    return React.createElement(
        HorizontalPageMargin,
        {
            size = UDim2.fromScale(1, 0),
            backgroundTransparency = 1,
            layoutOrder = arg1.layoutOrder,
            useAutomaticSizing = true
        },
        {
            ViewFullProfileFrame = React.createElement("Frame", {
                Size = UDim2.fromScale(1, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundTransparency = 1,
                LayoutOrder = arg1.layoutOrder
            }, {
                UIPadding = React.createElement("UIPadding", { PaddingTop = UDim.new(0, Constants.ADDITIONAL_PADDING) }),
                ViewFullProfile = React.createElement(Button, {
                    buttonType = ButtonType.Secondary,
                    size = UDim2.new(1, 0, 0, Constants.CTA_BUTTON_HEIGHT),
                    onActivated = onActivated,
                    text = text
                })
            })
        }
    )
end
return ViewFullProfile
