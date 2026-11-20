-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:31:02Z
-- Luau bytecode version: 14 | Luau type version: 3
local RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")

return {
    selfViewVisibilityUpdatedSignal = require(RobloxGui.Modules.SelfView.selfViewVisibilityUpdatedSignal),
    getSelfViewVisibility = require(RobloxGui.Modules.SelfView.publicApi).getSelfViewIsOpenAndVisible
}
