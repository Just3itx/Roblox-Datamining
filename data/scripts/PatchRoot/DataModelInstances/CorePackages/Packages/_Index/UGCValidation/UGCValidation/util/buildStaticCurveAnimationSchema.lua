-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:11:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local AssetCalculator = require(scriptParentParent.util.AssetCalculator)
local R15plusUtils = require(scriptParentParent.util.R15plusUtils)

local tbl1 = {
    "ChinRaiserUpperLip",
    "ChinRaiser",
    "FlatPucker",
    "Funneler",
    "LowerLipSuck",
    "LipPresser",
    "LipsTogether",
    "MouthLeft",
    "MouthRight",
    "Pucker",
    "UpperLipSuck",
    "LeftCheekPuff",
    "LeftDimpler",
    "LeftLipCornerDown",
    "LeftLowerLipDepressor",
    "LeftLipCornerPuller",
    "LeftLipStretcher",
    "LeftUpperLipRaiser",
    "RightCheekPuff",
    "RightDimpler",
    "RightLipCornerDown",
    "RightLowerLipDepressor",
    "RightLipCornerPuller",
    "RightLipStretcher",
    "RightUpperLipRaiser",
    "JawDrop",
    "JawLeft",
    "JawRight",
    "Corrugator",
    "LeftBrowLowerer",
    "LeftOuterBrowRaiser",
    "LeftNoseWrinkler",
    "LeftInnerBrowRaiser",
    "RightBrowLowerer",
    "RightOuterBrowRaiser",
    "RightInnerBrowRaiser",
    "RightNoseWrinkler",
    "EyesLookDown",
    "EyesLookLeft",
    "EyesLookUp",
    "EyesLookRight",
    "LeftCheekRaiser",
    "LeftEyeUpperLidRaiser",
    "LeftEyeClosed",
    "RightCheekRaiser",
    "RightEyeUpperLidRaiser",
    "RightEyeClosed",
    "TongueDown",
    "TongueOut",
    "TongueUp"
}

local tbl2 = {
    Head = { "Spine", "Chest" },
    LeftUpperArm = { "Spine", "Chest", "LeftClavicle" },
    RightUpperArm = { "Spine", "Chest", "RightClavicle" }
}

local function buildPositionCurveSchema()
    return {
        ClassName = "Vector3Curve",
        Name = "Position",
        _optional = true,
        _children = {
            { ClassName = "FloatCurve", Name = "X", _optional = true },
            { ClassName = "FloatCurve", Name = "Y", _optional = true },
            { ClassName = "FloatCurve", Name = "Z", _optional = true }
        }
    }
end

local function buildRotationCurveSchema()
    return {
        ClassName = "EulerRotationCurve",
        Name = "Rotation",
        _optional = true,
        _children = {
            { ClassName = "FloatCurve", Name = "X", _optional = true },
            { ClassName = "FloatCurve", Name = "Y", _optional = true },
            { ClassName = "FloatCurve", Name = "Z", _optional = true }
        }
    }
end

local function buildFaceControlsSchema()
    local _children = {}
    for _, value in tbl1 do
        table.insert(_children, { ClassName = "FloatCurve", Name = value, _optional = true })
    end

    return { ClassName = "Folder", Name = "FaceControls", _optional = true, _children = _children }
end

local function convertBoneSchemaToChildren(arg1, tbl3)
    local result = {}
    for value, value2 in arg1 do
        if value2.ClassName ~= "Bone" then
            continue
        end

        local _children = {}

        table.insert(_children, (buildPositionCurveSchema()))
        table.insert(_children, (buildRotationCurveSchema()))

        if value2._children then
            for _, value3 in (convertBoneSchemaToChildren(value2._children, tbl3)) do
                table.insert(_children, value3)
            end
        end

        if tbl3 and tbl3[value] then
            for _, value3 in tbl3[value] do
                table.insert(_children, value3)
            end
        end

        table.insert(result, { ClassName = "Folder", Name = value, _optional = true, _children = _children })
    end

    return result
end

local function func1(str1: string, tbl3)
    local _children = {}

    table.insert(_children, (buildPositionCurveSchema()))
    table.insert(_children, (buildRotationCurveSchema()))

    local bodyPartsToParents = AssetCalculator.getBodyPartsToParents()
    local tbl5 = ({})
    for _, value in tbl3 do
        local tbl6 = {}
        for k, bodyPartsToParent in bodyPartsToParents do
            if bodyPartsToParent == value then
                table.insert(tbl6, k)
            end
        end
        tbl5[value] = func1(value, tbl6)
    end

    for _, value in tbl3 do
        table.insert(_children, tbl5[value])
    end

    local avatarBoneSchema = R15plusUtils.getAvatarBoneSchema(str1)
    if next(avatarBoneSchema) ~= nil then
        local tbl6 = ({})
        if str1 == "UpperTorso" then
            for value, value2 in tbl2 do
                if not tbl5[value] then
                    continue
                end

                for _, value3 in value2 do
                    if not tbl6[value3] then
                        tbl6[value3] = {}
                    end
                    table.insert(tbl6[value3], tbl5[value])
                end
            end
        end

        for _, value in (convertBoneSchemaToChildren(avatarBoneSchema, tbl6)) do
            table.insert(_children, value)
        end
    end

    if str1 == "Head" then
        table.insert(_children, (buildFaceControlsSchema()))
    end

    return { ClassName = "Folder", Name = str1, _optional = true, _children = _children }
end

local function buildSchema()
    local tbl3 = {}

    for value, value2 in (AssetCalculator.getBodyPartsToParents()) do
        if value2 == "LowerTorso" then
            table.insert(tbl3, value)
        end
    end

    return {
        ClassName = "CurveAnimation",
        _children = {
            { ClassName = "AnimationRigData" },
            { ClassName = "MarkerCurve", _optional = true },
            {
                ClassName = "Folder",
                Name = "HumanoidRootPart",
                _children = { (func1("LowerTorso", tbl3)) }
            }
        }
    }
end

return (buildSchema())
