-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:40:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local _CorePackages = game:GetService("CorePackages")
local RobloxGui = CoreGui.RobloxGui
local FaceAnimatorService = game:GetService("FaceAnimatorService")
require(RobloxGui.Modules.VoiceChat.VoiceChatServiceManager).default.participantsUpdate.Event:Connect(function(arg1)
    for k, value in pairs(arg1) do
        local player = Players:GetPlayerByUserId(k)
        if player then
            player:SetAttribute("RBXAttentionVoiceIsActive", value.isSignalActive)
        end
    end
end)

local function setLocalPlayerVideoAnimationEnabled() -- Luacid: Inlined by compiler; 1 call site recovered
    local localPlayer = Players.LocalPlayer
    if localPlayer then
        localPlayer:SetAttribute("RBXAttentionVideoAnimationEnabled", FaceAnimatorService.VideoAnimationEnabled)
    end
end

setLocalPlayerVideoAnimationEnabled()
FaceAnimatorService:GetPropertyChangedSignal("VideoAnimationEnabled"):Connect(setLocalPlayerVideoAnimationEnabled)
