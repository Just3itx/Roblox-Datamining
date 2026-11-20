-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T10:30:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreationFlow = script:FindFirstAncestor("MomentsCreationFlow")
local MomentsCreationFlowParent = MomentsCreationFlow.Parent

local Cryo = require(MomentsCreationFlowParent.Cryo)
local _MomentsCommon = require(MomentsCreationFlowParent.MomentsCommon)
local Rodux = require(MomentsCreationFlowParent.Rodux)

local ClearEdits = require(MomentsCreationFlow.Actions.ClearEdits)
local CreationFlowState = require(MomentsCreationFlow.Enums.CreationFlowState)
local CreationFlowStateUpdated = require(MomentsCreationFlow.Actions.CreationFlowStateUpdated)
local DescriptionUpdated = require(MomentsCreationFlow.Actions.DescriptionUpdated)
local MusicEditUpdated = require(MomentsCreationFlow.Actions.MusicEditUpdated)
local MusicSearchRetrieved = require(MomentsCreationFlow.Actions.MusicSearchRetrieved)
local SelectedCaptureUpdated = require(MomentsCreationFlow.Actions.SelectedCaptureUpdated)
local TextOverlayEditsUpdated = require(MomentsCreationFlow.Actions.TextOverlayEditsUpdated)
local TrimEditUpdated = require(MomentsCreationFlow.Actions.TrimEditUpdated)

local tbl1 = {
    active = false,
    capture = nil,
    currentState = CreationFlowState.Gallery,
    description = "",
    musicList = {},
    musicEdit = nil,
    textOverlayEdits = nil,
    trimEdit = nil
}

local createReducer = Rodux.createReducer
local tbl2 = {}
tbl2[CreationFlowStateUpdated.name] = function(tbl3, arg1)
    return Cryo.Dictionary.union(tbl3, { currentState = arg1.currentState })
end

tbl2[MusicSearchRetrieved.name] = function(tbl3, arg1)
    return Cryo.Dictionary.union(tbl3, { musicList = arg1.musics })
end

tbl2[SelectedCaptureUpdated.name] = function(tbl3, arg1)
    return Cryo.Dictionary.union(tbl3, { capture = arg1.capture })
end

tbl2[TextOverlayEditsUpdated.name] = function(tbl3, arg1)
    return Cryo.Dictionary.union(tbl3, { textOverlayEdits = arg1.textOverlayEdits })
end

tbl2[TrimEditUpdated.name] = function(tbl3, arg1)
    return Cryo.Dictionary.union(tbl3, { trimEdit = arg1.trimEdit })
end

tbl2[MusicEditUpdated.name] = function(tbl3, arg1)
    return Cryo.Dictionary.union(tbl3, { musicEdit = arg1.musicEdit })
end

tbl2[DescriptionUpdated.name] = function(tbl3, arg1)
    return Cryo.Dictionary.union(tbl3, { description = arg1.description })
end

tbl2[ClearEdits.name] = function(_, arg1)
    return {
        active = true,
        capture = nil,
        currentState = arg1.newState,
        description = "",
        musicList = {},
        musicEdit = nil,
        textOverlayEdits = nil,
        trimEdit = nil
    }
end

return createReducer(tbl1, tbl2)
