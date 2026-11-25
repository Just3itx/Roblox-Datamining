-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T16:10:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent
local dependencies = require(scriptParentParentParentParent.dependencies)
local _AnalyticsTypes = require(script.Parent.Parent.AnalyticsTypes)

return dependencies.Rodux.makeActionCreator(script.Name, function(payload)
    return { payload = payload }
end)
