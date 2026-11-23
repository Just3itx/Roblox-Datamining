-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:01:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)
local useAdCampaignCardViewModel = require(script.Parent.useAdCampaignCardViewModel)

local Button = Foundation.Button
local FoundationText = Foundation.Text
local View = Foundation.View
local InputSize = Foundation.Enums.InputSize

local function AdCampaignCard(arg1)
    local var1 = useAdCampaignCardViewModel(arg1)

    return React.createElement(View, {
        LayoutOrder = arg1.LayoutOrder,
        tag = "col gap-large size-full-0 auto-y padding-large stroke-standard stroke-default radius-large",
        testId = "AdCampaignCard"
    }, {
        Content = React.createElement(View, {
            LayoutOrder = 1,
            tag = "col gap-xxsmall size-full-0 auto-y"
        }, {
            Title = React.createElement(FoundationText, {
                LayoutOrder = 1,
                Text = var1.title,
                tag = "size-full-0 auto-y text-title-medium text-wrap text-align-x-left content-emphasis"
            }),
            Description = React.createElement(FoundationText, {
                LayoutOrder = 2,
                Text = var1.description,
                tag = "size-full-0 auto-y text-body-medium text-wrap text-align-x-left content-emphasis"
            })
        }),
        Action = React.createElement(Button, {
            LayoutOrder = 2,
            text = var1.actionText,
            size = InputSize.Small,
            variant = var1.buttonVariant,
            width = UDim.new(1, 0),
            isLoading = var1.isLoading,
            onActivated = var1.onActivated,
            testId = "AdCampaignCard.Primary"
        })
    })
end

return AdCampaignCard
