-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:31:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local React = require(BuildExperienceParent.React)

local AnimatedChipGroupView = require(script.Parent.AnimatedChipGroupView)
local useAnimatedChipGroupViewModel = require(script.Parent.useAnimatedChipGroupViewModel)

local function AnimatedChipGroupContainer(arg1)
    local var1 = useAnimatedChipGroupViewModel(arg1)
    return React.createElement(AnimatedChipGroupView, var1)
end

return AnimatedChipGroupContainer
