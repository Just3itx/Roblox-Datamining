-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:31:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function logMomentsLayerExposure(str1: string, arg1)
    if str1 == "" then
        return
    end

    local var1 = arg1
    if var1 == nil then
        if not game:GetEngineFeature("EnableLogFlagLinkedUserLayerExposure") then
            return
        end
        var1 = game:GetService("IXPService")
    end

    pcall(function()
        var1:LogFlagLinkedUserLayerExposure(str1)
    end)
end

return logMomentsLayerExposure
