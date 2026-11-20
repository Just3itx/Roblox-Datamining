-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:51:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)
local R15plusUtils = require(scriptParentParentParent.util.R15plusUtils)
local CurveAnimBoneHierarchyUtils = require(scriptParentParentParent.util.CurveAnimBoneHierarchyUtils)

local module = {
    categories = { ValidationEnums.UploadCategory.EMOTE_ANIMATION, ValidationEnums.UploadCategory.ANIMATION },
    requiredData = { ValidationEnums.SharedDataMember.curveAnimations },
    conditionalData = { ValidationEnums.SharedDataMember.curveAnimBoneData },
    expectedFailures = {},
    prereqTests = { ValidationEnums.ValidationModule.CurveAnimDataAvailable }
}
local tbl1 = {
    "Head",
    "UpperTorso",
    "LeftFoot",
    "RightFoot",
    "LeftHand",
    "RightHand"
}
local var1 = nil

local function getParentMap()
    if var1 then
        return var1
    end

    local parentMap = ({})

    for _, value in tbl1 do
        local avatarBoneSchema = R15plusUtils.getAvatarBoneSchema(value)
        local schemaFlatHierarchyList = R15plusUtils.getSchemaFlatHierarchyList(avatarBoneSchema, { value })

        for value2, value3 in schemaFlatHierarchyList do
            if value3.ClassName ~= "Bone" then
                continue
            end

            local path = value3.path
            local var2 = path[#path - 1]
            local var3 = schemaFlatHierarchyList[var2]
            if var3 and var3.ClassName == "Bone" then
                parentMap[value2] = var2
            end
        end
    end

    var1 = parentMap
    return parentMap
end

function module.run(arg1, arg2)
    local parentMap = getParentMap()

    for _, curveAnimation in arg2.curveAnimations do
        local tbl2 = {}
        for _, descendant in curveAnimation:GetDescendants() do
            if descendant:IsA("Folder") and CurveAnimBoneHierarchyUtils.isBoneFolderName(descendant.Name) then
                tbl2[descendant.Name] = true
            end
        end

        for boneName in tbl2 do
            local parentBoneName = parentMap[boneName]
            if parentBoneName ~= nil and not tbl2[parentBoneName] then
                arg1:fail(
                    ErrorSourceStrings.Keys.CurveAnim_BoneRequiresParent,
                    { boneName = boneName, parentBoneName = parentBoneName }
                )
            end
        end
    end
end

return module
