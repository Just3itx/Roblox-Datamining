-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:31:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local RobloxReplicatedStorage = game:GetService("RobloxReplicatedStorage")
local PlayerViewService = game:GetService("PlayerViewService")

local RobloxGui = CoreGui:WaitForChild("RobloxGui")
local timeOut = require(RobloxGui.Modules.Flags.GetFIntPlayerViewRemoteEventTimeout)()

local RequestDeviceCameraCFrame = RobloxReplicatedStorage:WaitForChild("RequestDeviceCameraCFrame", timeOut)

local ReplicateDeviceCameraCFrame = RobloxReplicatedStorage:WaitForChild("ReplicateDeviceCameraCFrame", timeOut)

local engineFeature = game:GetEngineFeature("PlayerViewRemoteEventSupport")

if not (RequestDeviceCameraCFrame and ReplicateDeviceCameraCFrame) then
    warn("PlayerViewService failed to initialize.")

    return
end

ReplicateDeviceCameraCFrame.OnClientEvent:Connect(function(player: Player?, cFrame: CFrame?, timestamp: number?)
    if engineFeature then
        PlayerViewService:UpdateDeviceCFrame(player, cFrame, timestamp)
    end
end)
RequestDeviceCameraCFrame.OnClientEvent:Connect(function()
    if engineFeature then
        PlayerViewService:OnCameraCFrameReplicationRequest()
    end
end)
