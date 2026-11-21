-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T15:50:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsLanding = script:FindFirstAncestor("FriendsLanding")
local FriendsLandingParent = FriendsLanding.Parent
local dependencies = require(FriendsLanding.dependencies)

local Roact = dependencies.Roact
local withLocalization = dependencies.withLocalization
local Actions = dependencies.RoactNavigation.Actions
local FriendsLandingContext = require(FriendsLanding.FriendsLandingContext)
local FriendsLandingHeaderBarPresentational = require(script.FriendsLandingHeaderBarPresentational)
local AppHeaderBar = dependencies.AppHeaderBar

local getActiveChildNavigationOptionsSafely = require(FriendsLanding.Navigator.getActiveChildNavigationOptionsSafely)
local isTenFootInterface = require(FriendsLandingParent.AppCommonLib).isTenFootInterface

local var1 = Roact.PureComponent:extend("FriendsLandingHeaderBar")

function var1.init(arg1)
    function arg1.renderLeft(arg2, _, _)
        local makeBackButton = AppHeaderBar.makeBackButton

        if isTenFootInterface() then
            return nil
        end
        return makeBackButton(function()
            arg2.dispatch(Actions.back())
        end)
    end
end

function var1.render(arg1)
    return FriendsLandingContext.with(function(arg2)
        local navigation = arg1.props.navigation
        local activeChildNavigationOptionsSafely = getActiveChildNavigationOptionsSafely(navigation)
        local headerText = activeChildNavigationOptionsSafely.headerText
        return withLocalization({ titleText = headerText.raw })(function(arg3)
            local titleText = arg3.titleText

            if arg2.addFriendsPageSearchbarEnabled then
                return Roact.createElement(FriendsLandingHeaderBarPresentational, {
                    title = titleText,
                    renderLeft = activeChildNavigationOptionsSafely.renderLeft or arg1.renderLeft(navigation),
                    renderCenter = activeChildNavigationOptionsSafely.renderCenter,
                    renderRight = activeChildNavigationOptionsSafely.renderRight,
                    isSecondary = activeChildNavigationOptionsSafely.useSecondaryHeader
                })
            end
            return Roact.createElement(FriendsLandingHeaderBarPresentational, {
                title = titleText,
                renderLeft = activeChildNavigationOptionsSafely.renderLeft or arg1.renderLeft(navigation),
                renderCenter = activeChildNavigationOptionsSafely.renderCenter,
                renderRight = activeChildNavigationOptionsSafely.renderRight
            })
        end)
    end)
end

return var1
