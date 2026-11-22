-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:01:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreation = script:FindFirstAncestor("MomentsCreation")
local MomentsCreationParent = MomentsCreation.Parent

local React = require(MomentsCreationParent.React)

local CreationControllerContext = require(MomentsCreation.CreationController.CreationControllerContext)
local _CreationFlowTypes = require(MomentsCreation.Types.CreationFlowTypes)

local function useCreationController()
    local var1 = React.useContext(CreationControllerContext)
    assert(var1 ~= nil, "useCreationController must be used within a CreationControllerProvider")
    return var1
end

return useCreationController
