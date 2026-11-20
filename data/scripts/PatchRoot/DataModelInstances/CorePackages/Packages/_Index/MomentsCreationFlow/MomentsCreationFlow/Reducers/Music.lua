-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T10:30:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreationFlow = script:FindFirstAncestor("MomentsCreationFlow")
local MomentsCreationFlowParent = MomentsCreationFlow.Parent

local Cryo = require(MomentsCreationFlowParent.Cryo)
local _MomentsCommon = require(MomentsCreationFlowParent.MomentsCommon)
local Rodux = require(MomentsCreationFlowParent.Rodux)

local CreationFlowMusicInfoRetrieved = require(MomentsCreationFlow.Actions.CreationFlowMusicInfoRetrieved)

local createReducer = Rodux.createReducer
local tbl1 = {}
tbl1[CreationFlowMusicInfoRetrieved.name] = function(tbl2, arg1)
    return Cryo.Dictionary.union(tbl2, arg1.musicInfos)
end

return createReducer({}, tbl1)
