-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:10:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local Constants = require(scriptParentParentParent.Constants)
local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)

local module = {
    categories = {
        ValidationEnums.UploadCategory.TORSO_AND_LIMBS,
        ValidationEnums.UploadCategory.DYNAMIC_HEAD,
        ValidationEnums.UploadCategory.LAYERED_CLOTHING,
        ValidationEnums.UploadCategory.EYEBROW_EYELASH,
        ValidationEnums.UploadCategory.RIGID_ACCESSORY
    },
    requiredData = { ValidationEnums.SharedDataMember.rootInstance },
    expectedFailures = {}
}
function module.run(arg1, arg2)
    local rootInstance = arg2.rootInstance

    local descendants = rootInstance:GetDescendants()
    table.insert(descendants, rootInstance)

    for _, descendant in descendants do
        if not descendant:IsA("StringValue")
            or descendant.Name ~= "AvatarPartScaleType"
            or Constants.AvatarPartScaleTypes[descendant.Value]
        then
            continue
        end

        local scaleTypeInvalid = ErrorSourceStrings.Keys.ScaleTypeInvalid
        local tbl1 = {
            ParentName = if descendant.Parent then descendant.Parent.Name else descendant.Name
        }
        arg1:fail(scaleTypeInvalid, tbl1)
    end
end

return module
