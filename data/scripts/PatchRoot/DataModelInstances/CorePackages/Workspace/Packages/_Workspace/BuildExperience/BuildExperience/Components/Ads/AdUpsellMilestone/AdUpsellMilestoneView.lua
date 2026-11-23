-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:01:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)

local AdUpsellCard = require(BuildExperience.Components.Ads.AdUpsellCard)
local FFlagBuildAgentAdCampaignCard = require(BuildExperience.Flags.FFlagBuildAgentAdCampaignCard)
local FFlagBuildExperienceChatCardEmphasis = require(BuildExperience.Flags.FFlagBuildExperienceChatCardEmphasis)
local FFlagBuildAdUpsellPinned = require(BuildExperience.Flags.FFlagBuildAdUpsellPinned)

local FoundationText = Foundation.Text
local View = Foundation.View

local function AdUpsellMilestoneView(tbl1)
    local createElement = React.createElement
    local var1 = View
    local tbl2 = {
        LayoutOrder = tbl1.order,
        tag = {
            ["size-full-0 auto-y"] = FFlagBuildAdUpsellPinned,
            ["col gap-xxlarge size-full-0 auto-y"] = not FFlagBuildAdUpsellPinned
        },
        testId = `AdUpsellMilestone.{tbl1.order}`
    }
    local tbl3 = {
        Congrats = if FFlagBuildAdUpsellPinned then nil else React.createElement(FoundationText, {
            LayoutOrder = 1,
            Text = tbl1.congratsText,
            tag = "size-full-0 auto-y text-body-medium text-wrap text-align-x-left content-emphasis",
            testId = `AdUpsellCongrats.{tbl1.order}`
        }),
        Card = React.createElement(AdUpsellCard, {
            LayoutOrder = if FFlagBuildAdUpsellPinned then 1 else 2,
            containerRef = tbl1.cardRef,
            isCreatePending = tbl1.isCreatePending,
            freePromotionsRemaining = if FFlagBuildAgentAdCampaignCard then tbl1.freePromotionsRemaining else nil,
            isCreateDisabled = tbl1.isCreateDisabled == true,
            onCreate = tbl1.onCreate,
            onDismiss = tbl1.onDismiss,
            emphasisOrder = if FFlagBuildExperienceChatCardEmphasis then tbl1.order else nil
        })
    }
    return createElement(var1, tbl2, tbl3)
end

return AdUpsellMilestoneView
