-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T04:20:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceRodux = script:FindFirstAncestor("AvatarExperienceRodux")
local AvatarExperienceRoduxParent = AvatarExperienceRodux.Parent
local Rodux = require(AvatarExperienceRoduxParent.Rodux)

local SetCurrentCharacter = require(AvatarExperienceRodux.Actions.SetCurrentCharacter)

local createReducer = Rodux.createReducer
local tbl1 = {}
tbl1[SetCurrentCharacter.name] = function(_, arg1)
    return arg1.currentCharacter
end

return createReducer(nil, tbl1)
