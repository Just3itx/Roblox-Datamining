-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:30:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent
local React = require(ProfilePlatformParent.React)
local _EventNames = require(ProfilePlatform.Analytics.EventNames)
local AppCommonLib = require(ProfilePlatformParent.AppCommonLib)

return React.createContext({
    fireAnalyticsEvent = function() end,
    scrollViewPositionChangedSignal = AppCommonLib.Signal.new()
})
