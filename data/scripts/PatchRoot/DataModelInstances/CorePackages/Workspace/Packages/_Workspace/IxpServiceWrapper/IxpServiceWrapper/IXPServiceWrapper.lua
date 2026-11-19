-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T12:30:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RunService = game:GetService("RunService")
local IXPService = game:GetService("IXPService")

local module = {}

function module.InitializeAsync(_, userId: number, userLayers)
    local success, result = pcall(function(): Enum.IXPLoadingStatus
        if RunService:IsStudio() then
            IXPService:ClearUserLayers()
        end
        IXPService:RegisterUserLayers(userLayers)
        IXPService:InitializeUserLayers(userId)
        local ixpLoadingStatus = IXPService:GetUserLayerLoadingStatus()
        while ixpLoadingStatus == Enum.IXPLoadingStatus.None or ixpLoadingStatus == Enum.IXPLoadingStatus.Pending do
            IXPService.OnUserLayerLoadingStatusChanged:Wait()
            ixpLoadingStatus = IXPService:GetUserLayerLoadingStatus()
        end

        return ixpLoadingStatus
    end)

    return success, result
end

function module.WaitForInitialization(_): Enum.IXPLoadingStatus
    local ixpLoadingStatus = IXPService:GetUserLayerLoadingStatus()
    while ixpLoadingStatus == Enum.IXPLoadingStatus.None or ixpLoadingStatus == Enum.IXPLoadingStatus.Pending do
        IXPService.OnUserLayerLoadingStatusChanged:Wait()
        ixpLoadingStatus = IXPService:GetUserLayerLoadingStatus()
    end

    return ixpLoadingStatus
end

function module.GetLayerData(_, layerName: string)
    local success, result = pcall(function()
        return IXPService:GetUserLayerVariables(layerName)
    end)

    return success and result or nil
end

function module.GetBTIDLayerData(_, layerName: string)
    local success, result = pcall(function()
        return IXPService:GetBrowserTrackerLayerVariables(layerName)
    end)

    return success and result or nil
end

function module.LogUserLayerExposure(_, layerName: string)
    pcall(function()
        IXPService:LogUserLayerExposure(layerName)
    end)
end

function module.LogBrowserTrackerLayerExposure(_, layerName: string)
    pcall(function()
        IXPService:LogBrowserTrackerLayerExposure(layerName)
    end)
end

function module.LogFlagLinkedUserLayerExposure(_, layerName: string)
    if game:GetEngineFeature("EnableLogFlagLinkedUserLayerExposure") then
        pcall(function()
            IXPService:LogFlagLinkedUserLayerExposure(layerName)
        end)
    end
end

return module
