-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:51:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")

local function listenForTeleportFailure(callback: (...any) -> (...any))
    local localPlayer = Players.LocalPlayer
    local connection = nil
    local function disconnect() -- Luacid: Inlined by compiler; 1 call site recovered
        if connection ~= nil then
            connection:Disconnect()
            connection = nil
        end
    end

    connection = TeleportService.TeleportInitFailed:Connect(function(player: Instance)
        if player == localPlayer then
            disconnect()
            callback()
        end
    end)

    return disconnect
end

return listenForTeleportFailure
