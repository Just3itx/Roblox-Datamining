-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:31:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreation = script:FindFirstAncestor("MomentsCreation")

local GetFIntMomentsTTSStartTimeMinTailSeconds = require(MomentsCreation.Flags.GetFIntMomentsTTSStartTimeMinTailSeconds)

local function clampTtsStartTime(num1: number, num2: number): number
    return math.clamp(num1, 0, math.max(0, num2 - GetFIntMomentsTTSStartTimeMinTailSeconds()))
end

return clampTtsStartTime
