-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:10:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local React = require(BuildExperienceParent.React)
local View = require(BuildExperienceParent.Foundation).View

local PastCampaignRow = require(script.Parent.PastCampaignRow)

local function PastCampaignsList(tbl1)
    local testId = tbl1.testId or "PastCampaignsList"

    local tbl2 = {}
    for layoutOrder, row in tbl1.rows do
        local var1 = table.clone(row)
        var1.layoutOrder = layoutOrder
        tbl2[`Row{layoutOrder}`] = React.createElement(PastCampaignRow, var1)
    end

    return React.createElement(
        View,
        {
            LayoutOrder = tbl1.layoutOrder,
            tag = "col gap-small size-full-0 auto-y",
            testId = testId
        },
        tbl2
    )
end

return PastCampaignsList
