-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:30:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local FFlagNewUpsellModalExperiment = require(scriptParentParentParent.Flags.FFlagNewUpsellModalExperiment)
local bool1 = game:DefineFastFlag("NewUpsellModalExperimentForPlatform", false)

return function()
    return FFlagNewUpsellModalExperiment or bool1
end
