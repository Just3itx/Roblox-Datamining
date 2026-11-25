-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T18:01:11Z
-- Luau bytecode version: 14 | Luau type version: 3
local SquadsCore = script:FindFirstAncestor("SquadsCore")
local SquadsCoreParent = SquadsCore.Parent

local RODUX_KEY = require(SquadsCore.Common.Constants).RODUX_KEY

return (require(SquadsCoreParent.LuaSocialLibrariesDeps).RoduxPresence.config({ keyPath = RODUX_KEY .. ".Presence" }))
