-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T18:21:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local LocalizationService = game:GetService("LocalizationService")

local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent

local React = require(scriptParentParent.React)
local Foundation = require(scriptParentParent.Foundation)
local ReactRoblox = require(scriptParentParent.ReactRoblox)
local Localization = require(scriptParentParent.InExperienceLocales).Localization
local LocalizationProvider = require(scriptParentParent.Localization).LocalizationProvider
local KeybindContextProvider = require(scriptParent.Context.KeybindContextProvider)
local localization = Localization.new(LocalizationService.RobloxLocaleId)

local FoundationProvider = Foundation.FoundationProvider

return {
    name = scriptParent.Name,
    storyRoot = scriptParent,
    roact = React,
    reactRoblox = ReactRoblox,
    mapStory = function(arg1) -- name: StoryBookMapStory
        return function(arg2)
            return React.createElement(LocalizationProvider, { localization = localization }, {
                KeybindContextProvider = React.createElement(KeybindContextProvider, nil, {
                    FoundationProvider = React.createElement(
                        FoundationProvider,
                        {
                            colorMode = Foundation.Enums.ColorMode.Dark
                        },
                        { React.createElement(arg1, arg2) }
                    )
                })
            })
        end
    end
}
