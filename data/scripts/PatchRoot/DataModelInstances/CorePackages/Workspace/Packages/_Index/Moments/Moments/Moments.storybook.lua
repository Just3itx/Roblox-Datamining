-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T05:21:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local LocalizationService = game:GetService("LocalizationService")

local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local Foundation = require(MomentsParent.Foundation)
local LocalizationProvider = require(MomentsParent.Localization).LocalizationProvider
local React = require(MomentsParent.React)
local ReactRoblox = require(MomentsParent.ReactRoblox)
local Localization = require(MomentsParent.Dev.RobloxAppLocales).Localization

local ColorMode = Foundation.Enums.ColorMode
local Device = Foundation.Enums.Device
local FoundationProvider = Foundation.FoundationProvider

local tbl1 = {
    Dark = ColorMode.Dark,
    Light = ColorMode.Light
}

return {
    name = "Moments",
    roact = React,
    reactRoblox = ReactRoblox,
    mapStory = function(arg1)
        return function(arg2)
            local localization = React.useMemo(function()
                return Localization.new(LocalizationService.RobloxLocaleId)
            end, {})

            return React.createElement(LocalizationProvider, { localization = localization }, {
                Foundation = React.createElement(FoundationProvider, {
                    colorMode = tbl1[arg2.theme] or ColorMode.Dark,
                    device = Device[arg2.platform] or Device.Phone,
                    preferences = arg2.settings,
                    scale = arg2.settings and arg2.settings.scale
                }, {
                    Child = React.createElement(arg1, arg2)
                })
            })
        end
    end,
    storyRoots = { Moments }
}
