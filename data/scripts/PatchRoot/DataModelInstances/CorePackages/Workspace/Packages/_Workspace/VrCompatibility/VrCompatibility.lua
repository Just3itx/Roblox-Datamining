-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:41:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local VRReadyWrapper = require(script.VRReadyWrapper)
local RoundedCornersFrame = require(script.RoundedCornersFrame)
return {
    VRReadyWrapper = VRReadyWrapper,
    VRConstants = require(script.Constants),
    RoundedCornersFrame = RoundedCornersFrame,
    ["jest.config"] = script["jest.config"]
}
