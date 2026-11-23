-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:20:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local React = require(BuildExperienceParent.React)
local View = require(BuildExperienceParent.Foundation).View

local InstantStatCard = require(script.Parent.InstantStatCard)

local function InstantStatsRow(tbl1)
    local tbl2 = ({})
    for layoutOrder, stat in tbl1.stats do
        local str1 = `Cell{layoutOrder}`
        local createElement = React.createElement
        local var1 = View

        local tbl3 = {
            Card = React.createElement(
                InstantStatCard,
                {
                    label = stat.label,
                    valueText = stat.valueText,
                    icon = stat.icon,
                    isLoading = stat.isLoading,
                    testId = stat.testId
                }
            )
        }
        tbl2[str1] = createElement(var1, { LayoutOrder = layoutOrder, tag = "fill auto-y" }, tbl3)
    end

    return React.createElement(
        View,
        {
            LayoutOrder = tbl1.layoutOrder,
            tag = "row gap-medium size-full-0 auto-y",
            testId = tbl1.testId or "InstantStatsRow"
        },
        tbl2
    )
end

return InstantStatsRow
