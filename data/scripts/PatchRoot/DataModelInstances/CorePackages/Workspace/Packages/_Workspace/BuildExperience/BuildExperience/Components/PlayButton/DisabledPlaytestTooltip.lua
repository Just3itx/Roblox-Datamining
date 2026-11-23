-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:10:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)
local useLocalization = require(BuildExperienceParent.Localization).Hooks.useLocalization
local LocalizationStrings = require(BuildExperience.LocalizationStrings)

local EducationalTooltip = Foundation.EducationalTooltip

local PopoverAlign = Foundation.Enums.PopoverAlign
local PopoverSide = Foundation.Enums.PopoverSide

local function DisabledPlaytestTooltip(tbl1)
    local var1 = useLocalization({ text = LocalizationStrings.PLAYTEST_DISABLED_TOOLTIP, title = LocalizationStrings.PLAYTEST_TITLE })

    local text = var1.text
    local title = var1.title

    return React.createElement(EducationalTooltip, {
        LayoutOrder = tbl1.LayoutOrder,
        align = PopoverAlign.End,
        hasActions = false,
        hasSecondaryButtons = false,
        isOpen = tbl1.isOpen,
        onPressedOutside = tbl1.onPressedOutside,
        showSteps = false,
        side = PopoverSide.Bottom,
        text = text,
        testId = "build-disabled-playtest-tooltip",
        title = title
    }, tbl1.children)
end

return DisabledPlaytestTooltip
