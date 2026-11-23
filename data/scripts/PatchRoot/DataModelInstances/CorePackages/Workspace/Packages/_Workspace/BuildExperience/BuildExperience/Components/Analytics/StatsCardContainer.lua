-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:21:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local React = require(BuildExperienceParent.React)
local Foundation = require(BuildExperienceParent.Foundation)

local View = Foundation.View
local useBreakpoint = Foundation.Hooks.useBreakpoint

local StatsCard = require(script.Parent.StatsCard.StatsCard)
local getStatsCardColumns = require(script.Parent.getStatsCardColumns)

local function StatsCardContainer(tbl1)
    local var1, ref = React.useState(nil)

    local _, var3 = useBreakpoint(var1)
    local var4 = if var3.X > 0 then getStatsCardColumns(var3.X) else 2

    local cards = tbl1.cards
    local tbl2 = {}
    local var5 = #cards / var4

    for layoutOrder = 1, math.ceil(var5) do
        local tbl3 = ({})
        for i = 1, var4 do
            local card = cards[(layoutOrder - 1) * var4 + i]
            if card == nil then
                continue
            end

            local str1 = `Cell{i}`
            local createElement = React.createElement
            local var6 = View

            local tbl4 = {
                Card = React.createElement(StatsCard, card)
            }
            tbl3[str1] = createElement(var6, { LayoutOrder = i, tag = "fill auto-y" }, tbl4)
        end

        tbl2[`Row{layoutOrder}`] = React.createElement(View, { LayoutOrder = layoutOrder, tag = "row gap-medium size-full-0 auto-y" }, tbl3)
    end

    return React.createElement(View, {
        LayoutOrder = tbl1.layoutOrder,
        tag = "col gap-medium size-full-0 auto-y",
        testId = tbl1.testId or "StatsCardContainer",
        ref = ref
    }, tbl2)
end

return StatsCardContainer
