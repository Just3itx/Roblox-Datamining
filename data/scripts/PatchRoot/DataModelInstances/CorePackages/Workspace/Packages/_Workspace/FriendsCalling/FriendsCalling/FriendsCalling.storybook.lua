-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T12:01:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsCalling = script:FindFirstAncestor("FriendsCalling")
local FriendsCallingParent = FriendsCalling.Parent

local Foundation = require(FriendsCallingParent.Foundation)
local React = require(FriendsCallingParent.React)
local ReactRoblox = require(FriendsCallingParent.Dev.ReactRoblox)

local ColorMode = Foundation.Enums.ColorMode
local Device = Foundation.Enums.Device
local FoundationProvider = Foundation.FoundationProvider

local tbl1 = {
    Dark = ColorMode.Dark,
    Light = ColorMode.Light
}

return {
    name = "FriendsCalling",
    roact = React,
    reactRoblox = ReactRoblox,
    mapStory = function(arg1)
        return function(arg2)
            return React.createElement(FoundationProvider, {
                colorMode = tbl1[arg2.theme] or ColorMode.Dark,
                device = Device[arg2.platform] or Device.Phone,
                preferences = arg2.settings,
                scale = arg2.settings and arg2.settings.scale
            }, {
                Child = React.createElement(arg1, arg2)
            })
        end
    end,
    storyRoots = { FriendsCalling }
}
