-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T18:00:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialCarousel = script:FindFirstAncestor("SocialCarousel")
local SocialCarouselParent = SocialCarousel.Parent
local React = require(SocialCarouselParent.React)
local RobloxAppEnums = require(SocialCarouselParent.RobloxAppEnums)
local RoactUtils = require(SocialCarouselParent.RoactUtils)

local Carousel = require(script.Parent.Carousel)
local NavigateDown = require(SocialCarouselParent.NavigationRodux).Thunks.NavigateDown
local Navigation = require(SocialCarouselParent.Navigation)

local useSocialCarouselAnalytics = require(SocialCarousel.Analytics.useSocialCarouselAnalytics)
local useTilesSeenCollection = require(SocialCarousel.Analytics.useTilesSeenCollection)
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local AppPage = RobloxAppEnums.AppPage
local useNavigation = Navigation.useNavigation
local FFlagCreateConnectionsHub = require(SocialCarouselParent.SharedFlags).FFlagCreateConnectionsHub
local FFlagSignalsNavP3Dispatch = require(SocialCarouselParent.SharedFlags).FFlagSignalsNavP3Dispatch
local FFlagShowRequestsInCarouselForAllUsers = require(SocialCarouselParent.SharedFlags).FFlagShowRequestsInCarouselForAllUsers
local NavigationCommands = if FFlagSignalsNavP3Dispatch then require(SocialCarouselParent.RobloxAppNavigation).NavigationCommands else nil

local function CarouselContainer(tbl1)
    local var1 = useSocialCarouselAnalytics()
    local var2 = useTilesSeenCollection()
    local var3 = useDispatch()
    local var4 = useNavigation()
    local var5 = React.useRef({ startIndex = 1, endIndex = 1 })

    local onActivateHeader = React.useCallback(function()
        var1.friendsHeaderPressed()
        if FFlagCreateConnectionsHub then
            var4.navigate(AppPage.CoHubMyConnections)
        elseif FFlagSignalsNavP3Dispatch then
            NavigationCommands.down(NavigationCommands.fromLegacyPage({ name = AppPage.ViewFriends }))
        else
            var3(NavigateDown({ name = AppPage.ViewFriends }))
        end
    end, { var3, var4 })

    local var7 = React.useCallback(function(str1: string, num1: number, arg1)
        local current = var5.current
        if current.startIndex <= num1 and num1 <= current.endIndex then
            var2.addTileToCollection(str1, num1, arg1)
        end
    end, { var2 })

    local createElement = React.createElement
    local var8 = Carousel
    local tbl2 = {
        onActivateHeader = onActivateHeader,
        onTileContentChanged = 0,
        appCompositionEnabled = 0
    }

    if FFlagShowRequestsInCarouselForAllUsers then
        var7 = nil
    end

    tbl2.onTileContentChanged = var7
    tbl2.appCompositionEnabled = tbl1.appCompositionEnabled
    return createElement(var8, tbl2)
end

return CarouselContainer
