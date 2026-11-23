-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T21:00:53Z
-- Luau bytecode version: 14 | Luau type version: 3
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local Signals = require(BuildExperience.Parent.Signals)
local createAgentAdCampaignStore = require(script.createAgentAdCampaignStore)

return Signals.createComputed(createAgentAdCampaignStore)
