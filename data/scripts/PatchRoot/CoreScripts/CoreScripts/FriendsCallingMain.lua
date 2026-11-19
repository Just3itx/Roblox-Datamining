-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:31:19Z
-- Luau bytecode version: 14 | Luau type version: 3
local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")

local React = require(CorePackages.Packages.React)
local ReactRoblox = require(CorePackages.Packages.ReactRoblox)
local CallPip = require(CorePackages.Workspace.Packages.FriendsCalling.CallPip)
local CallPipDisplayOrder = require(CorePackages.Workspace.Packages.FriendsCalling.CallPipDisplayOrder)
local FFlagFriendsCallingCallPip = require(CorePackages.Workspace.Packages.FriendsCalling.FFlagFriendsCallingCallPip)

local VoiceCallReceivedEventReceiver = require(CorePackages.Workspace.Packages.FriendsCalling.VoiceCallReceivedEventReceiver)

local FriendsCalling = Instance.new("Folder")
FriendsCalling.Name = "FriendsCalling"
FriendsCalling.Parent = CoreGui

local host = {
    displayOrder = CallPipDisplayOrder.InExperience,
    exposesTopSafeArea = true,
    followsAppColorMode = false,
    screenInsets = Enum.ScreenInsets.None
}

local root = ReactRoblox.createRoot(FriendsCalling)
local createElement = React.createElement
local Fragment = React.Fragment
local var1 = nil
local tbl2 = {
    CallPip = if FFlagFriendsCallingCallPip then React.createElement(CallPip, { host = host, isMicrophoneMuted = false }) else nil,
    VoiceCallReceivedEventReceiver = React.createElement(VoiceCallReceivedEventReceiver)
}
root:render(createElement(Fragment, var1, tbl2))
