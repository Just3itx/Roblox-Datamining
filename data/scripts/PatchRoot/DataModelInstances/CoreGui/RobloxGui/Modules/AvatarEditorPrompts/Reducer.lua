-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:20:39Z
-- Luau bytecode version: 14 | Luau type version: 3
local CorePackages = game:GetService("CorePackages")

local Rodux = require(CorePackages.Packages.Rodux)

local PromptInfo = require(script.PromptInfo)
local ScreenSize = require(script.ScreenSize)
local GameName = require(script.GameName)
local AnalyticsInfo = require(script.AnalyticsInfo)

return (Rodux.combineReducers({
    promptInfo = PromptInfo,
    screenSize = ScreenSize,
    ScreenSize = ScreenSize,
    gameName = GameName,
    analyticsInfo = AnalyticsInfo
}))
