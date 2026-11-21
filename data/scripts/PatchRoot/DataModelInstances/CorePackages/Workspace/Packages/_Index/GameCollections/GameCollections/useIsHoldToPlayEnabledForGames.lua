-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T17:30:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameCollectionsParent = script:FindFirstAncestor("GameCollections").Parent

local useUserExperiment = require(GameCollectionsParent.RoactAppExperiment).useUserExperiment
local AppUserLayers = require(GameCollectionsParent.ExperimentLayers).AppUserLayers
local useUiModeInfo = require(GameCollectionsParent.RobloxAppHooks).useUiModeInfo
local UiMode = require(GameCollectionsParent.RobloxAppEnums).UiMode
local Responsive = require(GameCollectionsParent.Responsive)

local FFlagLuaAppResponsiveEnginePreferredInput = require(GameCollectionsParent.SharedFlags).FFlagLuaAppResponsiveEnginePreferredInput

local useAppPolicy = require(GameCollectionsParent.UniversalAppPolicy).useAppPolicy

local function useIsHoldToPlayEnabledForGames()
    local var1 = useUserExperiment({ AppUserLayers.PlatformExcellenceQualityImprovementConsoles }, function(arg1)
        return (arg1[AppUserLayers.PlatformExcellenceQualityImprovementConsoles] or {}).enableHoldToPlay
    end)

    local var2 = Responsive.useLastInput()

    local var3 = useUiModeInfo()

    local var4 = useAppPolicy(function(arg1)
        return arg1.getStickyShortcutBarEnabled()
    end)

    local var5 = if FFlagLuaAppResponsiveEnginePreferredInput then Responsive.usePreferredInput() else nil
    var1 = var1
        and (if FFlagLuaAppResponsiveEnginePreferredInput then var5 == Responsive.Input.Directional else var2 == Responsive.Input.Directional)
        and (var3.uiMode == UiMode.TenFoot or var4)

    return var1
end

return useIsHoldToPlayEnabledForGames
