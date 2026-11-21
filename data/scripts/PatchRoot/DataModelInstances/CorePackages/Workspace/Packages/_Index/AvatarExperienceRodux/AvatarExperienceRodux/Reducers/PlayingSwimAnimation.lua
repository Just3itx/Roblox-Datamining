-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T04:20:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceRodux = script:FindFirstAncestor("AvatarExperienceRodux")
local AvatarExperienceRoduxParent = AvatarExperienceRodux.Parent
local Rodux = require(AvatarExperienceRoduxParent.Rodux)

local PlayingSwimAnimation = require(AvatarExperienceRodux.Actions.PlayingSwimAnimation)

local createReducer = Rodux.createReducer
local tbl1 = {}
tbl1[PlayingSwimAnimation.name] = function(_: boolean, arg1)
    return arg1.playingSwimAnimation
end

return createReducer(false, tbl1)
