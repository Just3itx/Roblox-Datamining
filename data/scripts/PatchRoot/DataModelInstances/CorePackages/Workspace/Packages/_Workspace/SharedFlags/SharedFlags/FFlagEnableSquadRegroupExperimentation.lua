-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T01:10:46Z
-- Luau bytecode version: 9 | Luau type version: 3
local FFlagForceEnableSquadRegroup = require(script.Parent.FFlagForceEnableSquadRegroup)
local bool1 = game:DefineFastFlag("EnableSquadRegroupExperimentation1", false)

local FFlagEnableSquadRegroupExperimentationSmallScreenFix = require(script.Parent.FFlagEnableSquadRegroupExperimentationSmallScreenFix)

return FFlagForceEnableSquadRegroup or bool1 or FFlagEnableSquadRegroupExperimentationSmallScreenFix
