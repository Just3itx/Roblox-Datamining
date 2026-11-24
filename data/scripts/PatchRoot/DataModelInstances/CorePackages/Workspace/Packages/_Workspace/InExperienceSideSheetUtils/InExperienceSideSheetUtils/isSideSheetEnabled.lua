-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T21:51:01Z
-- Luau bytecode version: 14 | Luau type version: 3
local InExperienceSideSheetUtilsParent = script:FindFirstAncestor("InExperienceSideSheetUtils").Parent

local isPioneerLaunch = require(InExperienceSideSheetUtilsParent.PioneerUtils).isPioneerLaunch

return game:DefineFastFlag("EnableSideSheet8", false) or isPioneerLaunch()
