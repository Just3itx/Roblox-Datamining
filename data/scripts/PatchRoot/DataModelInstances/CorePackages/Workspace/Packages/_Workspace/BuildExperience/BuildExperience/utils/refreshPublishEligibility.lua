-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T21:20:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local ExperienceGuidelines = require(BuildExperienceParent.DataHydration.ExperienceGuidelines)
local ExperienceQuestionnaire = require(BuildExperienceParent.DataHydration.ExperienceQuestionnaire)
local UniverseActivation = require(BuildExperienceParent.DataHydration.UniverseActivation)

local function refreshPublishEligibility(num1: number)
    local experienceGuidelinesStore = ExperienceGuidelines.getExperienceGuidelinesStore()
    local universeActivationStore = UniverseActivation.getUniverseActivationStore()
    experienceGuidelinesStore.refreshDetailedGuidelines(num1):catch(function() end)

    universeActivationStore.refreshEligibility(num1):catch(function() end)
    ExperienceQuestionnaire.getExperienceQuestionnaireStore().fetchEligibility(num1)
end

return refreshPublishEligibility
