-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T22:51:20Z
-- Luau bytecode version: 14 | Luau type version: 3
local InterventionShared = script:FindFirstAncestor("InterventionShared")
local InterventionSharedParent = InterventionShared.Parent

local Constants = require(InterventionShared.Utils.Constants)
return (require(InterventionSharedParent.React).createContext(Constants.InterventionPlacementType.Unknown))
