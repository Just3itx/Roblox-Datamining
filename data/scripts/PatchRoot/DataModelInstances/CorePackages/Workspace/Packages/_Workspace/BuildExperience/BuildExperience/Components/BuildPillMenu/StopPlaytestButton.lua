-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:30:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)

local IconButton = Foundation.IconButton

local ButtonVariant = Foundation.Enums.ButtonVariant
local IconName = Foundation.Enums.IconName
local InputSize = Foundation.Enums.InputSize

local function StopPlaytestButton(tbl1)
    return React.createElement(IconButton, {
        LayoutOrder = tbl1.layoutOrder,
        icon = IconName.StopSmall,
        isCircular = true,
        isDisabled = tbl1.isDisabled,
        onActivated = tbl1.onActivated,
        size = InputSize.Medium,
        testId = "build-header-stop-playtest-button",
        variant = ButtonVariant.Utility
    })
end

return StopPlaytestButton
