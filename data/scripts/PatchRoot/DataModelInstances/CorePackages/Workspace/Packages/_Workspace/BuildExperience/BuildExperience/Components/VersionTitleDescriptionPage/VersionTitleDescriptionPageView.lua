-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:21:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)
local useLocalization = require(BuildExperienceParent.Localization).Hooks.useLocalization
local LocalizationStrings = require(BuildExperience.LocalizationStrings)
local IconButton = Foundation.IconButton
local FoundationText = Foundation.Text
local TextArea = Foundation.TextArea
local TextInput = Foundation.TextInput
local View = Foundation.View

local ButtonVariant = Foundation.Enums.ButtonVariant
local IconName = Foundation.Enums.IconName
local InputSize = Foundation.Enums.InputSize

local function VersionTitleDescriptionPageView(tbl1)
    local var1 = useLocalization({
        descriptionLabel = LocalizationStrings.TITLE_DESCRIPTION_DESCRIPTION_LABEL,
        titleLabel = LocalizationStrings.TITLE_DESCRIPTION_TITLE_LABEL,
        versionTitleDescription = LocalizationStrings.PUBLISH_VERSION_TITLE_DESCRIPTION
    })
    local descriptionLabel = var1.descriptionLabel
    local titleLabel = var1.titleLabel
    local versionTitleDescription = var1.versionTitleDescription

    if not tbl1.isReady then
        return nil
    end

    local testId = tbl1.testId or "version-title-description-page"
    return React.createElement(View, {
        LayoutOrder = tbl1.layoutOrder,
        tag = {
            ["composition-layout-detail"] = true,
            ["col align-x-center size-full bg-surface-0"] = true
        },
        testId = testId
    }, {
        Header = React.createElement(View, {
            LayoutOrder = 1,
            tag = "composition-content-header row align-y-center gap-small size-full-0 auto-y padding-y-medium",
            testId = `{testId}-header`
        }, {
            Back = React.createElement(IconButton, {
                LayoutOrder = 1,
                icon = IconName.ArrowLargeLeft,
                isCircular = true,
                onActivated = tbl1.onBack,
                size = InputSize.Medium,
                variant = ButtonVariant.Utility,
                testId = `{testId}-back`
            }),
            Title = React.createElement(FoundationText, {
                LayoutOrder = 2,
                Text = versionTitleDescription,
                tag = "fill auto-y text-heading-medium text-align-x-left text-truncate-end content-emphasis",
                testId = `{testId}-title`
            })
        }),
        Content = React.createElement(View, {
            LayoutOrder = 2,
            tag = "composition-content-body col gap-xlarge size-full-0 auto-y padding-y-large",
            testId = `{testId}-content-body`
        }, {
            TitleInput = React.createElement(TextInput, {
                LayoutOrder = 1,
                label = titleLabel,
                text = tbl1.titleText,
                width = UDim.new(1, 0),
                onChanged = tbl1.onTitleChanged,
                onFocusLost = tbl1.onFocusLost,
                testId = `{testId}-title-input`
            }),
            DescriptionInput = React.createElement(TextArea, {
                LayoutOrder = 2,
                label = descriptionLabel,
                text = tbl1.descriptionText,
                width = UDim.new(1, 0),
                numLines = 4,
                onChanged = tbl1.onDescriptionChanged,
                onFocusLost = tbl1.onFocusLost,
                testId = `{testId}-description-input`
            })
        })
    })
end

return VersionTitleDescriptionPageView
