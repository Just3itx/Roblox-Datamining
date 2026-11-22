-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:21:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreation = script:FindFirstAncestor("MomentsCreation")
local MomentsCreationParent = MomentsCreation.Parent

local useLocalization = require(MomentsCreationParent.Localization).Hooks.useLocalization

local creationFlowStrings = require(MomentsCreation.creationFlowStrings)

local function useCreationFlowStrings()
    return useLocalization(creationFlowStrings)
end

return useCreationFlowStrings
