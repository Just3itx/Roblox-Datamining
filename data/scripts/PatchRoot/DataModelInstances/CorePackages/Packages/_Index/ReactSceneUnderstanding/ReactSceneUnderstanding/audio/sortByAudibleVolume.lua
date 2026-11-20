-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:41:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ReactSceneUnderstanding = script:FindFirstAncestor("ReactSceneUnderstanding")

local Cryo = require(ReactSceneUnderstanding.Parent.Cryo)
local SceneUnderstanding = require(ReactSceneUnderstanding.Parent.SceneUnderstanding)

local function sortByAudibleVolume(tbl1)
    local var1 = Cryo.List.filter(tbl1, SceneUnderstanding.isAudible)

    return Cryo.List.sort(var1, function(arg1, arg2): boolean
        return SceneUnderstanding.calculatePotentialAudibility(arg1) > SceneUnderstanding.calculatePotentialAudibility(arg2)
    end)
end

return sortByAudibleVolume
