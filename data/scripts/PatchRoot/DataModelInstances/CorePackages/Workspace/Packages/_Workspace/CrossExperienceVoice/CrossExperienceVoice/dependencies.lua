-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T02:01:32Z
-- Luau bytecode version: 14 | Luau type version: 3
local CrossExperienceVoiceParent = script:FindFirstAncestor("CrossExperienceVoice").Parent

local Promise = require(CrossExperienceVoiceParent.Promise)
local React = require(CrossExperienceVoiceParent.React)
local ReactOtter = require(CrossExperienceVoiceParent.ReactOtter)
local Rodux = require(CrossExperienceVoiceParent.Rodux)
local RoactUtils = require(CrossExperienceVoiceParent.RoactUtils)
local t = require(CrossExperienceVoiceParent.t)
local Cryo = require(CrossExperienceVoiceParent.Cryo)
local CrossExperience = require(CrossExperienceVoiceParent.CrossExperience)
local Dash = require(CrossExperienceVoiceParent.Dash)
local SharedFlags = require(CrossExperienceVoiceParent.SharedFlags)
local Lumberyak = require(CrossExperienceVoiceParent.Lumberyak)
local LuauPolyfill = require(CrossExperienceVoiceParent.LuauPolyfill)
local ExperienceService = require(CrossExperienceVoiceParent.ExperienceService)
local SocialLuaAnalytics = require(CrossExperienceVoiceParent.SocialLuaAnalytics)
local ExperimentCacheManager = require(CrossExperienceVoiceParent.ExperimentCacheManager)
return {
    React = React,
    ReactOtter = ReactOtter,
    Rodux = Rodux,
    Cryo = Cryo,
    Dash = Dash,
    t = t,
    ExperienceService = ExperienceService,
    RoactUtils = RoactUtils,
    CrossExperience = CrossExperience,
    SharedFlags = SharedFlags,
    LoggingProtocol = require(CrossExperienceVoiceParent.LoggingProtocol),
    Lumberyak = Lumberyak,
    LuauPolyfill = LuauPolyfill,
    SocialLuaAnalytics = SocialLuaAnalytics,
    ExperimentCacheManager = ExperimentCacheManager,
    Promise = Promise
}
