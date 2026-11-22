-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T18:01:06Z
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
local SocialStopwatch = require(SocialCarouselParent.SocialStopwatch)

local AppPage = RobloxAppEnums.AppPage
local NavigateDown = NavigationRodux.Thunks.NavigateDown
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local useNavigation = Navigation.useNavigation
local AddFriendsTile = require(script.Parent.AddFriendsTile)
local useSocialCarouselAnalytics = require(SocialCarousel.Analytics.useSocialCarouselAnalytics)
local useSocialCarouselContext = require(SocialCarousel.Contexts.useSocialCarouselContext)
local Constants = require(SocialCarousel.Common.Constants)
local useNewFriendRequestsCount = require(SocialCarousel.Hooks.useNewFriendRequestsCount)

local FFlagCreateConnectionsHub = require(SocialCarouselParent.SharedFlags).FFlagCreateConnectionsHub
local FFlagSignalsNavP3Dispatch = require(SocialCarouselParent.SharedFlags).FFlagSignalsNavP3Dispatch
local NavigationCommands = if FFlagSignalsNavP3Dispatch then require(SocialCarouselParent.RobloxAppNavigation).NavigationCommands else nil

local function AddFriendsTileContainer(tbl1)
    local var1 = useNavigation()
    local var2 = useDispatch()
    local var3 = useSocialCarouselAnalytics()
    local var4 = useSocialCarouselContext()
    local badge = useNewFriendRequestsCount()
    local onActivated = React.useCallback(function()
        var3.addFriendsPressed(tbl1.index)
        SocialStopwatch.Stopwatch.start(SocialStopwatch.Events.AFPUserTileLoadFromHomeCarousel)
        if FFlagCreateConnectionsHub then
            var1.navigate(AppPage.CoHubAddConnections)
        elseif FFlagSignalsNavP3Dispatch then
            NavigationCommands.down(NavigationCommands.fromLegacyPage({ name = AppPage.AddFriendsPage }))
        else
            var2(NavigateDown({ name = AppPage.AddFriendsPage }))
        end
    end, { var2, var1 })

    React.useEffect(function()
        var4.onSuccessfulRender(Constants.ANALYTICS.UI_LOADING_EVENTS.ADD_FRIENDS)
    end, {})

    return React.createElement(AddFriendsTile, Cryo.Dictionary.join(tbl1, { onActivated = onActivated, badge = badge }))
end

return AddFriendsTileContainer
