-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T18:31:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local RobloxReplicatedStorage = game:GetService("RobloxReplicatedStorage")

local SwitchServer = script:FindFirstAncestor("SwitchServer")
local SwitchServerParent = SwitchServer.Parent

local CoreScriptsCommon = require(SwitchServerParent.CoreScriptsCommon)
local Signals = require(SwitchServerParent.Signals)

local SwitchServerTelemetry = require(SwitchServer.Telemetry.SwitchServerTelemetry)

local STANDARD_SERVER = CoreScriptsCommon.Constants.STANDARD_SERVER

local function fetchAndUpdateShouldSwitchServer(callback: (...any) -> (...any)) -- Luacid: Inlined by compiler; 1 call site recovered
    task.spawn(function()
        if RunService:IsStudio() or not game:GetEngineFeature("GameIdToExcludeAvailable") or Players.MaxPlayers == 1 then
            return
        end

        local getServerType = RobloxReplicatedStorage:WaitForChild("GetServerType", 2)
        if not getServerType then
            return
        end

        local success, result = pcall(function()
            return getServerType:InvokeServer()
        end)
        if success then
            local bool1 = result == STANDARD_SERVER
            callback(bool1)
        end
    end)
end

local function createSwitchServerStore()
    local shouldEnableSwitchServer, var2 = Signals.createSignal(false)
    fetchAndUpdateShouldSwitchServer(var2)
    local isConfirmationOpen, var4 = Signals.createSignal(false)
    return {
        shouldEnableSwitchServer = shouldEnableSwitchServer,
        isConfirmationOpen = isConfirmationOpen,
        setConfirmationOpen = function(bool1: boolean)
            if bool1 then
                SwitchServerTelemetry.sendSwitchServerButtonActions({ event_type = "click" })
            end

            var4(bool1)
        end
    }
end
return createSwitchServerStore
