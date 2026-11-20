-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:01:41Z
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
local function buildAcceptedMaterialList(): string
    local tbl1 = {}
    for k in pairs(Constants.MATERIAL_WHITELIST) do
        table.insert(tbl1, k.Name)
    end
    return table.concat(tbl1, ", ")
end

function module.run(arg1, arg2)
    local rootInstance = arg2.rootInstance

    local descendants = rootInstance:GetDescendants()
    table.insert(descendants, rootInstance)

    local var1 = nil
    for _, descendant in descendants do
        if not descendant:IsA("BasePart") or Constants.MATERIAL_WHITELIST[descendant.Material] then
            continue
        end

        var1 = var1 or buildAcceptedMaterialList()
        local materialNotAllowed = ErrorSourceStrings.Keys.MaterialNotAllowed
        local tbl1 = {
            InstanceNameList = descendant:GetFullName(),
            AllowedMaterials = var1
        }
        arg1:fail(materialNotAllowed, tbl1)
    end
end

return module
