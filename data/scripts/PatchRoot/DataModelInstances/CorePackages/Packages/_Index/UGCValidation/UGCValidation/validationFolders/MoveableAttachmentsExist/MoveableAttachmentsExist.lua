-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:10:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)

local getAllInstancesIsA = require(scriptParentParentParent.util.getAllInstancesIsA)
local getAllInstancesWithName = require(scriptParentParentParent.util.getAllInstancesWithName)
local R15plusUtils = require(scriptParentParentParent.util.R15plusUtils)
local module = {
    categories = { ValidationEnums.UploadCategory.TORSO_AND_LIMBS, ValidationEnums.UploadCategory.DYNAMIC_HEAD },
    requiredData = { ValidationEnums.SharedDataMember.rootInstance },
    fflag = R15plusUtils.checkFlagEnabledForAllowHrd
}
function module.run(arg1, arg2)
    local rootInstance = arg2.rootInstance
    for _, value in getAllInstancesIsA(rootInstance, "MeshPart") do
        arg1:setReportingInstance(value)
        local avatarBoneSchema = R15plusUtils.getAvatarBoneSchema(value.Name)
        for attName, value3 in (R15plusUtils.getNameWhitelistOfClassInSchema(avatarBoneSchema, "Attachment")) do
            if not value3 then
                continue
            end

            local allInstancesWithName = getAllInstancesWithName(value, attName)
            if #allInstancesWithName == 1 and allInstancesWithName[1].ClassName == "Attachment" then
                continue
            end

            local missingRequiredAttachment = ErrorSourceStrings.Keys.MissingRequiredAttachment
            local tbl1 = {
                attName = attName,
                partName = value.Name
            }
            arg1:fail(missingRequiredAttachment, tbl1)
        end
    end
end

return module
