-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:40:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local getDeepValue = require(scriptParentParent.dependencies).SocialLibraries.Dictionary.getDeepValue
local RODUX_KEY = require(scriptParentParent.Common.Constants).RODUX_KEY

return function(arg1)
    return getDeepValue(arg1, RODUX_KEY .. ".ShowContactImporterParams") or {}
end
