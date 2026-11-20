-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:00:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)

local module = {
    categories = { ValidationEnums.UploadCategory.ANIMATION },
    requiredData = { ValidationEnums.SharedDataMember.curveAnimations, ValidationEnums.SharedDataMember.uploadEnum },
    expectedFailures = {},
    prereqTests = { ValidationEnums.ValidationModule.CurveAnimDataAvailable }
}
function module.run(arg1, arg2)
    if arg2.uploadEnum.assetType == Enum.AssetType.JumpAnimation then
        return
    end

    for _, curveAnimation in arg2.curveAnimations do
        if curveAnimation.Loop then
            continue
        end

        local curveAnimLoopingNotEnabled = ErrorSourceStrings.Keys.CurveAnim_LoopingNotEnabled
        local tbl1 = {
            animationName = curveAnimation:GetFullName()
        }
        arg1:fail(curveAnimLoopingNotEnabled, tbl1)
    end
end

return module
