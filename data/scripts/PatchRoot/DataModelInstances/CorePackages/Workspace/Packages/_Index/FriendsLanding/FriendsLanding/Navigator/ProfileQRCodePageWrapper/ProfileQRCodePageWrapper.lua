-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T16:01:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsLanding = script:FindFirstAncestor("FriendsLanding")
local dependencies = require(FriendsLanding.dependencies)
local Roact = dependencies.Roact
local React = dependencies.React
local llama = dependencies.llama
local ProfileQRCode = dependencies.ProfileQRCode
local Contexts = dependencies.SocialLuaAnalytics.Analytics.Enums.Contexts
local FriendsLandingContext = require(FriendsLanding.FriendsLandingContext)

local FFlagProfileQRCodeGamepadBackFix = ProfileQRCode.FFlagProfileQRCodeGamepadBackFix

return function(arg1)
    local var1 = FriendsLandingContext.useContext()

    local var2 = if FFlagProfileQRCodeGamepadBackFix then React.useCallback(function()
        arg1.navigation.goBack()
    end, { arg1.navigation }) else nil

    return Roact.createElement(
        ProfileQRCode.ProfileQRCodeEntryPoint,
        llama.Dictionary.join(arg1, {
            onClose = not FFlagProfileQRCodeGamepadBackFix and function()
                arg1.navigation.goBack()
            end or var2,
            source = Contexts.AddFriends,
            robloxEventReceiver = var1.robloxEventReceiver
        })
    )
end
