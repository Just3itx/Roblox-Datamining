-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:20:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local React = require(BuildExperienceParent.React)

local StatsCardView = require(script.Parent.StatsCardView)
local useStatsCardViewModel = require(script.Parent.useStatsCardViewModel)

local function StatsCard(arg1)
    local var1 = useStatsCardViewModel(arg1)
    return React.createElement(StatsCardView, var1)
end

return StatsCard
