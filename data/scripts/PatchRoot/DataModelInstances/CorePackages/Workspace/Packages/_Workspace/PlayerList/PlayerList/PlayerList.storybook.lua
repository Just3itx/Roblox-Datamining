-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T03:10:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent

local React = require(scriptParentParent.React)
local ReactRoblox = require(scriptParentParent.ReactRoblox)
local Foundation = require(scriptParentParent.Foundation)

local FoundationProvider = Foundation.FoundationProvider
local ColorMode = Foundation.Enums.ColorMode
local FFlagPlayerListContrastingTeamText = require(scriptParent.Flags.FFlagPlayerListContrastingTeamText)

local tbl1 = {
    Default = ColorMode.Dark,
    Light = ColorMode.Light,
    Dark = ColorMode.Dark
}

return {
    name = "PlayerList",
    storyRoots = { scriptParent },
    roact = React,
    reactRoblox = ReactRoblox,
    mapStory = function(arg1)
        return function(arg2)
            local settings = arg2.settings

            if not FFlagPlayerListContrastingTeamText then
                local UserGameSettings = UserSettings():GetService("UserGameSettings")
                local preferredTransparency = if settings then settings.preferredTransparency else nil

                React.useEffect(function()
                    local preferredTransparency2 = UserGameSettings.PreferredTransparency
                    return function()
                        UserGameSettings.PreferredTransparency = preferredTransparency2
                    end
                end, {})

                React.useEffect(function()
                    if preferredTransparency == nil then
                        return
                    end
                    UserGameSettings.PreferredTransparency = preferredTransparency
                end, { preferredTransparency })
            end

            return React.createElement(FoundationProvider, {
                colorMode = tbl1[arg2.theme] or ColorMode.Dark,
                preferences = settings,
                scale = if settings then settings.scale else nil
            }, {
                Child = React.createElement(arg1, arg2)
            })
        end
    end
}
