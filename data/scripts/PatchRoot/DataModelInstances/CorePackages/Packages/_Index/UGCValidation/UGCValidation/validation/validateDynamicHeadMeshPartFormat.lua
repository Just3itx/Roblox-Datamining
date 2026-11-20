-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:41:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local validateSingleInstance = require(scriptParentParent.validation.validateSingleInstance)
local validateMeshPartBodyPart = require(scriptParentParent.validation.validateMeshPartBodyPart)
local validateDynamicHeadData = require(scriptParentParent.validation.validateDynamicHeadData)

local _Types = require(scriptParentParent.util.Types)
local createDynamicHeadMeshPartSchema = require(scriptParentParent.util.createDynamicHeadMeshPartSchema)

local function validateDynamicHeadMeshPartFormat(arg1)
    assert(arg1.instances ~= nil, "instances required in validationContext for validateDynamicHeadMeshPartFormat")

    local instances = arg1.instances

    local var1, var2 = validateSingleInstance(instances, arg1)
    if not var1 then
        return var1, var2
    end

    local var3 = instances[1]

    local var4, var5 = validateMeshPartBodyPart(var3, createDynamicHeadMeshPartSchema(arg1), arg1)

    if not var4 then
        return false, var5
    end

    return validateDynamicHeadData(var3, arg1)
end

return validateDynamicHeadMeshPartFormat
