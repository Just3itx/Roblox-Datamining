-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:51:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)

local str1 = game:DefineFastString("UGCValidationBodyPartCollisionFidelity", "Default")

local module = {
    categories = { ValidationEnums.UploadCategory.TORSO_AND_LIMBS, ValidationEnums.UploadCategory.DYNAMIC_HEAD },
    requiredData = { ValidationEnums.SharedDataMember.rootInstance },
    expectedFailures = {}
}
function module.run(arg1, arg2)
    local rootInstance = arg2.rootInstance

    local default = Enum.CollisionFidelity.Default

    pcall(function()
        default = Enum.CollisionFidelity[str1]
    end)

    local descendants = rootInstance:GetDescendants()
    table.insert(descendants, 1, rootInstance)

    for _, descendant in descendants do
        if not descendant:IsA("MeshPart") or descendant.CollisionFidelity == default then
            continue
        end

        local collisionFidelityWrong = ErrorSourceStrings.Keys.CollisionFidelityWrong
        local tbl1 = {
            InstancePath = descendant:GetFullName(),
            ExpectedFidelity = default.Name
        }
        arg1:fail(collisionFidelityWrong, tbl1)
    end
end

return module
