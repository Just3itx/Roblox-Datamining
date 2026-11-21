-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T16:01:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsLanding = script:FindFirstAncestor("FriendsLanding")
local FriendsLandingParent = FriendsLanding.Parent
local Roact = require(FriendsLanding.dependencies).Roact
local MainStackNavigator = require(FriendsLanding.Navigator.MainStackNavigator)
local FriendsLandingHeaderBar = require(FriendsLanding.Components.FriendsLandingHeaderBar)
local isFromConnectionsHub = require(FriendsLanding.Navigator.isFromConnectionsHub)
local Constants = require(FriendsLanding.Common.Constants)

local FFlagCreateConnectionsHub = require(FriendsLandingParent.SharedFlags).FFlagCreateConnectionsHub
local FFlagFixFriendsListGapInConnectionsHub = require(FriendsLanding.Flags.FFlagFixFriendsListGapInConnectionsHub)

local var1 = Roact.PureComponent:extend("MainStackNavigatorConnector")

function var1.render(arg1)
    local navigation = arg1.props.navigation
    local var2 = FFlagCreateConnectionsHub and isFromConnectionsHub(navigation)
    local bool1 = not (FFlagCreateConnectionsHub and var2)

    local element = Roact.createElement(MainStackNavigator, { navigation = arg1.props.navigation })

    local createFragment = Roact.createFragment
    local tbl1 = {
        layout = Roact.createElement("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder }),
        topBar = if bool1 then Roact.createElement(FriendsLandingHeaderBar, { navigation = arg1.props.navigation }) else nil,
        navigator = 0
    }

    if FFlagFixFriendsListGapInConnectionsHub then
        element = Roact.createElement("Frame", {
            Size = UDim2.new(1, 0, 1, if bool1 then -Constants.TOP_BAR_HEIGHT else 0),
            BackgroundTransparency = 1,
            LayoutOrder = 1
        }, { MainStackNavigator = element })
    end

    tbl1.navigator = element
    return createFragment(tbl1)
end

var1.router = MainStackNavigator.router

return var1
