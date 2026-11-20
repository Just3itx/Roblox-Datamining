-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:50:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)

local module = {
    categories = { ValidationEnums.UploadCategory.ANIMATION },
    requiredData = { ValidationEnums.SharedDataMember.rootInstance, ValidationEnums.SharedDataMember.uploadEnum },
    expectedFailures = {},
    prereqTests = { ValidationEnums.ValidationModule.ExpectedRootSchema }
}
function module.run(arg1, arg2)
    if arg2.uploadEnum.assetType ~= Enum.AssetType.IdleAnimation then
        return
    end

    for _, descendant in arg2.rootInstance:GetDescendants() do
        if not descendant:IsA("NumberValue") or descendant.Name ~= "Weight" then
            continue
        end

        local descendantValue = descendant.Value
        if not (descendantValue <= 0) then
            continue
        end

        local animationWeightNotPositive = ErrorSourceStrings.Keys.Animation_WeightNotPositive
        local tbl1 = {
            animationName = if descendant.Parent then descendant.Parent:GetFullName() else "Unknown",
            weight = tostring(descendantValue)
        }
        arg1:fail(animationWeightNotPositive, tbl1)
    end
end

return module
