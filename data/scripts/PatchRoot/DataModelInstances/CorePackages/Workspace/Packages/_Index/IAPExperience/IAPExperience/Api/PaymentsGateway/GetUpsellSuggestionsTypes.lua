-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T00:51:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _BadgeType = require(script.Parent.Parent.Parent.Enums.BadgeType)
local _VirtualItemBadgeType = require(script.Parent.Parent.Parent.Enums.VirtualItemBadgeType)

local ExperimentVariant = { PlusPromotion = "plusPromotion" }

return {
    ExperimentVariant = ExperimentVariant,
    normalizeExperimentVariant = function(plusPromotion): string?
        return if plusPromotion == ExperimentVariant.PlusPromotion then "plusPromotion" else nil
    end
}
