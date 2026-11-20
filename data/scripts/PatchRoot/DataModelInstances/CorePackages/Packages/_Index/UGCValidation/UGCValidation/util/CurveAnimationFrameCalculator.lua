-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:21:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local Constants = require(scriptParentParent.Constants)
local AssetCalculator = require(scriptParentParent.util.AssetCalculator)
local CurveAnimationHierarchyUtils = require(scriptParentParent.util.CurveAnimationHierarchyUtils)
local RigBuilder = require(scriptParentParent.util.RigBuilder)

local flags = scriptParentParent.flags
local getFIntUGCValidateMaxAnimationFPS = require(flags.getFIntUGCValidateMaxAnimationFPS)

local module = {}

local FaceControlsName = CurveAnimationHierarchyUtils.FaceControlsName

local function hasFloatCurveKeys(arg1)
    local x = arg1:FindFirstChild("X")
    local y = arg1:FindFirstChild("Y")
    local z = arg1:FindFirstChild("Z")
    local var1 = if x then x:IsA("FloatCurve") and #x:GetKeys() > 0 else false

    if not var1 then
        if y then
            var1 = y:IsA("FloatCurve") and #y:GetKeys() > 0
        else
            var1 = false
        end

        if not var1 then
            if z then
                var1 = z:IsA("FloatCurve")

                if var1 then
                    return #z:GetKeys() > 0
                end
            else
                var1 = false
            end
        end
    end

    return var1
end

local function hasPositionKeys(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    if not (arg1 and arg1:IsA("Vector3Curve")) then
        return false
    end

    return (hasFloatCurveKeys(arg1))
end

local function hasRotationKeys(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    if not (arg1 and arg1:IsA("EulerRotationCurve")) then
        return false
    end

    return (hasFloatCurveKeys(arg1))
end

function module.calculateAnimFramesAtOrigin(arg1)
    local var1 = 1 / getFIntUGCValidateMaxAnimationFPS()

    local function getCurveTracks()
        local curveTracks = ({})

        local bodyPartFolderRoot = CurveAnimationHierarchyUtils.getBodyPartFolderRoot(arg1)
        assert(
            bodyPartFolderRoot,
            "CurveAnimation must have one and only one body part Folder child or HumanoidRootPart child."
        )

        local descendants = bodyPartFolderRoot:GetDescendants()
        table.insert(descendants, bodyPartFolderRoot)
        for _, descendant in descendants do
            if not (descendant:IsA("Folder") and CurveAnimationHierarchyUtils.getBodyPartToParentMap()[descendant.Name]) then
                continue
            end

            local position = descendant:FindFirstChild("Position")
            local rotation = descendant:FindFirstChild("Rotation")
            local descendantName = descendant.Name
            local tbl1 = { pos = 0, rot = 0, faceControls = 0 }

            if not hasPositionKeys(position) then
                position = nil
            end

            tbl1.pos = position

            if not hasRotationKeys(rotation) then
                rotation = nil
            end

            tbl1.rot = rotation
            tbl1.faceControls = if descendant.Name == Constants.NAMED_R15_BODY_PARTS.Head then descendant:FindFirstChild(FaceControlsName) else nil
            curveTracks[descendantName] = tbl1
        end

        return curveTracks
    end

    local function calculateCurveAnimLength(curveTracks): number
        local num1 = -1

        local function getMaxTimeFromFloatCurveChildren(arg2)
            if not arg2 then
                return
            end

            for _, child in arg2:GetChildren() do
                if not child:IsA("FloatCurve") then
                    continue
                end

                for _, key in child:GetKeys() do
                    num1 = math.max(num1, key.Time)
                end
            end
        end

        for _, curveTrack in curveTracks do
            getMaxTimeFromFloatCurveChildren(curveTrack.pos)
            getMaxTimeFromFloatCurveChildren(curveTrack.rot)
            getMaxTimeFromFloatCurveChildren(curveTrack.faceControls)
        end
        return num1
    end

    local function calculateTransformsAtTime(num1: number, curveTracks)
        local transformsAtTime = ({})
        for k, curveTrack in curveTracks do
            local vec3 = if curveTrack.pos then Vector3.new(unpack(curveTrack.pos:GetValueAtTime(num1))) else Vector3.new(0, 0, 0)
            local var2 = if curveTrack.rot then curveTrack.rot:GetRotationAtTime(num1) else CFrame.new()
            transformsAtTime[k] = var2 + vec3
        end
        return transformsAtTime
    end

    local function calculatePositionMagnitudeResultsAtTime(num1: number, curveTracks)
        local positionMagnitudeResultsAtTime = ({})
        for k, curveTrack in curveTracks do
            if curveTrack.pos then
                local pos = curveTrack.pos
                positionMagnitudeResultsAtTime[k] = Vector3.new(unpack(pos:GetValueAtTime(num1))).Magnitude
            end
        end

        return positionMagnitudeResultsAtTime
    end

    local defaultCharacter = RigBuilder.createDefaultCharacter(false)
    local tbl1 = {}
    for _, child in defaultCharacter:GetChildren() do
        if CurveAnimationHierarchyUtils.isBodyPartFolderNameValid(child.Name) then
            tbl1[child.Name] = child
        end
    end
    local curveTracks = getCurveTracks()
    local curveAnimLength = calculateCurveAnimLength(curveTracks)

    local tbl2 = {}
    local tbl3 = {}

    local function addData(num1: number) -- Luacid: Inlined by compiler; 2 call sites recovered
        local transformsAtTime = calculateTransformsAtTime(num1, curveTracks)

        table.insert(tbl2, (AssetCalculator.calculateAllTransformsForFullBody(tbl1, transformsAtTime)))

        table.insert(tbl3, (calculatePositionMagnitudeResultsAtTime(num1, curveTracks)))
    end

    local num1 = 0

    while num1 <= curveAnimLength do
        addData(num1)
        num1 += var1
    end
    if curveAnimLength >= 0 then
        addData(curveAnimLength)
    end

    defaultCharacter:Destroy()
    return tbl2, curveAnimLength, tbl3, curveTracks
end

return module
