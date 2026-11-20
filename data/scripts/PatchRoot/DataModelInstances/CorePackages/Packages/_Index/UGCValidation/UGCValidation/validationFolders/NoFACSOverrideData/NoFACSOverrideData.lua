-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:10:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)

local module = {
    categories = { ValidationEnums.UploadCategory.DYNAMIC_HEAD },
    requiredData = { ValidationEnums.SharedDataMember.rootInstance },
    fflag = require(scriptParentParentParent.flags.getEngineFeatureUGCValidateCheckFacsDisableOverride)
}
function module.run(arg1, arg2)
    local faceControls = arg2.rootInstance:FindFirstChildOfClass("FaceControls")

    if faceControls and faceControls:HasOverrideFACSData() then
        arg1:fail(ErrorSourceStrings.Keys.FaceControlsOverrideFACSNotEmpty, nil, faceControls)
    end
end

return module
