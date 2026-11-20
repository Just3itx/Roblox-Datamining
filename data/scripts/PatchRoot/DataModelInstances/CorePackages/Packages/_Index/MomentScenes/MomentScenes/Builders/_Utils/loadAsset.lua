-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T10:01:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InsertService = game:GetService("InsertService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

return {
    loadAsset = function(assetId: number)
        if RunService:IsStudio() and RunService:IsClient() then
            local previewLoadAsset = ReplicatedStorage:FindFirstChild("PreviewLoadAsset")
            if previewLoadAsset ~= nil and previewLoadAsset:IsA("RemoteFunction") then
                local serverResult = previewLoadAsset:InvokeServer(assetId)

                if serverResult == nil or typeof(serverResult) ~= "Instance" then
                    error(`loadAsset: PreviewLoadAsset returned nil for {assetId}`)
                end
                local serverResultClone = serverResult:Clone()
                serverResult:Destroy()
                return serverResultClone
            end
        end
        return InsertService:LoadAsset(assetId)
    end,
    takePreviewResult = function(arg1, num1: number)
        if arg1 == nil or typeof(arg1) ~= "Instance" then
            error(`loadAsset: PreviewLoadAsset returned nil for {num1}`)
        end
        local argClone = arg1:Clone()
        arg1:Destroy()
        return argClone
    end,
    PREVIEW_REMOTE_NAME = "PreviewLoadAsset"
}
