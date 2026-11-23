-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:21:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)

local Button = Foundation.Button
local FoundationText = Foundation.Text
local View = Foundation.View

local ButtonVariant = Foundation.Enums.ButtonVariant
local FillBehavior = Foundation.Enums.FillBehavior
local IconName = Foundation.Enums.IconName
local InputSize = Foundation.Enums.InputSize

local function LatestVersionCardView(tbl1)
    local testId = tbl1.testId or "LatestVersionCardView"

    return React.createElement(View, {
        LayoutOrder = tbl1.layoutOrder,
        tag = "col gap-large size-full-0 auto-y padding-x-large padding-bottom-large padding-top-medium radius-large clip bg-shift-200",
        testId = testId
    }, {
        Content = React.createElement(
            View,
            {
                LayoutOrder = 1,
                tag = "col gap-xxsmall size-full-0 auto-y",
                testId = `{testId}-content`
            },
            {
                Eyebrow = React.createElement(View, {
                    LayoutOrder = 1,
                    tag = "col align-x-left align-y-top gap-xxsmall size-full-0 auto-y",
                    testId = `{testId}-eyebrow`
                }, {
                    Version = React.createElement(FoundationText, {
                        LayoutOrder = 1,
                        Text = tbl1.versionLabel,
                        tag = "size-full-0 auto-y text-caption-medium text-align-x-left content-muted",
                        testId = `{testId}-version`
                    }),
                    Title = React.createElement(FoundationText, {
                        LayoutOrder = 2,
                        Text = tbl1.title,
                        tag = "size-full-0 auto-y text-title-medium text-wrap text-align-x-left content-emphasis",
                        testId = `{testId}-title`
                    })
                }),
                Description = React.createElement(FoundationText, {
                    LayoutOrder = 2,
                    Text = tbl1.description,
                    tag = "size-full-0 auto-y text-body-small text-wrap text-align-x-left content-emphasis",
                    testId = `{testId}-description`
                })
            }
        ),
        Actions = React.createElement(
            View,
            {
                LayoutOrder = 2,
                tag = "row gap-small size-full-0 auto-y",
                testId = `{testId}-actions`
            },
            {
                Playtest = React.createElement(Button, {
                    LayoutOrder = 1,
                    text = tbl1.playtestText,
                    icon = IconName.PlaySmall,
                    size = InputSize.Small,
                    variant = ButtonVariant.SoftEmphasis,
                    fillBehavior = FillBehavior.Fill,
                    isDisabled = tbl1.isPlaytestDisabled,
                    onActivated = tbl1.onPlaytestActivated,
                    testId = `{testId}-playtest`
                }),
                Publish = React.createElement(Button, {
                    LayoutOrder = 2,
                    text = tbl1.publishText,
                    size = InputSize.Small,
                    variant = ButtonVariant.Standard,
                    fillBehavior = FillBehavior.Fill,
                    isDisabled = tbl1.isPublishDisabled,
                    onActivated = tbl1.onPublishActivated,
                    testId = `{testId}-publish`
                })
            }
        )
    })
end
return LatestVersionCardView
