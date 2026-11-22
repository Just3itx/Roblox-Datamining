-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T18:01:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialCarousel = script:FindFirstAncestor("SocialCarousel")
local SocialCarouselParent = SocialCarousel.Parent
local Cryo = require(SocialCarouselParent.Cryo)
local React = require(SocialCarouselParent.React)
local RoactUtils = require(SocialCarouselParent.RoactUtils)
local NavigationRodux = require(SocialCarouselParent.NavigationRodux)
local RobloxAppEnums = require(SocialCarouselParent.RobloxAppEnums)
local Navigation = require(SocialCarouselParent.Navigation)

local AppPage = RobloxAppEnums.AppPage
local NavigateDown = NavigationRodux.Thunks.NavigateDown
local NavigateBack = NavigationRodux.Thunks.NavigateBack
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local useNavigation = Navigation.useNavigation
local ShareQRTile = require(script.Parent.ShareQRTile)
local useSocialCarouselAnalytics = require(SocialCarousel.Analytics.useSocialCarouselAnalytics)
local useSocialCarouselContext = require(SocialCarousel.Contexts.useSocialCarouselContext)
local Constants = require(SocialCarousel.Common.Constants)

local FFlagSocialCarouselShareQRBackToAddFriends = require(SocialCarouselParent.SharedFlags).FFlagSocialCarouselShareQRBackToAddFriends
local FFlagCreateConnectionsHub = require(SocialCarouselParent.SharedFlags).FFlagCreateConnectionsHub
local FFlagSignalsNavP3Dispatch = require(SocialCarouselParent.SharedFlags).FFlagSignalsNavP3Dispatch
local NavigationCommands = if FFlagSignalsNavP3Dispatch then require(SocialCarouselParent.RobloxAppNavigation).NavigationCommands else nil

local function ShareQRTileContainer(tbl1)
    local var1 = useNavigation()
    local var2 = useDispatch()
    local var3 = useSocialCarouselAnalytics()
    local var4 = useSocialCarouselContext()

    local onActivated = React.useCallback(function()
        var3.shareQRPressed(tbl1.index)

        local onClose = FFlagSocialCarouselShareQRBackToAddFriends and function()
            if FFlagSignalsNavP3Dispatch then
                NavigationCommands.back(true)
            else
                var2(NavigateBack(true))
            end
            if FFlagCreateConnectionsHub then
                var1.navigate(AppPage.CoHubAddConnections)
            elseif FFlagSignalsNavP3Dispatch then
                NavigationCommands.down(NavigationCommands.fromLegacyPage({ name = AppPage.AddFriendsPage }))
            else
                var2(NavigateDown({ name = AppPage.AddFriendsPage }))
            end
        end or nil

        if var4.navigateToQRCodePage then
            var4.navigateToQRCodePage({ source = Constants.ANALYTICS.SRC.HOMEPAGE_FRIENDS_CAROUSEL, onClose = onClose })
        end
    end, {
        var2,
        var1,
        tbl1.index,
        var3.shareQRPressed,
        var4.navigateToQRCodePage
    })

    React.useEffect(function()
        var4.onSuccessfulRender(Constants.ANALYTICS.UI_LOADING_EVENTS.SHARE_QR)
    end, {})

    return React.createElement(ShareQRTile, Cryo.Dictionary.join(tbl1, { onActivated = onActivated }))
end

return ShareQRTileContainer
