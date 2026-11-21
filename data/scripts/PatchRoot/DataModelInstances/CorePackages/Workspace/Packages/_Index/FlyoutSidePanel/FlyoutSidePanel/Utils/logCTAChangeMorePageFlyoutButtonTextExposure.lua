-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T13:50:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FlyoutSidePanel = script:FindFirstAncestor("FlyoutSidePanel")
local FlyoutSidePanelParent = FlyoutSidePanel.Parent

local FFlagCTAChangeMorePageFlyoutButtonTextIxpEnabled = require(FlyoutSidePanelParent.SharedFlags).FFlagCTAChangeMorePageFlyoutButtonTextIxpEnabled

local FStringCTAChangeMorePageFlyoutButtonTextIxpLayer = require(FlyoutSidePanel.Flags.FStringCTAChangeMorePageFlyoutButtonTextIxpLayer)

local function logCTAChangeMorePageFlyoutButtonTextExposure(arg1)
    if not FFlagCTAChangeMorePageFlyoutButtonTextIxpEnabled then
        return
    end

    local var1 = FStringCTAChangeMorePageFlyoutButtonTextIxpLayer
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

return logCTAChangeMorePageFlyoutButtonTextExposure
