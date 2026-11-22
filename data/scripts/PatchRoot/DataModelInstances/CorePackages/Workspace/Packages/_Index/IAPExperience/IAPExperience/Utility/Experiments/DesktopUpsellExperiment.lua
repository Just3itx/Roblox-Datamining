-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:30:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent
local IXPServiceWrapper = require(scriptParentParentParentParent.IXPServiceWrapper).IXPServiceWrapper

local bool1 = game:DefineFastFlag("NewUpsellModalExperimentForDesktopV2", false)

local str1 = game:DefineFastString("DesktopUpsellIXPLayer", "Payments.Optimization.InExperienceUpsell.Desktop.UI")

local variants = { Control = 0, OpenRobuxStore = 1, OpenPaymentsPage = 2 }

local function getVariant() -- Luacid: Inlined by compiler; 1 call site recovered
    if not bool1 then
        return variants.Control
    end

    local layerData = IXPServiceWrapper:GetLayerData(str1)
    return if layerData and layerData.newUpsellModalVariant ~= nil then layerData.newUpsellModalVariant else variants.Control
end

local function logExposure() -- Luacid: Inlined by compiler; 1 call site recovered
    if not bool1 then
        return
    end
    IXPServiceWrapper:LogUserLayerExposure(str1)
end

return {
    variants = variants,
    getVariant = getVariant,
    logExposure = logExposure,
    shouldShowNewModal = function(): boolean
        logExposure()
        return getVariant() ~= variants.Control
    end
}
