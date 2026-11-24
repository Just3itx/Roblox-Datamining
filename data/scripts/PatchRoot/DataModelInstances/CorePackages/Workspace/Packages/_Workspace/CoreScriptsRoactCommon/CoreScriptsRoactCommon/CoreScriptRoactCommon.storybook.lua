-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T01:30:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreScriptsRoactCommon = script:FindFirstAncestor("CoreScriptsRoactCommon")
local CoreScriptsRoactCommonParent = CoreScriptsRoactCommon.Parent
local React = require(CoreScriptsRoactCommonParent.React)
local ReactRoblox = require(CoreScriptsRoactCommonParent.ReactRoblox)
local Localization = require(CoreScriptsRoactCommonParent.InExperienceLocales).Localization
local LocalizationProvider = require(CoreScriptsRoactCommonParent.Localization).LocalizationProvider

local FoundationStorybookMiddleware = require(script.Parent.FoundationStorybookMiddleware)

local localization = Localization.new("en-us")

local function wrapWithProviders(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    return function(arg2)
        return React.createElement(LocalizationProvider, { localization = localization }, { Child = React.createElement(arg1, arg2) })
    end
end

return {
    name = CoreScriptsRoactCommon.Name,
    storyRoot = CoreScriptsRoactCommon,
    roact = React,
    reactRoblox = ReactRoblox,
    mapStory = function(arg1) -- name: StoryBookMapStory
        local func1 = wrapWithProviders(arg1)
        return FoundationStorybookMiddleware(func1)
    end
}
