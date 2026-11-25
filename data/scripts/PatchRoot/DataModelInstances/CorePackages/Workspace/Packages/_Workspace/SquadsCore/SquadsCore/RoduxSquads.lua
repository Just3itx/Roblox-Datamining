-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T18:01:38Z
-- Luau bytecode version: 14 | Luau type version: 3
local SquadsCore = script:FindFirstAncestor("SquadsCore")
local SquadsCoreParent = SquadsCore.Parent

local RoduxSquads = require(SquadsCoreParent.RoduxSquads)

local RODUX_KEY = require(SquadsCore.Common.Constants).RODUX_KEY

return RoduxSquads.config({ keyPath = RODUX_KEY .. ".Squad" })
