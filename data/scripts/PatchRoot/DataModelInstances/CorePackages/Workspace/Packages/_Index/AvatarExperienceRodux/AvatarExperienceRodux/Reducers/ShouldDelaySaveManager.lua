-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T04:20:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceRodux = script:FindFirstAncestor("AvatarExperienceRodux")
local AvatarExperienceRoduxParent = AvatarExperienceRodux.Parent
local Rodux = require(AvatarExperienceRoduxParent.Rodux)

local AddSaveDelay = require(AvatarExperienceRodux.Actions.AddSaveDelay)
local RemoveSaveDelay = require(AvatarExperienceRodux.Actions.RemoveSaveDelay)

local createReducer = Rodux.createReducer
local tbl1 = {}
tbl1[AddSaveDelay.name] = function(_, _): boolean
    return true
end

tbl1[RemoveSaveDelay.name] = function(_, _): boolean
    return false
end

return createReducer(false, tbl1)
