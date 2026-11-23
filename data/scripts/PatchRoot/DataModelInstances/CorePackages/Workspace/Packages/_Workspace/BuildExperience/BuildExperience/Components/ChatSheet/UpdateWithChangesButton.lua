-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:41:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)
local useLocalization = require(BuildExperienceParent.Localization).Hooks.useLocalization
local LocalizationStrings = require(BuildExperience.LocalizationStrings)

local Button = Foundation.Button

local ButtonVariant = Foundation.Enums.ButtonVariant
local InputSize = Foundation.Enums.InputSize

local function UpdateWithChangesButton(tbl1)
    local var1 = useLocalization({ updateWithChanges = LocalizationStrings.CHAT_UPDATE_WITH_CHANGES })

    return React.createElement(Button, {
        text = var1.updateWithChanges,
        size = InputSize.Medium,
        variant = ButtonVariant.Emphasis,
        width = UDim.new(1, 0),
        onActivated = tbl1.onActivated,
        LayoutOrder = tbl1.LayoutOrder
    })
end

return UpdateWithChangesButton
