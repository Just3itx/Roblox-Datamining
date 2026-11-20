-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:00:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)

local module = {
    categories = { ValidationEnums.UploadCategory.EMOTE_ANIMATION, ValidationEnums.UploadCategory.ANIMATION },
    requiredData = { ValidationEnums.SharedDataMember.curveAnimations },
    expectedFailures = {},
    prereqTests = { ValidationEnums.ValidationModule.CurveAnimDataAvailable }
}
function module.run(arg1, arg2)
    for _, curveAnimation in arg2.curveAnimations do
        for _, descendant in curveAnimation:GetDescendants() do
            if descendant:IsA("Script") or descendant:IsA("ModuleScript") then
                arg1:fail(ErrorSourceStrings.Keys.CurveAnim_ContainsScripts)
                return
            end
        end
    end
end

return module
