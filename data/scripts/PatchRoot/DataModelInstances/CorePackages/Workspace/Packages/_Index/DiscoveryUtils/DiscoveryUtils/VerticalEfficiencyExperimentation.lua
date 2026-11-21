-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T11:11:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DiscoveryUtilsParent = script:FindFirstAncestor("DiscoveryUtils").Parent
local ExperimentCacheManager = require(DiscoveryUtilsParent.ExperimentCacheManager).ExperimentCacheManager

local str1 = game:DefineFastString("LuaAppVerticalEfficiencyExpLayer", "PlayerApp.HomePage.UX")

local function getIsUserInTreatmentAndSendExposureLog(str2: string) -- Luacid: Inlined by compiler; 2 call sites recovered
    local str3 = str1
    local layerVariables = ExperimentCacheManager.default:getLayerVariables(str3, true)

    if not layerVariables or layerVariables[str2] == nil then
        return false
    end

    ExperimentCacheManager.default:sendCustomExposureLog(str3)
    return layerVariables[str2]
end

return {
    getIsProfileMovedToTopBar = function()
        return getIsUserInTreatmentAndSendExposureLog("IsProfileMovedToTopBar")
    end,
    getIsRobloxLogoHeaderEnabled = function()
        return getIsUserInTreatmentAndSendExposureLog("IsRobloxLogoHeaderEnabled")
    end
}
