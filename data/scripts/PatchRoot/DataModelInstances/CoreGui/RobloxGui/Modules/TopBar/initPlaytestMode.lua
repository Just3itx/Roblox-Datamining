-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:11:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")

local RobloxGui = CoreGui:WaitForChild("RobloxGui")

local GetPlaytestModeStore = require(CorePackages.Workspace.Packages.CoreScriptsRoactCommon.GetPlaytestModeStore)
local PlayerPermissionsModule = require(RobloxGui.Modules.PlayerPermissionsModule)

local function initPlaytestMode()
    local playtestModeStore = GetPlaytestModeStore(false)

    task.spawn(function()
        playtestModeStore.setHasEditAccess(PlayerPermissionsModule.CanPlayerManagePlaceAsync(Players.LocalPlayer))
    end)
end

return initPlaytestMode
