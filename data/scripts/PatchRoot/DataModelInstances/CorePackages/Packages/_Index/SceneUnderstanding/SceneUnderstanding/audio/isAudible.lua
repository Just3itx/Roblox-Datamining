-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T14:31:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SceneUnderstanding = script:FindFirstAncestor("SceneUnderstanding")

local calculatePotentialAudibility = require(SceneUnderstanding.audio.calculatePotentialAudibility)

local function isAudible(arg1): boolean
    return calculatePotentialAudibility(arg1) > 0.01
end

return isAudible
