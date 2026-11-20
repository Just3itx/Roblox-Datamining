-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:51:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local makeActionCreator = require(CorePackages.Packages.Rodux).makeActionCreator

if require(CorePackages.Workspace.Packages.CoreGuiCommon).Flags.FFlagTopBarSignalizeScreenSize then
    return nil
end

return (makeActionCreator(script.Name, function(screenSize)
    return { screenSize = screenSize }
end))
