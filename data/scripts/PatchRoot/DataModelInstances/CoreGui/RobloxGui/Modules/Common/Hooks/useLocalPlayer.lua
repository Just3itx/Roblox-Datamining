-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:00:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Players = game:GetService("Players")
local useProperty = require(CorePackages.Workspace.Packages.GuiObjectUtils).useProperty

local function useLocalPlayer()
    return useProperty(Players, "LocalPlayer")
end

return useLocalPlayer
