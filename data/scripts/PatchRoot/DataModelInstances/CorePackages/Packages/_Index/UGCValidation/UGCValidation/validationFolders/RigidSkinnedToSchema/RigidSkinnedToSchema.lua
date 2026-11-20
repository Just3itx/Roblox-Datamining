-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:10:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)
local module = {
    fflag = require(scriptParentParentParent.flags.getEngineFeatureEngineUGCValidationConsolidateAccessorySkinning),
    categories = { ValidationEnums.UploadCategory.RIGID_ACCESSORY },
    requiredData = { ValidationEnums.SharedDataMember.renderMeshesData }
}
function module.run(arg1, arg2)
    local handle = arg2.renderMeshesData.Handle
    if handle == nil then
        error("Schema should have ensured data exists for handle")
    end

    if #handle.editable:GetBones() > 0 then
        arg1:fail(ErrorSourceStrings.Keys.AccessorySkinning_RigidIsSkinned, nil, arg2.rootInstance:FindFirstChild("Handle"))
    end
end

return module
