-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T13:50:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FlyoutSidePanel = script:FindFirstAncestor("FlyoutSidePanel")

local FFlagFlyoutTradesEntryExposureLogging = require(FlyoutSidePanel.Flags.FFlagFlyoutTradesEntryExposureLogging)
local FStringFlyoutTradesEntryIxpLayer = require(FlyoutSidePanel.Flags.FStringFlyoutTradesEntryIxpLayer)

local function logFlyoutTradesEntryExposure(arg1)
    if not FFlagFlyoutTradesEntryExposureLogging then
        return
    end

    local var1 = FStringFlyoutTradesEntryIxpLayer
    if var1 == "" then
        return
    end

    if arg1 == nil then
        if not game:GetEngineFeature("EnableLogFlagLinkedUserLayerExposure") then
            return
        end
        arg1 = game:GetService("IXPService")
    end

    assert(arg1 ~= nil, "IXPService is required to log layer exposure")

    pcall(function()
        arg1:LogFlagLinkedUserLayerExposure(var1)
    end)
end

return logFlyoutTradesEntryExposure
