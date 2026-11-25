-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T08:01:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")
local PurchasePromptParent = PurchasePrompt.Parent
local Players = game:GetService("Players")
local RobloxReplicatedStorage = game:GetService("RobloxReplicatedStorage")
local TeleportService = game:GetService("TeleportService")

local default = require(PurchasePromptParent.LoggingProtocol).default

local VIPServerPostPurchaseTelemetry = require(PurchasePrompt.Events.VIPServerPostPurchaseTelemetry)

local function teleportToVIPServer(str1: string, callback: (...any) -> (...any))
    local function fail(reason: string) -- Luacid: Inlined by compiler; 3 call sites recovered
        default:logRobloxTelemetryCounter(VIPServerPostPurchaseTelemetry.VIPServerTeleportFailedCounter, 1, { reason = reason })

        callback()
    end

    local teleportToPurchasedVipServer = RobloxReplicatedStorage:FindFirstChild("TeleportToPurchasedVIPServer")
    if teleportToPurchasedVipServer == nil or not teleportToPurchasedVipServer:IsA("RemoteEvent") then
        fail("no_remote")
        return function() end
    end

    local connection = nil
    local connection2 = nil
    local function disconnect() -- Luacid: Inlined by compiler; 2 call sites recovered
        connection:Disconnect()
        connection2:Disconnect()
    end

    connection = teleportToPurchasedVipServer.OnClientEvent:Connect(function()
        disconnect()
        fail("server")
    end)

    connection2 = TeleportService.TeleportInitFailed:Connect(function(player: Instance)
        if player == Players.LocalPlayer then
            disconnect()
            fail("teleport_init")
        end
    end)

    teleportToPurchasedVipServer:FireServer(str1)

    return disconnect
end

return teleportToVIPServer
