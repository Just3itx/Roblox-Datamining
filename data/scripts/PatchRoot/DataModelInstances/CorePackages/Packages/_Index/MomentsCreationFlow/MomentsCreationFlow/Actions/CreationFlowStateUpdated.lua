-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T10:20:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreationFlow = script:FindFirstAncestor("MomentsCreationFlow")
local MomentsCreationFlowParent = MomentsCreationFlow.Parent

local Rodux = require(MomentsCreationFlowParent.Rodux)

local _CreationFlowState = require(MomentsCreationFlow.Enums.CreationFlowState)

return Rodux.makeActionCreator(script.Name, function(currentState)
    return { currentState = currentState }
end)
