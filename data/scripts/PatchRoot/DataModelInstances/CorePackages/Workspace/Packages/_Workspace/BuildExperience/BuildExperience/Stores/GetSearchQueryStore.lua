-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T21:01:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local Signals = require(BuildExperienceParent.Signals)
local createSearchQueryStore = require(script.createSearchQueryStore)

return Signals.createComputed(function()
    return createSearchQueryStore()
end)
