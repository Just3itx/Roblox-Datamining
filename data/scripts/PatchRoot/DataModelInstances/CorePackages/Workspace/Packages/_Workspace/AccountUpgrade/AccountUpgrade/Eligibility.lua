-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T04:40:52Z
-- Luau bytecode version: 14 | Luau type version: 3
local AccountUpgradeParent = script:FindFirstAncestor("AccountUpgrade").Parent

local AmpUpsell = require(AccountUpgradeParent.AmpUpsell)

local getAvailability = require(script.getAvailability)

return {
    AccessResponseEnum = AmpUpsell.AmpEnums.AccessResponseEnum,
    getAvailability = getAvailability
}
