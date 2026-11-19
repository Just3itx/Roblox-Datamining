-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:50:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local isConnectDropdownEnabled = require(script.Parent.isConnectDropdownEnabled)
local GetFFlagIsSquadEnabled = require(CorePackages.Workspace.Packages.SharedFlags).GetFFlagIsSquadEnabled

return function()
    return isConnectDropdownEnabled() and GetFFlagIsSquadEnabled()
end
