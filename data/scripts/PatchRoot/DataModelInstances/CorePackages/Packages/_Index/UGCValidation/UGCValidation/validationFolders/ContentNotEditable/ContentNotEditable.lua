-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:51:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local Constants = require(scriptParentParentParent.Constants)
local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)

local getFFlagUGCValidateBackendContentNotEditable = require(scriptParentParentParent.flags.getFFlagUGCValidateBackendContentNotEditable)

local module = {
    categories = Constants.AllAssetUploadCategoriesIncludingMakeup,
    requiredData = { ValidationEnums.SharedDataMember.rootInstance, ValidationEnums.SharedDataMember.consumerConfig },
    fflag = getFFlagUGCValidateBackendContentNotEditable,
    expectedFailures = {}
}
function module.run(arg1, arg2)
    if arg2.consumerConfig.consumerEnv == ValidationEnums.ConsumerEnv.IEC then
        return
    end

    local descendants = arg2.rootInstance:GetDescendants()
    table.insert(descendants, arg2.rootInstance)

    for _, descendant in descendants do
        local var1 = Constants.CONTENT_TYPED_PROPERTIES_BY_CLASS[descendant.ClassName]
        if not var1 then
            continue
        end

        for _, fieldName in var1 do
            if descendant[fieldName].Object == nil then
                continue
            end

            local contentNotEditable = ErrorSourceStrings.Keys.ContentNotEditable
            local tbl1 = {
                InstanceFullName = descendant:GetFullName(),
                FieldName = fieldName
            }
            arg1:fail(contentNotEditable, tbl1)
        end
    end
end

return module
