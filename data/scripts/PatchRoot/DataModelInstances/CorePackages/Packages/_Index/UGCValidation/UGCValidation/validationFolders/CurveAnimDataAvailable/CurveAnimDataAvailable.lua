-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:51:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)
local FetchAllDesiredData = require(scriptParentParentParent.validationSystem.dataFetchModules.FetchAllDesiredData)

local module = {
    categories = { ValidationEnums.UploadCategory.EMOTE_ANIMATION, ValidationEnums.UploadCategory.ANIMATION },
    requiredData = {},
    expectedFailures = {}
}
function module.run(arg1, arg2)
    local curveAnimations = arg2.curveAnimations
    if not curveAnimations or curveAnimations == FetchAllDesiredData.DATA_FETCH_FAILURE then
        arg1:fail(ErrorSourceStrings.Keys.CurveAnim_FetchFailed)
        return
    end

    if #curveAnimations == 0 then
        arg1:fail(ErrorSourceStrings.Keys.CurveAnim_NotCurveAnimation)
    else
        local curveAnimComputedFrames = arg2.curveAnimComputedFrames
        if not curveAnimComputedFrames or curveAnimComputedFrames == FetchAllDesiredData.DATA_FETCH_FAILURE then
            arg1:fail(ErrorSourceStrings.Keys.CurveAnim_FetchFailed)
        end
    end
end

return module
