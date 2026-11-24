-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T02:11:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CrossExperienceVoice = script:FindFirstAncestor("CrossExperienceVoice")

local dependencies = require(CrossExperienceVoice.dependencies)

local SharedFlags = dependencies.SharedFlags
local ExperimentCacheManager = dependencies.ExperimentCacheManager.ExperimentCacheManager

local GetFFlagEnableCrossExpVoice = SharedFlags.GetFFlagEnableCrossExpVoice

local str1 = game:DefineFastString("CrossExpVoiceIXPLayer", "Social.PartyVoice")
local str2 = game:DefineFastString("DebugCrossExpVoiceIXPLayer", "")

local engineFeature = game:GetEngineFeature("PartyVoiceVolume")

local module = {}
module.__index = module

local tbl1 = {
    CrossExpVoiceDebugVariant_0 = { partyVoiceExp = false },
    CrossExpVoiceDebugVariant_1 = { partyVoiceExp = true }
}

function module.new()
    local tbl2 = {
        initialized = false,
        variant = {}
    }

    setmetatable(tbl2, module)
    return tbl2
end

function module:initialize()
    local layerVariables = ExperimentCacheManager.default:getLayerVariables(str1)

    if layerVariables ~= nil then
        self.initialized = true
        self.variant = table.clone(layerVariables)
    end

    if str2 ~= "None" then
        self.initialized = true
        self.variant = tbl1[str2] or self.variant
    end
end

function module.logLayerExposure(_)
    ExperimentCacheManager.default:logLayerExposure(str1)
end

function module.getHasPartyVoiceVolume()
    return engineFeature and module.default.variant.partyVoiceExp
end

module.default = if GetFFlagEnableCrossExpVoice() then module.new() else nil

return module
