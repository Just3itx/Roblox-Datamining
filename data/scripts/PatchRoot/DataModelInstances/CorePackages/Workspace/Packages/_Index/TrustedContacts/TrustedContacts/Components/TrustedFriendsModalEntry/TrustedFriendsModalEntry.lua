-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T01:01:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TrustedContacts = script:FindFirstAncestor("TrustedContacts")
local TrustedContactsParent = TrustedContacts.Parent

local React = require(TrustedContactsParent.React)
local RoactNavigation = require(TrustedContactsParent.RoactNavigation)

local TrustedFriendsModalNavigator = require(script.Parent.TrustedFriendsModalNavigator)
local useExternalNavigationSetUp = require(script.Parent.useExternalNavigationSetUp)

local _Types = require(TrustedContacts.Common.Types)

local function TrustedFriendsModalEntry(arg1)
    local navigation = arg1.navigation

    local var1 = React.useMemo(function()
        return RoactNavigation.createAppContainer(TrustedFriendsModalNavigator)
    end, {})

    if navigation then
        arg1 = navigation.getParam("props")
    end

    if navigation then
        var1 = TrustedFriendsModalNavigator
    end
    local externalNavigation = useExternalNavigationSetUp({ navigation = navigation, onClosed = arg1.onClosed })

    return React.createElement(var1, {
        navigation = navigation,
        screenProps = {
            modalProps = {
                userId = arg1.userId,
                source = arg1.source,
                isVerticallyConstrained = arg1.isVerticallyConstrained,
                onRequestAccepted = arg1.onRequestAccepted,
                onRequestSent = arg1.onRequestSent,
                onAcknowledged = arg1.onAcknowledged,
                modalVariantOverride = arg1.modalVariantOverride,
                tokens = arg1.tokens,
                sentFromQrCode = arg1.sentFromQrCode,
                onClosed = nil
            },
            externalNavigation = externalNavigation
        }
    })
end

local var1 = React.PureComponent:extend("classWrapper")
function var1.render(arg1)
    return React.createElement(TrustedFriendsModalEntry, arg1.props)
end
var1.router = TrustedFriendsModalNavigator.router

return var1
