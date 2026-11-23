-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T01:01:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TrustedContacts = script:FindFirstAncestor("TrustedContacts")
local TrustedContactsParent = TrustedContacts.Parent

local RoactNavigation = require(TrustedContactsParent.RoactNavigation)
local AppPage = require(TrustedContactsParent.RobloxAppEnums).AppPage

local tbl1 = {
    [AppPage.TrustedFriendsUserModal] = {
        getScreen = function()
            return require(TrustedContacts.Components.TrustedContactsModal).Screen
        end,
        navigationOptions = {
            renderUnderlyingPage = true,
            disableBackButton = true,
            overlayEnabled = true
        }
    }
}

local tbl2 = {
    [AppPage.TrustedFriendsVPCPrologue] = {
        getScreen = function()
            return require(TrustedContacts.Components.TrustedFriendsVPCPrologue).Screen
        end,
        navigationOptions = {
            renderUnderlyingPage = true,
            disableBackButton = true,
            overlayEnabled = true
        }
    }
}

local tbl3 = { tbl1, tbl2 }

return (RoactNavigation.createRobloxStackNavigator(tbl3, {
    initialRouteName = AppPage.TrustedFriendsUserModal,
    keepVisitedScreensMounted = false,
    backBehavior = RoactNavigation.BackBehavior.History
}))
