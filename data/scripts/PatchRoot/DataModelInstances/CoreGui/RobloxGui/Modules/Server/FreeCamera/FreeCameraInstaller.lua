-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:31:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local bool1 = game:DefineFastFlag("AllowLuobuFreecamGroup", false)
local engineFeature = game:DefineFastFlag("FreeCameraToIAS", false) and game:GetEngineFeature("PlayerScriptStatusProperty")

local tbl1 = { 4358041 }

local tbl2 = { 7842878 }

local Players = game:GetService("Players")
local PolicyService = game:GetService("PolicyService")
local RunService = game:GetService("RunService")
local StarterPlayer = game:GetService("StarterPlayer")
local RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")

local ServerUtil = require(RobloxGui.Modules.Server.ServerUtil)

local function Install()
    local function WaitForChildOfClass(player: Player, className: string): Instance?
        local child = player:FindFirstChildOfClass(className)
        while not child or child.ClassName ~= className do
            child = player.ChildAdded:Wait()
        end
        return child
    end

    local function AddFreeCamera(player: Player)
        local child = WaitForChildOfClass(player, "PlayerGui")
        local freeCamera

        if engineFeature then
            local playerModuleStatus = StarterPlayer.PlayerModuleStatus
            freeCamera = script.Parent:WaitForChild(if playerModuleStatus == 1 or playerModuleStatus == 2 then "FreeCameraIAS" else "FreeCamera")
        else
            freeCamera = script.Parent:WaitForChild("FreeCamera")
        end

        local freecam = Instance.new("ScreenGui")
        freecam.Name = "Freecam"
        freecam.ResetOnSpawn = false

        local freecamScript = Instance.new("LocalScript")
        freecamScript.Name = "FreecamScript"
        if ServerUtil.getFFlagServerCoreScriptSourceCode() then
            freecamScript.Source = ServerUtil.getSourceForServerScript(freeCamera)
        else
            freecamScript.Source = freeCamera.Source
        end
        freecamScript.Parent = freecam

        freecam.Parent = child
    end

    local function ShouldAddFreeCam(player: Player)
        if RunService:IsStudio() then
            return true
        end
        if player.UserId <= 0 then
            return false
        end

        local success, result = pcall(player.GetCanManageAsync, player)

        if success and result then
            return true
        end

        for _, value in ipairs(tbl1) do
            local success2, result2 = pcall(player.IsInGroup, player, value)
            if success2 and result2 then
                return true
            end
        end

        if bool1 and game:GetEngineFeature("LuobuModerationStatus") and PolicyService.IsLuobuServer == Enum.TriStateBoolean.True then
            for _, value in ipairs(tbl2) do
                local success2, result2 = pcall(player.IsInGroup, player, value)
                if success2 and result2 then
                    return true
                end
            end
        end

        return false
    end

    local function PlayerAdded(player: Player)
        if ShouldAddFreeCam(player) then
            AddFreeCamera(player)
        end
    end

    Players.PlayerAdded:Connect(PlayerAdded)
    for _, player in ipairs(Players:GetPlayers()) do
        coroutine.wrap(PlayerAdded)(player)
    end
end

return Install
