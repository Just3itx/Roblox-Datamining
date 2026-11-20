-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:01:26Z
-- Luau bytecode version: 14 | Luau type version: 3
local CorePackages = game:GetService("CorePackages")

local isPioneerLaunch = require(CorePackages.Workspace.Packages.PioneerUtils).isPioneerLaunch

return game:DefineFastFlag("RemoveExitModal", false) or isPioneerLaunch()
