-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:01:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local AppUserLayers = require(CorePackages.Workspace.Packages.ExperimentLayers).AppUserLayers

game:DefineFastString("ExitModalIXPLayer", AppUserLayers.ExperienceMenuExitModalLayer)

return function(): string
    return game:GetFastString("ExitModalIXPLayer")
end
