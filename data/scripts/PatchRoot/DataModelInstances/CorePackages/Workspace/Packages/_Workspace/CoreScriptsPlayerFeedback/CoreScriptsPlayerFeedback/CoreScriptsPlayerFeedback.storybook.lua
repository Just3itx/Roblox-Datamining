-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T01:11:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local LocalizationService = game:GetService("LocalizationService")

local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent

local React = require(scriptParentParent.React)
local ReactRoblox = require(scriptParentParent.ReactRoblox)
local Foundation = require(scriptParentParent.Foundation)
local Localization = require(scriptParentParent.InExperienceLocales).Localization
local LocalizationProvider = require(scriptParentParent.Localization).LocalizationProvider

local FoundationProvider = Foundation.FoundationProvider

local localization = Localization.new(LocalizationService.RobloxLocaleId)

return {
    name = scriptParent.Name,
    storyRoot = scriptParent,
    roact = React,
    reactRoblox = ReactRoblox,
    mapStory = function(arg1) -- name: StoryBookMapStory
        return function(arg2)
            return React.createElement(LocalizationProvider, { localization = localization }, {
                FoundationProvider = React.createElement(
                    FoundationProvider,
                    {
                        colorMode = Foundation.Enums.ColorMode.Dark
                    },
                    {
                        Child = React.createElement(arg1, arg2)
                    }
                )
            })
        end
    end
}
