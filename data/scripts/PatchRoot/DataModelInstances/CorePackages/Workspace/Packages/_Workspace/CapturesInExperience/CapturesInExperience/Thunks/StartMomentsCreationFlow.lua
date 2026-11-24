-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:10:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local MomentsCreationFlowOpened = require(scriptParentParent.Actions.MomentsCreationFlowOpened)
local _Types = require(scriptParentParent.Types)
if not require(scriptParentParent.Flags.FFlagCapturesInExpUseMomentsCreation) then
    local momentsCreationFlow = require(scriptParentParentParent.MomentsCreationFlow)
    local creationFlowState = momentsCreationFlow.Enums.CreationFlowState
    local selectedCaptureUpdated = momentsCreationFlow.Actions.SelectedCaptureUpdated
    local creationFlowStateUpdated = momentsCreationFlow.Actions.CreationFlowStateUpdated

    return function(arg1, str1: string)
        return function(arg2)
            arg2:dispatch(MomentsCreationFlowOpened(arg1, str1))
            arg2:dispatch(creationFlowStateUpdated(creationFlowState.Preview))
            arg2:dispatch(selectedCaptureUpdated(arg1))
        end
    end
end

return function(arg1, str1: string)
    return function(arg2)
        local constants = require(scriptParentParent.Constants)
        if arg2:getState()[constants.RoduxKey].MomentsCreationFlow.IsOpen then
            return
        end

        local momentsCreation = require(scriptParentParentParent.MomentsCreation)
        local creationFlowState = momentsCreation.Enums.CreationFlowState
        local creationFlowStore = momentsCreation.Stores.GetCreationFlowStore(false)

        momentsCreation.resetCreationFlow(creationFlowState.Preview)
        creationFlowStore.onSelectedCaptureUpdated(arg1)
        momentsCreation.beginCreationFlow("Captures")
        arg2:dispatch(MomentsCreationFlowOpened(arg1, str1))
    end
end
