-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:21:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)
local useLocalization = require(BuildExperienceParent.Localization).Hooks.useLocalization
local LocalizationStrings = require(BuildExperience.LocalizationStrings)
local Button = Foundation.Button
local FoundationText = Foundation.Text
local View = Foundation.View

local ButtonVariant = Foundation.Enums.ButtonVariant
local FillBehavior = Foundation.Enums.FillBehavior
local InputSize = Foundation.Enums.InputSize

local function VersionHistoryCard(tbl1)
    local testId = tbl1.testId or "version-history-card"
    local restore = useLocalization({
        autosaved = LocalizationStrings.VERSION_HISTORY_AUTOSAVED,
        previouslyPublished = LocalizationStrings.VERSION_HISTORY_PREVIOUSLY_PUBLISHED,
        published = LocalizationStrings.VERSION_HISTORY_PUBLISHED,
        restore = LocalizationStrings.VERSION_HISTORY_RESTORE
    }).restore
    local onActivated = React.useCallback(function()
        tbl1.onRestore()
    end, { tbl1.onRestore })

    return React.createElement(View, {
        LayoutOrder = tbl1.layoutOrder,
        tag = "size-full-0 auto-y stroke-standard stroke-default radius-large clip bg-surface-100",
        testId = testId
    }, {
        Content = React.createElement(
            View,
            {
                LayoutOrder = 1,
                tag = "col size-full-0 auto-y padding-x-large padding-bottom-large padding-top-medium"
            },
            {
                Header = React.createElement(View, {
                    LayoutOrder = 1,
                    tag = "col align-x-left align-y-top gap-xxsmall size-full-0 auto-y",
                    testId = `{testId}-header`
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
                Slot = React.createElement(View, {
                    LayoutOrder = 2,
                    tag = "col gap-large size-full-0 auto-y"
                }, {
                    Description = React.createElement(FoundationText, {
                        LayoutOrder = 1,
                        Text = tbl1.description,
                        tag = "size-full-0 auto-y text-body-small text-wrap text-align-x-left content-emphasis",
                        testId = `{testId}-description`
                    }),
                    RestoreRow = React.createElement(View, {
                        tag = "row size-full-0 auto-y",
                        LayoutOrder = 2
                    }, {
                        Restore = React.createElement(Button, {
                            text = restore,
                            size = InputSize.Small,
                            variant = ButtonVariant.Standard,
                            fillBehavior = FillBehavior.Fill,
                            isDisabled = tbl1.isRestoreDisabled,
                            onActivated = onActivated,
                            testId = `{testId}-restore`
                        })
                    })
                })
            }
        )
    })
end
return VersionHistoryCard
