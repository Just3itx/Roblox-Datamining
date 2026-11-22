-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:21:27Z
-- Luau bytecode version: 14 | Luau type version: 3
local MomentsCommonParent = script:FindFirstAncestor("MomentsCommon").Parent

local getCovering, setCovering = require(MomentsCommonParent.Signals).createSignal(false)

return { getCovering = getCovering, setCovering = setCovering }
