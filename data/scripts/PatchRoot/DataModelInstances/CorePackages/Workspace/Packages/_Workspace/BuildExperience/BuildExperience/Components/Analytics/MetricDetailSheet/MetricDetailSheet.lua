-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:20:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local React = require(BuildExperienceParent.React)

local MetricDetailSheetView = require(script.Parent.MetricDetailSheetView)
local useMetricDetailSheetViewModel = require(script.Parent.useMetricDetailSheetViewModel)

local function MetricDetailSheet(arg1)
    local var1 = useMetricDetailSheetViewModel(arg1)
    return React.createElement(MetricDetailSheetView, var1)
end

return MetricDetailSheet
