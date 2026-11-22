-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:21:08Z
-- Luau bytecode version: 14 | Luau type version: 3
local MomentsCommonParent = script:FindFirstAncestor("MomentsCommon").Parent

local getSuspended, setSuspended = require(MomentsCommonParent.Signals).createSignal(false)

return { getSuspended = getSuspended, setSuspended = setSuspended }
