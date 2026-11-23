-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:01:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local RoactNavigation = require(AppChatParent.RoactNavigation)
local chatLandingStackNavigatorScreens = require(script.Parent.chatLandingStackNavigatorScreens)

local FFlagAppChatDisableAbsorbInputSelectable = require(AppChat.Flags.FFlagAppChatDisableAbsorbInputSelectable)

local function instantTransitionConfig()
    return {
        transitionSpec = { frequency = 1000000, dampingRatio = 1 }
    }
end

local function getChatLandingStackNavigator(arg1)
    return RoactNavigation.createRobloxStackNavigator(chatLandingStackNavigatorScreens, {
        defaultNavigationOptions = FFlagAppChatDisableAbsorbInputSelectable and {
            absorbInputSelectable = false
        } or nil,
        transitionConfig = if arg1 then instantTransitionConfig else nil
    })
end
return getChatLandingStackNavigator
