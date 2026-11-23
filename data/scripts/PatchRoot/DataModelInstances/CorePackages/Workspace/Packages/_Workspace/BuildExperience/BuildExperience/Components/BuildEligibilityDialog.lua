-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:21:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)
local useLocalization = require(BuildExperienceParent.Localization).Hooks.useLocalization
local LocalizationStrings = require(BuildExperience.LocalizationStrings)
local useBuildPageEligibility = require(BuildExperience.useBuildPageEligibility)

local ButtonVariant = Foundation.Enums.ButtonVariant
local Dialog = Foundation.Dialog
local DialogSize = Foundation.Enums.DialogSize

local function BuildEligibilityDialog(tbl1)
    local var1 = useLocalization({
        dialogAction = LocalizationStrings.BUILD_ELIGIBILITY_DIALOG_ACTION,
        errorDescription = LocalizationStrings.BUILD_ELIGIBILITY_ERROR_DESCRIPTION,
        errorTitle = LocalizationStrings.BUILD_ELIGIBILITY_ERROR_TITLE,
        ineligibleDescription = LocalizationStrings.BUILD_ELIGIBILITY_INELIGIBLE_DESCRIPTION,
        ineligibleTitle = LocalizationStrings.BUILD_ELIGIBILITY_INELIGIBLE_TITLE
    })
    local bool1 = tbl1.variant == useBuildPageEligibility.Status.Ineligible
    local text = if bool1 then var1.ineligibleTitle else var1.errorTitle
    local var3 = if bool1 then var1.ineligibleDescription else var1.errorDescription
    return React.createElement(Dialog.Root, {
        size = DialogSize.Small,
        testId = "build-eligibility-dialog"
    }, {
        Title = React.createElement(Dialog.Title, { LayoutOrder = 1, text = text }),
        Content = React.createElement(
            Dialog.Content,
            { LayoutOrder = 2 },
            {
                Description = React.createElement(Dialog.Text, { Text = var3 })
            }
        ),
        Actions = React.createElement(Dialog.Actions, {
            LayoutOrder = 3,
            actions = {{
                text = var1.dialogAction,
                variant = ButtonVariant.Emphasis,
                onActivated = tbl1.onDismiss
            }}
        })
    })
end

return BuildEligibilityDialog
