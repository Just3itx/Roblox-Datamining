-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T15:41:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsLanding = script:FindFirstAncestor("FriendsLanding")
local FriendsLandingParent = FriendsLanding.Parent
local dependencies = require(FriendsLanding.dependencies)

local Roact = dependencies.Roact
local UIBlox = dependencies.UIBlox
local withStyle = UIBlox.Style.withStyle
local withLocalization = dependencies.withLocalization
local ContextualMenu = UIBlox.App.Menu.ContextualMenu
local MenuDirection = UIBlox.App.Menu.MenuDirection
local FriendsLandingContext = require(FriendsLanding.FriendsLandingContext)
local Images = UIBlox.App.ImageSet.Images
local mapStateToProps = require(FriendsLanding.Components.FriendsLandingContainer.mapStateToProps)
local RoactRodux = dependencies.RoactRodux
local compose = dependencies.SocialLibraries.RoduxTools.compose
local FriendsNetworking = dependencies.FriendsNetworking
local EnumScreens = require(FriendsLanding.EnumScreens)
local memoize = dependencies.memoize
local Otter = dependencies.Otter

local FFlagMigrateFriendshipStatusesRemainingActions = require(FriendsLandingParent.SharedFlags).FFlagMigrateFriendshipStatusesRemainingActions
local var1 = require(FriendsLandingParent.DataHydration).Friends.FriendsStore.get()

local var2 = Roact.PureComponent:extend("FriendsLandingContextualMenu")

local motorOverrideOptions = {
    motorCallback = Otter.instant,
    open = { targetValue = 1 },
    close = { targetValue = 0 }
}

function var2.init(arg1)
    function arg1.onClose()
        if arg1.props.navigation then
            arg1.props.navigation.goBack()
        end
    end

    arg1.onUnfriend = memoize(function(toastTitle, iconImage)
        arg1.props.navigation.navigate(
            EnumScreens.GenericToast,
            {
                toastProps = {
                    toastContent = { toastTitle = toastTitle, iconImage = iconImage }
                }
            }
        )
    end)

    arg1.onActivated = memoize(function(arg2, arg3)
        return function()
            local userId = arg1.props.navigation.state.params.userId
            if userId ~= nil then
                local var3 = if FFlagMigrateFriendshipStatusesRemainingActions then var1.Unfriend(userId) else arg1.props.unfriendTargetUserId({ targetUserId = userId, currentUserId = arg1.props.localUserId })

                var3:andThen(function()
                    arg1.onUnfriend(arg2, Images["icons/actions/friends/friendRemove"])
                end):catch(function()
                    arg1.onUnfriend(arg3)
                end)
            end
            arg1.onClose()
        end
    end)
end

function var2.render(arg1)
    return withStyle(function(_)
        return withLocalization({
            unfriend = "Feature.Friends.Action.Unfriend",
            error = "Feature.Toast.NetworkingError.SomethingIsWrong",
            success = "Feature.Friends.Action.FriendRemoved"
        })(
            function(arg2)
                local unfriend = arg2.unfriend
                local success = arg2.success
                local error = arg2.error

                return Roact.createElement(ContextualMenu, {
                    buttonProps = {{
                        icon = Images["icons/actions/friends/friendRemove"],
                        text = unfriend,
                        onActivated = arg1.onActivated(success, error)
                    }},
                    open = true,
                    menuDirection = MenuDirection.Up,
                    openPositionY = UDim.new(1, -24),
                    screenSize = arg1.props.screenSize,
                    onDismiss = arg1.onClose,
                    closeBackgroundVisible = false,
                    motorOverrideOptions = motorOverrideOptions
                })
            end
        )
    end)
end
return compose(RoactRodux.connect(mapStateToProps, function(arg1)
    return {
        unfriendTargetUserId = function(arg2)
            return arg1(FriendsNetworking.UnfriendTargetUserId.API(arg2))
        end
    }
end), FriendsLandingContext.connect(function(arg1, _)
    return {
        screenSize = arg1.screenSize
    }
end))(var2)
