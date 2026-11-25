-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:51:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SharedExperimentDefinitionParent = script:FindFirstAncestor("SharedExperimentDefinition").Parent
local ExperimentCacheManager = require(SharedExperimentDefinitionParent.ExperimentCacheManager).ExperimentCacheManager

local str1 = game:DefineFastString("LuaAppIECVRLayerName", "PlatformExcellence.VR.SpatialUI")
local str2 = game:DefineFastString("LuaAppIECVRVariantKey", "spatial_ui_type")
local num1 = game:DefineFastInt("LuaAppIECVRVariantNoSpatialUI", 0)
local num2 = game:DefineFastInt("LuaAppIECVRVariantSpatialUIWithDragging", 1)
local num3 = game:DefineFastInt("LuaAppIECVRVariantSpatialUIWithoutDragging", 2)

local num4 = game:DefineFastInt("LuaAppIECVRVariantSpatialUIMovePanelToCenter", 3)

local bool1 = game:DefineFastFlag("LuaAppIECVRIxpEnabled8", false)

local FFlagEnableUIManagerPackgify = require(SharedExperimentDefinitionParent.SharedFlags).FFlagEnableUIManagerPackgify

local isSpatialUIScalingFixEnabled = game:DefineFastFlag("EnableSpatialUIScalingFix", false)
local isSpatialUICameraTypeFixEnabled = game:DefineFastFlag("EnableSpatialUICameraTypeFix8", false)

local bool4 = game:DefineFastFlag("LuaAppIECVREnabled8", false)
local bool5 = game:DefineFastFlag("SpatialUIEnableDrag8", false)
local bool6 = game:DefineFastFlag("SpatialUIEnableMovePanelToCenter8", false)
local bool7 = game:DefineFastFlag("EnableSpatialUIPlaceFilter", false)

local tbl1 = {}

tbl1.__index = tbl1

function tbl1.new()
    local tbl2 = { _layer_data = nil }

    setmetatable(tbl2, tbl1)
    return tbl2
end

function tbl1:getIXPVariant()
    if self._layer_data == nil then
        self._layer_data = ExperimentCacheManager.default:getLayerVariables(str1) or {}
    end
    local var1 = self._layer_data[str2] or nil
    if var1 == nil then
        return num1
    end
    return tonumber(var1)
end

function tbl1.isDependencyFlagsEnabled()
    return FFlagEnableUIManagerPackgify and not bool7
end

function tbl1.isInExperienceUIVREnabled(arg1): boolean
    return if arg1:isDependencyFlagsEnabled() then if bool4 then true elseif bool1 then arg1:getIXPVariant() ~= num1 else false else false
end

function tbl1.isDraggingAllowed(arg1)
    if not arg1:isInExperienceUIVREnabled() then
        return false
    end
    if bool5 then
        return not bool6
    end
    if bool6 then
        return false
    end

    local iXpVariant = arg1:getIXPVariant()
    return iXpVariant == num2 or not (iXpVariant == num3) and not (iXpVariant == num4) and bool5
end

function tbl1.isMovePanelToCenter(arg1): boolean
    return if arg1:isInExperienceUIVREnabled() then if bool6 then true else arg1:getIXPVariant() == num4 else false
end

function tbl1.isSpatialUICameraTypeFixEnabled(_)
    return isSpatialUICameraTypeFixEnabled
end

function tbl1.isSpatialUIScalingFixEnabled(_)
    return isSpatialUIScalingFixEnabled
end

return (tbl1.new())
