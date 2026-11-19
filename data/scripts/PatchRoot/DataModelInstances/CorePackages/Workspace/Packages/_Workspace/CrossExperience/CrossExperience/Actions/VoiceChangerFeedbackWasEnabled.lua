-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T12:00:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CrossExperience = script:FindFirstAncestor("CrossExperience")
local dependencies = require(CrossExperience.dependencies)
local _Types = require(CrossExperience.Types)

return dependencies.Rodux.makeActionCreator(script.Name, function(payload)
    return { payload = payload }
end)
