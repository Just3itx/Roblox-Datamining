-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T23:00:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InterventionShared = script:FindFirstAncestor("InterventionShared")
local InterventionSharedParent = InterventionShared.Parent

local InterventionPlacement = require(InterventionShared.Contexts.InterventionPlacement)
local React = require(InterventionSharedParent.React)

return function()
    return React.useContext(InterventionPlacement)
end
