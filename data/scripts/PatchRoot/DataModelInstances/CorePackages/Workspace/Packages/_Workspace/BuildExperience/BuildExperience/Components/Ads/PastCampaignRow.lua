-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:10:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local LocalizationService = game:GetService("LocalizationService")

local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)
local NumberLocalization = require(BuildExperienceParent.Localization).NumberLocalization
local noDataPlaceholder = require(BuildExperience.Components.Analytics.noDataPlaceholder)

local FoundationText = Foundation.Text
local View = Foundation.View

local function metricCell(layoutOrder: number, text: string, num1: number?, robloxLocaleId: string, testId: string)
    local createElement = React.createElement
    local var1 = View
    local tbl1 = { LayoutOrder = layoutOrder, tag = "col fill gap-xxsmall auto-y" }

    local tbl2 = {
        Label = React.createElement(
            FoundationText,
            {
                LayoutOrder = 1,
                Text = text,
                tag = "size-full-0 auto-y text-body-small text-align-x-left content-default"
            }
        ),
        Value = React.createElement(FoundationText, {
            LayoutOrder = 2,
            Text = if num1 ~= nil then NumberLocalization.localizeDecimal(num1, robloxLocaleId, 0) else noDataPlaceholder,
            tag = "size-full-0 auto-y text-heading-small text-align-x-left content-emphasis",
            testId = testId
        })
    }
    return createElement(var1, tbl1, tbl2)
end

local function PastCampaignRow(tbl1)
    local testId = tbl1.testId or "PastCampaignRow"
    local robloxLocaleId = LocalizationService.RobloxLocaleId

    return React.createElement(View, {
        LayoutOrder = tbl1.layoutOrder,
        tag = "col gap-small size-full-0 auto-y padding-large stroke-standard stroke-default radius-large",
        testId = testId
    }, {
        Date = React.createElement(FoundationText, {
            LayoutOrder = 1,
            Text = tbl1.dateText,
            tag = "size-full-0 auto-y text-title-small text-align-x-left content-emphasis",
            testId = `{testId}-date`
        }),
        Metrics = React.createElement(View, {
            LayoutOrder = 2,
            tag = "row gap-medium size-full-0 auto-y"
        }, {
            AdViews = metricCell(1, tbl1.labels.adViews, tbl1.adViews, robloxLocaleId, `{testId}-ad-views`),
            AdClicks = metricCell(2, tbl1.labels.adClicks, tbl1.adClicks, robloxLocaleId, `{testId}-ad-clicks`),
            GamePlays = metricCell(3, tbl1.labels.gamePlays, tbl1.gamePlays, robloxLocaleId, `{testId}-game-plays`)
        })
    })
end

return PastCampaignRow
