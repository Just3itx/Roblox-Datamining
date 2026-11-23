-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T21:01:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local Signals = require(BuildExperienceParent.Signals)
local DataHydrationUtils = require(BuildExperienceParent.DataHydration).DataHydrationUtils
local createBuildModelSelectionStore = require(script.createBuildModelSelectionStore)

return Signals.createComputed(function()
    return createBuildModelSelectionStore(if game.GameId > 0 then DataHydrationUtils.getLocalPlayerUserId() else nil)
end)
