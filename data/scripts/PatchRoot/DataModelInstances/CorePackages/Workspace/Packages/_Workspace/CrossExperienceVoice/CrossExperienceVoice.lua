-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T02:01:15Z
-- Luau bytecode version: 14 | Luau type version: 3
local CrossExperience = require(script.dependencies).CrossExperience

local _Types = require(script.Common.Types)

return {
    Analytics = require(script.Analytics),
    Common = require(script.Common),
    Component = require(script.Component),
    CrossExperienceVoiceAnalytics = require(script.CrossExperienceVoiceAnalytics),
    CrossExperienceVoiceManager = require(script.CrossExperienceVoiceManager),
    Hooks = require(script.Hooks),
    installReducer = CrossExperience.installReducer,
    Utils = require(script.Utils),
    IXPManager = require(script.IXPManager)
}
