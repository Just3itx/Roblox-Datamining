-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:10:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local Constants = require(scriptParentParentParent.Constants)
local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)
local BoundsCalculator = require(scriptParentParentParent.util.BoundsCalculator)

local getFFlagUGCValidateNoMeshBelowFeet = require(scriptParentParentParent.flags.getFFlagUGCValidateNoMeshBelowFeet)

game:DefineFastString("UGCValidateMaxMeshBelowFeet", "0.1")

local module = {
    categories = { ValidationEnums.UploadCategory.FULL_BODY },
    requiredData = { ValidationEnums.SharedDataMember.rootInstance, ValidationEnums.SharedDataMember.renderMeshesData },
    fflag = getFFlagUGCValidateNoMeshBelowFeet,
    expectedFailures = {}
}
local tbl1 = {
    Constants.NAMED_R15_BODY_PARTS.LeftUpperLeg,
    Constants.NAMED_R15_BODY_PARTS.LeftLowerLeg,
    Constants.NAMED_R15_BODY_PARTS.LeftFoot,
    Constants.NAMED_R15_BODY_PARTS.RightUpperLeg,
    Constants.NAMED_R15_BODY_PARTS.RightLowerLeg,
    Constants.NAMED_R15_BODY_PARTS.RightFoot
}

local tbl2 = {
    Constants.NAMED_R15_BODY_PARTS.Head,
    Constants.NAMED_R15_BODY_PARTS.UpperTorso,
    Constants.NAMED_R15_BODY_PARTS.LowerTorso,
    Constants.NAMED_R15_BODY_PARTS.LeftUpperArm,
    Constants.NAMED_R15_BODY_PARTS.LeftLowerArm,
    Constants.NAMED_R15_BODY_PARTS.LeftHand,
    Constants.NAMED_R15_BODY_PARTS.RightUpperArm,
    Constants.NAMED_R15_BODY_PARTS.RightLowerArm,
    Constants.NAMED_R15_BODY_PARTS.RightHand
}

local function getMeshBottom(tbl3, str1: string) -- Luacid: Inlined by compiler; 2 call sites recovered
    local var1 = tbl3[str1]
    local minMeshCorner = var1 and var1.boundsData.minMeshCorner
    return if minMeshCorner then minMeshCorner.Y else nil
end

function module.run(arg1, arg2)
    local tbl3 = {}
    for _, child in arg2.rootInstance:GetChildren() do
        if child:IsA("MeshPart") then
            tbl3[child.Name] = child
        end
    end

    local var1, _, var2 = BoundsCalculator.calculateIndividualFullBodyPartsDataFromData(tbl3, arg2.renderMeshesData)
    if not var1 then
        arg1:fetchError("Failed to calculate full body part bounds")
        return
    end

    local var3 = nil
    for _, value in tbl1 do
        local meshBottom = getMeshBottom(var2, value)

        if meshBottom and (var3 == nil or meshBottom < var3) then
            var3 = meshBottom
        end
    end

    if var3 == nil then
        return
    end

    local var4 = tonumber(game:GetFastString("UGCValidateMaxMeshBelowFeet"))
    for _, partName in tbl2 do
        local meshBottom = getMeshBottom(var2, partName)

        if meshBottom == nil then
            continue
        end

        local var5 = var3 - meshBottom
        if not (var4 < var5) then
            continue
        end

        local noMeshBelowFeetPartBelowFeet = ErrorSourceStrings.Keys.NoMeshBelowFeet_PartBelowFeet
        local tbl4 = {
            partName = partName,
            distance = string.format("%.2f", var5),
            maxDistance = string.format("%.2f", var4)
        }
        arg1:fail(noMeshBelowFeetPartBelowFeet, tbl4, tbl3[partName])
    end
end

return module
