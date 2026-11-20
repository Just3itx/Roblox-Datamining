-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:01:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)

local getFFlagUGCValidateFacsJointCountBounded = require(scriptParentParentParent.flags.getFFlagUGCValidateFacsJointCountBounded)
local getFIntUGCValidateFacsJointCountMaximum = require(scriptParentParentParent.flags.getFIntUGCValidateFacsJointCountMaximum)

local module = {
    categories = { ValidationEnums.UploadCategory.DYNAMIC_HEAD },
    requiredData = { ValidationEnums.SharedDataMember.renderMeshesData },
    fflag = getFFlagUGCValidateFacsJointCountBounded,
    expectedFailures = { "Asset_EF_DynamicHeadExcessiveFacs" }
}
function module.run(arg1, arg2)
    local num1 = #arg2.renderMeshesData.Head.editable:GetBones()
    local fIntUgcValidateFacsJointCountMaximum = getFIntUGCValidateFacsJointCountMaximum()

    if fIntUgcValidateFacsJointCountMaximum < num1 then
        arg1:fail(ErrorSourceStrings.Keys.FacsJointCountBounded, {
            maxFacsJointCount = string.format("%d", fIntUgcValidateFacsJointCountMaximum),
            actualJointCount = string.format("%d", num1)
        })
    end
end

return module
