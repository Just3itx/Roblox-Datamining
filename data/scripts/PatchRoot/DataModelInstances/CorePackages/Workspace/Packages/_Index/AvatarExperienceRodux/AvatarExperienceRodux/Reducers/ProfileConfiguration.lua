-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T04:20:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceRodux = script:FindFirstAncestor("AvatarExperienceRodux")
local AvatarExperienceRoduxParent = AvatarExperienceRodux.Parent
local Cryo = require(AvatarExperienceRoduxParent.Cryo)
local Rodux = require(AvatarExperienceRoduxParent.Rodux)
local AvatarExperienceCommon = require(AvatarExperienceRoduxParent.AvatarExperienceCommon)
local AvatarExperienceFlags = require(AvatarExperienceRoduxParent.AvatarExperienceFlags)

local _RoduxTypes = require(AvatarExperienceRodux.Types.RoduxTypes)
local ApplyProfileConfiguration = require(AvatarExperienceRodux.Actions.ApplyProfileConfiguration)

local CharacterHistoryStateChangeButtonActivated = AvatarExperienceCommon.State.Actions.CharacterHistoryStateChangeButtonActivated
local FFlagAXBackgroundsPersistence = AvatarExperienceFlags.FFlagAXBackgroundsPersistence

local createReducer = Rodux.createReducer

local tbl1 = {}
tbl1[ApplyProfileConfiguration.name] = function(arg1, arg2)
    return Cryo.Dictionary.join(arg1, arg2.profileConfiguration)
end

tbl1[CharacterHistoryStateChangeButtonActivated.name] = function(arg1, arg2)
    return if FFlagAXBackgroundsPersistence and arg2.equipped then {
        BackgroundAssetId = arg2.equipped.BackgroundAssetId
    } else arg1
end

return createReducer({}, tbl1)
