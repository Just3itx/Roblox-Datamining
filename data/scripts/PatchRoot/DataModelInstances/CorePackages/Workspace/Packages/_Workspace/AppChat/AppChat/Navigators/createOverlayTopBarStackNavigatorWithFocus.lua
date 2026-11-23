-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:01:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local FocusNavigableSurfaceIdentifierEnum = require(AppChatParent.FocusNavigationUtils).FocusNavigableSurfaceIdentifierEnum
local React = require(AppChatParent.React)
local RoactNavigation = require(AppChatParent.RoactNavigation)
local Foundation = require(AppChatParent.Foundation)
local Responsive = require(AppChatParent.Responsive)

local EnumScreens = require(AppChat.EnumScreens)
local SystemMenuTopBar = require(AppChat.Components.TopBar.SystemMenuTopBar)
local configureTopBarWithNavigationOptions = require(AppChat.configureTopBarWithNavigationOptions)
local isolatedAutoFocusNavigation = require(AppChat.Navigators.isolatedAutoFocusNavigation)
local FFlagAppChatPerfTracking = require(AppChat.Flags.FFlagAppChatPerfTracking)
local AppChatPerfTracker = require(AppChat.Telemetry.AppChatPerfTracker)
local FFlagFixPaginatedChatMembersCutoff = require(AppChat.Flags.FFlagFixPaginatedChatMembersCutoff)

local function getActiveRouteName(navigation)
    local state = navigation and navigation.state
    if not (state and state.routes and state.index) then
        return nil
    end

    repeat
        if not (state and state.routes and state.index) then
            return nil
        end

        state = state.routes[state.index]
        if not state then
            return nil
        end
    until not (state.routes and state.index)

    return state.routeName
end

local function wrapInOverlay(robloxStackNavigator) -- Luacid: Inlined by compiler; 1 call site recovered
    return function(arg1)
        local var1 = Responsive.useBreakpointXOrSmaller(Responsive.Keys.Small)
        local yOffset = if Responsive.useBreakpointYOrSmaller(Responsive.Keys.Small) then -24 else -72
        local uDim2 = UDim2.new(1, if var1 then -24 else -360, 1, yOffset)

        local element = nil
        if FFlagAppChatPerfTracking then
            AppChatPerfTracker.start(AppChatPerfTracker.Events.TopBarRenderInterval)
        end
        local screenName = getActiveRouteName(arg1.navigation)

        if screenName == EnumScreens.CreateNewChat
            or screenName == EnumScreens.EditChatMembers
            or screenName == EnumScreens.QuickStartSquadInviteFriends
        then
            element = React.createElement(SystemMenuTopBar, { screenName = screenName, navigation = arg1.navigation })
        end

        local topBar = element or configureTopBarWithNavigationOptions(arg1.navigation)

        return React.createElement(
            Foundation.View,
            {
                tag = "col position-center-center anchor-center-center radius-large clip bg-surface-0",
                Size = uDim2,
                sizeConstraint = {
                    MaxSize = Vector2.new(1000, 800),
                    MinSize = Vector2.new(0, 0)
                }
            },
            {
                topBar = topBar,
                overlayContent = React.createElement(robloxStackNavigator, arg1)
            }
        )
    end
end
return function(arg1)
    local robloxStackNavigator = RoactNavigation.createRobloxStackNavigator(arg1, {
        defaultNavigationOptions = {
            isDialog = true,
            absorbInputSelectable = not FFlagFixPaginatedChatMembersCutoff and nil
        }
    })

    local var1 = React.PureComponent:extend("OverlayNavigatorConnector")
    var1.router = robloxStackNavigator.router
    local func1 = wrapInOverlay(robloxStackNavigator)
    local var2 = isolatedAutoFocusNavigation(func1, FocusNavigableSurfaceIdentifierEnum.PopUp)

    function var1.render(arg2)
        return React.createElement(var2, arg2.props)
    end

    return var1
end
