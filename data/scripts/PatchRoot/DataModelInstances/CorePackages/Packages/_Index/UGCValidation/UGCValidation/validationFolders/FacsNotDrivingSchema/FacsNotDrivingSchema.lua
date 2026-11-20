-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:01:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UGCValidationService = game:GetService("UGCValidationService")
local scriptParentParentParent = script.Parent.Parent.Parent
local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local R15plusUtils = require(scriptParentParentParent.util.R15plusUtils)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)
local Constants = require(scriptParentParentParent.Constants)
local module = {
    fflag = require(scriptParentParentParent.flags.getFFlagUGCValidationEnableR15plusSkinning),
    categories = { ValidationEnums.UploadCategory.DYNAMIC_HEAD },
    requiredData = { ValidationEnums.SharedDataMember.renderMeshesData }
}
function module.run(arg1, arg2)
    local jointNameWhitelist = R15plusUtils.getJointNameWhitelist()
    local head = arg2.renderMeshesData.Head
    for _, jointName in { UGCValidationService:GetFacsDrivenJointNamesFromEditableMesh(head.editable) } do
        if jointNameWhitelist[jointName] or Constants.ALLOWED_SKINNING_TRANSFER_JOINT_NAMES[jointName] then
            arg1:fail(ErrorSourceStrings.Keys.UnallowedFacsJoints, { jointName = jointName })
        end
    end
end

return module
