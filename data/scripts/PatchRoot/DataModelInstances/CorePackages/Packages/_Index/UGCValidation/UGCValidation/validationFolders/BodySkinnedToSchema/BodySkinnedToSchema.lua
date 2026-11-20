-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:50:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UGCValidationService = game:GetService("UGCValidationService")
local scriptParentParentParent = script.Parent.Parent.Parent
local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local R15plusUtils = require(scriptParentParentParent.util.R15plusUtils)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)
local module = {
    fflag = require(scriptParentParentParent.flags.getFFlagUGCValidationEnableR15plusSkinning),
    categories = { ValidationEnums.UploadCategory.TORSO_AND_LIMBS },
    requiredData = { ValidationEnums.SharedDataMember.renderMeshesData }
}
function module.run(arg1, arg2)
    local jointNameWhitelist = R15plusUtils.getJointNameWhitelist()
    for partName, value2 in arg2.renderMeshesData do
        for _, jointName in { UGCValidationService:GetSkinnedJointNamesFromEditableMesh(value2.editable) } do
            if not jointNameWhitelist[jointName] then
                arg1:fail(ErrorSourceStrings.Keys.UnallowedJointSkinned, { partName = partName, jointName = jointName })
            end
        end
    end
end

return module
