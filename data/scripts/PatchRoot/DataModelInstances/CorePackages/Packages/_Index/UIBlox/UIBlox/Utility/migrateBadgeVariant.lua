-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:41:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent
local Foundation = require(scriptParentParentParent.Foundation)
local Flags = Foundation.Utility.Flags
local StatusIndicatorVariant = Foundation.Enums.StatusIndicatorVariant
local BadgeVariant = require(scriptParentParent.App.Indicator.Enum.BadgeVariant)

local function migrateBadgeVariantToStatusIndicatorVariant(alert)
    if Flags.FoundationStatusIndicatorVariantExperiment then
        if alert == BadgeVariant.Alert then
            return StatusIndicatorVariant.Alert
        end

        return StatusIndicatorVariant.Contrast_Experiment
    end

    return StatusIndicatorVariant.Emphasis
end

return migrateBadgeVariantToStatusIndicatorVariant
