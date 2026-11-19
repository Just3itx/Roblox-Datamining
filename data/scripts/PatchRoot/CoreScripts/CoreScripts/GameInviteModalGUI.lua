-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:31:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local VRService = game:GetService("VRService")
local RobloxGui = CoreGui:WaitForChild("RobloxGui")

local PlayerListManager = require(RobloxGui.Modules.PlayerList.PlayerListManager)
local MouseIconOverrideService = require(CorePackages.Workspace.Packages.CoreScriptsCommon).MouseIconOverrideService
local FFlagGameInviteModalUnlockMouse = require(CorePackages.Workspace.Packages.SharedFlags).FFlagGameInviteModalUnlockMouse
local GameInvite = require(CorePackages.Workspace.Packages.GameInvite)
local renderCoreScriptGameInviteModalContainer = GameInvite.renderCoreScriptGameInviteModalContainer
local GameInviteModalManager = GameInvite.GameInviteModalManager
renderCoreScriptGameInviteModalContainer((require(CoreGui.RobloxGui.Modules.ApolloClient)))

GameInviteModalManager.ToggleGameInviteModalEvent.Event:Connect(function(bool1: boolean)
    if bool1 then
        PlayerListManager:HideTemp("GameInviteMenu", true)
        if FFlagGameInviteModalUnlockMouse and UserInputService.MouseEnabled and not VRService.VREnabled then
            MouseIconOverrideService.push("GameInviteModal", Enum.OverrideMouseIconBehavior.ForceShow)
        end
    else
        PlayerListManager:HideTemp("GameInviteMenu", false)
        if FFlagGameInviteModalUnlockMouse then
            MouseIconOverrideService.pop("GameInviteModal")
        end
    end
end)
