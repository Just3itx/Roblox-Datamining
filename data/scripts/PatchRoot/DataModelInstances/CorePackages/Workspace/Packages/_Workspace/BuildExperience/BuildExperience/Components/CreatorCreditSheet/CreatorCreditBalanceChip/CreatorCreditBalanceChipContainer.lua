-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:41:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local React = require(BuildExperienceParent.React)

local CreatorCreditBalanceChipView = require(script.Parent.CreatorCreditBalanceChipView)
local useCreatorCreditBalanceChipViewModel = require(script.Parent.useCreatorCreditBalanceChipViewModel)

local function CreatorCreditBalanceChipContainer()
    local var1 = useCreatorCreditBalanceChipViewModel()
    return React.createElement(CreatorCreditBalanceChipView, var1)
end

return CreatorCreditBalanceChipContainer
