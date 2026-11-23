-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T22:04:10Z
-- Luau bytecode version: 14 | Luau type version: 3
local BuildExperiencePlaytestLaunchParent = script:FindFirstAncestor("BuildExperiencePlaytestLaunch").Parent

local Signals = require(BuildExperiencePlaytestLaunchParent.Signals)
local createPlaytestLoadingStore = require(script.createPlaytestLoadingStore)

return Signals.createComputed(createPlaytestLoadingStore)
