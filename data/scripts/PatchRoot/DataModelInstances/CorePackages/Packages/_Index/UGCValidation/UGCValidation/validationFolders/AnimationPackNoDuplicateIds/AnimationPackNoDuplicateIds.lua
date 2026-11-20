-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:50:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)

local module = {
    categories = { ValidationEnums.UploadCategory.ANIMATION_PACK },
    requiredData = { ValidationEnums.SharedDataMember.contentIds },
    expectedFailures = {},
    prereqTests = { ValidationEnums.ValidationModule.ExpectedRootSchema }
}
function module.run(arg1, arg2)
    for animationId, contentId in arg2.contentIds do
        if not (#contentId > 1) then
            continue
        end

        local tbl1 = {}
        for _, value in contentId do
            table.insert(tbl1, value.instance:GetFullName())
        end

        local animationPackDuplicateAnimationId = ErrorSourceStrings.Keys.AnimationPack_DuplicateAnimationId
        local tbl2 = {
            animationId = animationId,
            instancePaths = table.concat(tbl1, ", ")
        }
        arg1:fail(animationPackDuplicateAnimationId, tbl2)
    end
end

return module
