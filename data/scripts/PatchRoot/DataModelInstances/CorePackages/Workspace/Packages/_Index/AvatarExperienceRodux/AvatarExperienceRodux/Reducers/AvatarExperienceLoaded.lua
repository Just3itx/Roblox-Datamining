-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T04:20:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceRodux = script:FindFirstAncestor("AvatarExperienceRodux")
local AvatarExperienceRoduxParent = AvatarExperienceRodux.Parent
local Rodux = require(AvatarExperienceRoduxParent.Rodux)

local AvatarExperienceLoaded = require(AvatarExperienceRodux.Actions.AvatarExperienceLoaded)

local createReducer = Rodux.createReducer
local tbl1 = {}
tbl1[AvatarExperienceLoaded.name] = function(_: boolean, _): boolean
    return true
end

return createReducer(false, tbl1)
