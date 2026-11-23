-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T21:01:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local Signals = require(BuildExperience.Parent.Signals)
local createBuildCreatorCreditRefreshStore = require(script.createBuildCreatorCreditRefreshStore)

return Signals.createComputed(function()
    return createBuildCreatorCreditRefreshStore()
end)
