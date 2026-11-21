-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T15:41:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsLanding = script:FindFirstAncestor("FriendsLanding")
local FriendsLandingParent = FriendsLanding.Parent
local dependencies = require(FriendsLanding.dependencies)

local Roact = dependencies.Roact
local Logger = dependencies.Logger
local RoactRodux = dependencies.RoactRodux
local RoactAppExperiment = dependencies.RoactAppExperiment
local FriendsLandingContext = require(FriendsLanding.FriendsLandingContext)
local FriendsLandingAnalytics = require(FriendsLanding.FriendsLandingAnalytics)
local Navigator = require(FriendsLanding.Navigator)

local EnumScreens = require(FriendsLanding.EnumScreens)
local filterStates = require(FriendsLanding.Friends.filterStates)
local memoize = dependencies.memoize
local SocialLibraries = dependencies.SocialLibraries
local BottomInsetBackground = dependencies.SocialCommon.Components.BottomInsetBackground
local compose = SocialLibraries.RoduxTools.compose
local mapStateToProps = require(script.mapStateToProps)
local mapDispatchToProps = require(script.mapDispatchToProps)
local getInitialFilter = require(script.getInitialFilter)
local withLocalization = dependencies.withLocalization

local getFStringSocialAddFriendsPageLayer = dependencies.getFStringSocialAddFriendsPageLayer

local FFlagFriendsPageAlwaysOpenPPV = require(FriendsLandingParent.SharedFlags).FFlagFriendsPageAlwaysOpenPPV
local FFlagFriendsDeepLinkInitialFilter = require(FriendsLandingParent.SharedFlags).FFlagFriendsDeepLinkInitialFilter

local function func1() end

local var1 = Roact.PureComponent:extend("FriendsLandingEntryPoint")

var1.defaultProps = {
    renderAndroidBackButtonNavigationHandler = nil,
    luaAppPages = {},
    isLuobu = false,
    logger = nil,
    debug_willUnmount = nil
}

function var1.init(arg1)
    if arg1.props.logger then
        Logger:setParent(arg1.props.logger)
    end

    arg1.state = {
        filter = filterStates.All,
        topBar = {
            [EnumScreens.FriendsLanding] = { shouldRenderCenter = false }
        }
    }

    if FFlagFriendsDeepLinkInitialFilter then
        arg1.state.filter = getInitialFilter(arg1.props.initialFilter)
    end

    arg1.localization = { pageError = "CommonUI.Messages.Response.PageError" }

    function arg1.setFilterKeys(filter: string)
        assert(type(filter) == "string", "Expected value to be a string")
        arg1:setState({ filter = filter })
    end

    function arg1.showErrorToast(toastTitle: string)
        arg1.props.navigation.navigate(
            EnumScreens.GenericToast,
            {
                toastProps = {
                    toastContent = { toastTitle = toastTitle }
                }
            }
        )
    end

    function arg1.refreshPage(arg2)
        return arg1.props.refreshPageData({
            localUserId = arg1.props.localUserId,
            inactiveFriendsNetworkRequestStatus = arg1.props.inactiveFriendsNetworkRequestStatus,
            onError = function()
                arg1.showErrorToast(arg2.errorMessage)
                Logger:info("Refreshing FriendsLanding data failed")
            end,
            onResolve = arg2.onResolve or func1
        })
    end

    arg1.getAnalytics = memoize(function(arg2)
        return FriendsLandingAnalytics.Class.new(
            {
                Diag = arg1.props.diagService,
                EventStream = arg1.props.eventIngestService
            },
            arg2,
            arg1.props.getLoadingTimeInfo
        )
    end)
end

function var1.render(arg1)
    return withLocalization(arg1.localization)(function(_)
        return Roact.createElement(
            FriendsLandingAnalytics.Context.Provider,
            {
                value = arg1.getAnalytics(arg1.props.localUserId)
            },
            {
                Roact.createElement(FriendsLandingContext.Provider, {
                    value = {
                        navigateToLuaAppPages = arg1.props.navigateToLuaAppPages,
                        filter = arg1.state.filter,
                        setFilterKeys = arg1.setFilterKeys,
                        screenSize = arg1.props.screenSize,
                        friendRequestCount = arg1.props.friendRequestCount,
                        totalFriendCount = arg1.props.totalFriendCount,
                        wideMode = arg1.props.wideMode,
                        playerSearchPage = arg1.props.luaAppPages.playerSearchPage,
                        diagService = arg1.props.diagService,
                        eventIngestService = arg1.props.eventIngestService,
                        isLuobu = arg1.props.isLuobu,
                        refreshPage = arg1.refreshPage,
                        friendsRequestEventListener = arg1.props.friendsRequestEventListener,
                        robloxEventReceiver = arg1.props.robloxEventReceiver,
                        addFriendsPageSearchbarEnabled = arg1.props.addFriendsPageSearchbarEnabled,
                        openProfilePeekView = arg1.props.openProfilePeekView,
                        openPlayerContextualMenu = if FFlagFriendsPageAlwaysOpenPPV then nil else arg1.props.openPlayerContextualMenu,
                        openAmpUpsell = arg1.props.openAmpUpsell,
                        passedNavParams = arg1.props.passedNavParams
                    }
                }, {
                    navigation = Roact.createElement(Navigator, { navigation = arg1.props.navigation }),
                    BottomInsetBackground = Roact.createElement(BottomInsetBackground)
                })
            }
        )
    end)
end

function var1.didMount(_)
    Logger:info("FriendsLandingEntryPoint mounted")
end

function var1.willUnmount(arg1)
    Logger:info("FriendsLandingEntryPoint unmounted")
    if arg1.props.debug_willUnmount then
        arg1.props.debug_willUnmount()
    end
end

return (compose(
    RoactRodux.connect(mapStateToProps, mapDispatchToProps),
    RoactAppExperiment.connectUserLayer({ getFStringSocialAddFriendsPageLayer() }, function(arg1, _)
        return {
            addFriendsPageSearchbarEnabled = (arg1[getFStringSocialAddFriendsPageLayer()] or {}).show_add_friends_page_search_bar
        }
    end, false)
)(
    var1
))
