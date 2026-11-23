-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:01:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local React = require(BuildExperienceParent.React)

local AdUpsellMilestoneView = require(script.Parent.AdUpsellMilestoneView)
local useAdUpsellMilestoneViewModel = require(script.Parent.useAdUpsellMilestoneViewModel)

local function AdUpsellMilestoneContainer(arg1)
    local var1 = useAdUpsellMilestoneViewModel(arg1)
    return React.createElement(AdUpsellMilestoneView, var1)
end

return AdUpsellMilestoneContainer
