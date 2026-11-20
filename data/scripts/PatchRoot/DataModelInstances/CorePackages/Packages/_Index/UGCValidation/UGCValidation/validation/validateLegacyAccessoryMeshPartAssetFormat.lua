-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:41:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local _Types = require(scriptParentParent.util.Types)

local createLegacyAccessoryMeshPartAssetFormatSchema = require(scriptParentParent.util.createLegacyAccessoryMeshPartAssetFormatSchema)

local validateSingleInstance = require(scriptParentParent.validation.validateSingleInstance)
local validateInstanceTree = require(scriptParentParent.validation.validateInstanceTree)

local validateLegacyAccessoryMeshPartAssetFormatMatch = require(scriptParentParent.validation.validateLegacyAccessoryMeshPartAssetFormatMatch)
local ValidatePropertiesSensible = require(scriptParentParent.validation.ValidatePropertiesSensible)

local getEngineFeatureEngineUGCValidatePropertiesSensible = require(scriptParentParent.flags.getEngineFeatureEngineUGCValidatePropertiesSensible)

local function validateLegacyAccessoryMeshPartAssetFormat(arg1, arg2)
    assert(arg2.instances ~= nil, "instances required in validationContext for validateLegacyAccessoryMeshPartAssetFormat")

    local instances = arg2.instances

    local var1, var2 = validateSingleInstance(instances, arg2)
    if not var1 then
        return false, var2
    end

    local var3 = instances[1]

    local attachment = arg1:FindFirstChild("Handle"):FindFirstChildOfClass("Attachment")
    local legacyAccessoryMeshPartAssetFormatSchema = createLegacyAccessoryMeshPartAssetFormatSchema(attachment.Name)

    local var4, var5 = validateInstanceTree(legacyAccessoryMeshPartAssetFormatSchema, var3, arg2)
    if not var4 then
        return false, var5
    end

    if getEngineFeatureEngineUGCValidatePropertiesSensible() then
        local var6, var7 = ValidatePropertiesSensible.validate(var3, arg2)
        if not var6 then
            return false, var7
        end
    end

    local var6, var7 = validateLegacyAccessoryMeshPartAssetFormatMatch(var3, arg1, arg2)

    if not var6 then
        return false, var7
    end

    return true
end

return validateLegacyAccessoryMeshPartAssetFormat
