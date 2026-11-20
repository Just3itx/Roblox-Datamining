-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:50:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)

local floatEquals = require(scriptParentParentParent.util.floatEquals)

local module = {
    categories = { ValidationEnums.UploadCategory.TORSO_AND_LIMBS, ValidationEnums.UploadCategory.DYNAMIC_HEAD, ValidationEnums.UploadCategory.FULL_BODY },
    requiredData = { ValidationEnums.SharedDataMember.rootInstance, ValidationEnums.SharedDataMember.renderMeshesData },
    expectedFailures = {}
}
local function validateMeshMin(arg1, originalSize: vector, meshName: string)
    local tbl1 = {}

    for _, value in { "X", "Y", "Z" } do
        local var1 = originalSize[value]
        if floatEquals(var1, 0, 0.0001) then
            table.insert(tbl1, "Size on " .. value .. " axis is zero")
        end
    end

    if #tbl1 > 0 then
        arg1:fail(
            ErrorSourceStrings.Keys.BodyBlocking_ZeroMeshSize,
            {
                meshName = meshName,
                details = table.concat(tbl1, ". ")
            }
        )
    end
end

function module.run(arg1, arg2)
    for value, value2 in arg2.renderMeshesData do
        validateMeshMin(arg1, value2.originalSize, value)
    end
end

return module
