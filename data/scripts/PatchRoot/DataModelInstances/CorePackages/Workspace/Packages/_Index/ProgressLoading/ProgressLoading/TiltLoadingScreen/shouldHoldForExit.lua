-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T12:40:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProgressLoadingParent = script:FindFirstAncestor("ProgressLoading").Parent

local FFlagTiltLoadingScreenEnterExitHold = require(ProgressLoadingParent.SharedFlags).FFlagTiltLoadingScreenEnterExitHold

local function shouldHoldForExit(bool1: boolean)
    return FFlagTiltLoadingScreenEnterExitHold and not bool1
end

return shouldHoldForExit
