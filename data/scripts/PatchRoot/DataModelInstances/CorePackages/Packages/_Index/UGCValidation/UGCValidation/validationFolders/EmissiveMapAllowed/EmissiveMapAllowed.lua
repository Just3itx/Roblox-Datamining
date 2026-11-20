-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:01:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)

local getFFlagUGCValidateEmissiveMapAllowed = require(scriptParentParentParent.flags.getFFlagUGCValidateEmissiveMapAllowed)
local getFFlagUGCValidateDecalBlockEmissives = require(scriptParentParentParent.flags.getFFlagUGCValidateDecalBlockEmissives)

local module = {
    categories = {
        ValidationEnums.UploadCategory.TORSO_AND_LIMBS,
        ValidationEnums.UploadCategory.DYNAMIC_HEAD,
        ValidationEnums.UploadCategory.LAYERED_CLOTHING,
        ValidationEnums.UploadCategory.EYEBROW_EYELASH,
        ValidationEnums.UploadCategory.RIGID_ACCESSORY,
        ValidationEnums.UploadCategory.MAKEUP
    },
    requiredData = { ValidationEnums.SharedDataMember.consumerConfig, ValidationEnums.SharedDataMember.rootInstance }
}

function module.fflag()
    return getFFlagUGCValidateEmissiveMapAllowed() or getFFlagUGCValidateDecalBlockEmissives()
end
module.expectedFailures = {}

local function hasEmissiveMask(arg1): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return arg1.EmissiveMaskContent.SourceType ~= Enum.ContentSourceType.None
end

local function isDecalEmissive(arg1): boolean
    local emissiveTint = arg1.EmissiveTint
    local bool1 = not not hasEmissiveMask(arg1)

    if not bool1 then
        if math.abs(arg1.EmissiveStrength - 1) > 0.00001
            or math.abs(emissiveTint.R - 1) > 0.00001
            or math.abs(emissiveTint.G - 1) > 0.00001
        then
            bool1 = true
        else
            bool1 = math.abs(emissiveTint.B - 1) > 0.00001
        end
    end

    return bool1
end

local function reportEmissiveDecals(arg1, descendants)
    for _, descendant in descendants do
        if not (descendant:IsA("Decal") and isDecalEmissive(descendant)) then
            continue
        end

        local emissiveMapNotAllowedOnDecal = ErrorSourceStrings.Keys.EmissiveMap_NotAllowedOnDecal
        local tbl1 = {
            InstancePath = descendant:GetFullName()
        }
        arg1:fail(emissiveMapNotAllowedOnDecal, tbl1)
    end
end

local function reportInExperienceEmissive(arg1, descendants, consumerConfig)
    if consumerConfig.consumerEnv ~= ValidationEnums.ConsumerEnv.IEC and consumerConfig.backendConfigs.universeId == nil then
        return
    end

    for _, descendant in descendants do
        if descendant:IsA("SurfaceAppearance") and hasEmissiveMask(descendant) then
            arg1:fail(ErrorSourceStrings.Keys.EmissiveMap_NotAllowedInExperience)
            return
        end
    end
end

function module.run(arg1, arg2)
    local rootInstance = arg2.rootInstance
    local descendants = rootInstance:GetDescendants()
    table.insert(descendants, rootInstance)

    if getFFlagUGCValidateDecalBlockEmissives() then
        reportEmissiveDecals(arg1, descendants)
    end
    if getFFlagUGCValidateEmissiveMapAllowed() then
        reportInExperienceEmissive(arg1, descendants, arg2.consumerConfig)
    end
end

return module
