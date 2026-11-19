-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:21:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local Modules = game:GetService("CoreGui").RobloxGui.Modules
local selfViewVisibilityUpdatedSignal = require(Modules.SelfView.selfViewVisibilityUpdatedSignal)

local getSelfViewIsOpenAndVisible = false
local module = {}

function module.getSelfViewIsOpenAndVisible()
    return getSelfViewIsOpenAndVisible
end

function module.setSelfViewIsOpenAndVisible(arg1)
    getSelfViewIsOpenAndVisible = arg1
    selfViewVisibilityUpdatedSignal:fire()
end

return module
