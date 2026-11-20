-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T16:21:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)

local module = {
    categories = { ValidationEnums.UploadCategory.FULL_BODY },
    fflag = require(scriptParentParentParent.flags.getFFlagUGCValidateAQRiggingQuality)
}
function module.run(arg1, arg2)
    local measureJointNumber = arg2.aqsSummaryData.Measure_Joint_Number
    if measureJointNumber == nil then
        arg1:warn(ErrorSourceStrings.Keys.AQSWarn_MissingData, { measureName = "Measure_Joint_Number" })

        return
    end
    local fullBodyMesh = measureJointNumber.full_body_mesh
    if fullBodyMesh == nil or fullBodyMesh.score == nil then
        arg1:warn(ErrorSourceStrings.Keys.AQSWarn_MissingData, { measureName = "Measure_Joint_Number" })

        return
    end
    if tonumber(fullBodyMesh.score) == 100 then
        return
    end

    arg1:warn(ErrorSourceStrings.Keys.AQSWarn_JointNumber, {
        joint_number = fullBodyMesh.joint_number or "unknown",
        left_hand_joint_number = fullBodyMesh.left_hand_joint_number or "unknown",
        right_hand_joint_number = fullBodyMesh.right_hand_joint_number or "unknown"
    })
end

return module
