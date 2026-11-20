-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T03:51:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local Icon = require(FoundationParent.BuilderIcons).Icon

local AlertSeverity = require(Foundation.Enums.AlertSeverity)

local _ButtonVariant = require(Foundation.Enums.ButtonVariant)

return {
    MAX_ACTION_COUNT = 3,
    SEVERITY_TO_ICON = {
        [AlertSeverity.Info] = Icon.CircleI,
        [AlertSeverity.Warning] = Icon.TriangleExclamation,
        [AlertSeverity.Success] = Icon.CircleCheck,
        [AlertSeverity.Error] = Icon.CircleX
    }
}
