-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:30:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommonParent = script:FindFirstAncestor("AuthCommon").Parent

local IXPServiceWrapper = require(AuthCommonParent.IXPServiceWrapper).IXPServiceWrapper
local AppBtidLayers = require(AuthCommonParent.ExperimentLayers).AppBtidLayers

local function enrolledInLuafiedRecoveryExperiment()
    local bTidLayerData = IXPServiceWrapper:GetBTIDLayerData(AppBtidLayers.AccountRecoveryUILayer)
    IXPServiceWrapper:LogBrowserTrackerLayerExposure(AppBtidLayers.AccountRecoveryUILayer)
    return if bTidLayerData then bTidLayerData.shouldShowLuafiedRecoveryFlow or false else false
end

return enrolledInLuafiedRecoveryExperiment
