-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T20:10:44Z
-- Luau bytecode version: 14 | Luau type version: 3
local CorePackages = game:GetService("CorePackages")

local Rodux = require(CorePackages.Packages.Rodux)

local scriptParent = script.Parent

local DisplayOptions = require(scriptParent.DisplayOptions)
local EmotesPage = require(scriptParent.EmotesPage)
local EmotesWheel = require(scriptParent.EmotesWheel)
local Layout = require(scriptParent.Layout)
local Locale = require(scriptParent.Locale)

return (Rodux.combineReducers({
    displayOptions = DisplayOptions,
    emotesPage = EmotesPage,
    emotesWheel = EmotesWheel,
    layout = Layout,
    locale = Locale
}))
