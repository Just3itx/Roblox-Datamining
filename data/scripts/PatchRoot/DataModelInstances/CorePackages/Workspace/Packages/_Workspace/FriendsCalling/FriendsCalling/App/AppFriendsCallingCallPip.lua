-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T11:51:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsCalling = script:FindFirstAncestor("FriendsCalling")
local FriendsCallingParent = FriendsCalling.Parent

local React = require(FriendsCallingParent.React)

local CallPip = require(FriendsCalling.Components.CallPip.CallPip)
local host = {
    displayOrder = require(FriendsCalling.CallPipDisplayOrder).InApp,
    exposesTopSafeArea = false,
    followsAppColorMode = true,
    screenInsets = Enum.ScreenInsets.None
}

local function AppFriendsCallingCallPip()
    return React.createElement(CallPip, { host = host, isMicrophoneMuted = false, initialPresentation = "Expanded" })
end

return AppFriendsCallingCallPip
