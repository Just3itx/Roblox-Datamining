-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T00:21:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local IXPService = game:GetService("IXPService")

return {
    getIxpLayerData = function(layerName: string)
        local success, result = pcall(function()
            return IXPService:GetUserLayerVariables(layerName)
        end)

        return success and result or nil
    end,
    logUserLayerExposure = function(layerName: string)
        pcall(function()
            IXPService:LogUserLayerExposure(layerName)
        end)
    end
}
