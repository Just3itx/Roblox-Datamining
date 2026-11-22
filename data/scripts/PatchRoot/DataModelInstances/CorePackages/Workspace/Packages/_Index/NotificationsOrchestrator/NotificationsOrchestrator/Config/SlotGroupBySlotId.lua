-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T08:31:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local NotificationsOrchestrator = script:FindFirstAncestor("NotificationsOrchestrator")
local SlotId = require(NotificationsOrchestrator.Enums.SlotId)
local SlotGroup = require(NotificationsOrchestrator.Enums.SlotGroup)

return {
    [SlotId.EducationTooltipOnHamburger] = SlotGroup.PopUps,
    [SlotId.EducationTooltipOnShopIcon] = SlotGroup.PopUps
}
