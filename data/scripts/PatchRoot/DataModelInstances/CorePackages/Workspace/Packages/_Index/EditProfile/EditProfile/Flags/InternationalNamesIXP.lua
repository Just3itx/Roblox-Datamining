-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T12:10:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
game:DefineFastFlag("InternationalNamesEnabledForAll", false)

local layerName = game:DefineFastString("InternationalNamesIXPLayer", "Social.InternationalDisplayName")

local str1 = game:DefineFastString("InternationalNamesIXPExperimentDefinition", "enableInternationalNames")

local IXPService = game:GetService("IXPService")

local EditProfileParent = script:FindFirstAncestor("EditProfile").Parent
local useUserExperiment = require(EditProfileParent.RoactAppExperiment).useUserExperiment

local function internationalNamesEnabledForAll(): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return game:GetFastFlag("InternationalNamesEnabledForAll")
end

local function isExperimentEnabled(arg1): boolean
    return ((arg1 or {})[layerName] or {})[str1] == true or internationalNamesEnabledForAll()
end

return {
    FFlagIsExperimentEnabled = isExperimentEnabled,
    useIsExperimentEnabled = function(tbl1)
        return useUserExperiment({ layerName }, isExperimentEnabled, (tbl1 or { isExposureEnabled = false }).isExposureEnabled)
    end,
    logExposure = function()
        IXPService:LogUserLayerExposure(layerName)
    end
}
