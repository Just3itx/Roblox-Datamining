-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:01:01Z
-- Luau bytecode version: 14 | Luau type version: 3
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local getCovering, setCovering = require(MomentsParent.Signals).createSignal(false)

return { getCovering = getCovering, setCovering = setCovering }
