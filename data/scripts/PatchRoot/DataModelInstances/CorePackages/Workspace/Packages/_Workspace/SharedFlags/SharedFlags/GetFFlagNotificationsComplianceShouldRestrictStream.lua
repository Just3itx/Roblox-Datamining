-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T16:40:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
game:DefineFastFlag("NotificationsComplianceShouldRestrictStream", false)

return function(): boolean
    return game:GetFastFlag("NotificationsComplianceShouldRestrictStream")
end
