-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T11:00:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExperienceLoadingScriptParent = script:FindFirstAncestor("ExperienceLoadingScript").Parent

local Rodux = require(ExperienceLoadingScriptParent.Rodux)
local ArgCheck = require(ExperienceLoadingScriptParent.ArgCheck)

return Rodux.makeActionCreator(script.Name, function(arg1)
    ArgCheck.isType(arg1, "table", "SetUniverseId action expects gameIds to be a table")
    return {
        universeId = arg1.universeId,
        placeId = arg1.placeId
    }
end)
