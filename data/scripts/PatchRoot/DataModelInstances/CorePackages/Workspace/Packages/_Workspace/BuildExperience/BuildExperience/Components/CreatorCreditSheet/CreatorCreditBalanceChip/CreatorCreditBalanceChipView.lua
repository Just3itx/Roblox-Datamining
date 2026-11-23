-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:41:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)

local Chip = Foundation.Chip

local ChipSize = Foundation.Enums.ChipSize
local ChipVariant = Foundation.Enums.ChipVariant
local IconName = Foundation.Enums.IconName

local function CreatorCreditBalanceChipView(tbl1)
    if tbl1.balanceText == nil then
        return nil
    end
    return React.createElement(Chip, {
        text = tbl1.balanceText,
        leading = IconName.Robux,
        variant = ChipVariant.Standard,
        size = ChipSize.Medium,
        onActivated = tbl1.onActivated,
        testId = "creator-credit-balance-chip"
    })
end

return CreatorCreditBalanceChipView
