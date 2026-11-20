-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:11:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local CurveAnimationHierarchyUtils = require(scriptParentParent.util.CurveAnimationHierarchyUtils)

local function hasFloatCurveKeys(arg1)
    for _, child in arg1:GetChildren() do
        if child:IsA("FloatCurve") and #child:GetKeys() > 0 then
            return true
        end
    end
    return false
end

local function rotationCurveHasKeys(arg1) -- Luacid: unused: defined but never referenced
    if arg1:IsA("EulerRotationCurve") then
        return (hasFloatCurveKeys(arg1))
    end

    return if arg1:IsA("RotationCurve") then arg1:GetNumberOfKeys() > 0 else false
end

local function folderHasTracks(arg1)
    local position = arg1:FindFirstChild("Position")
    local rotation = arg1:FindFirstChild("Rotation")
    local bool1 = not not (position ~= nil and position:IsA("Vector3Curve")) and hasFloatCurveKeys(position)

    if not bool1 then
        if rotation == nil then
            bool1 = false
        else
            if rotation:IsA("EulerRotationCurve") then
                return (hasFloatCurveKeys(rotation))
            end

            if rotation:IsA("RotationCurve") then
                return rotation:GetNumberOfKeys() > 0
            end

            bool1 = false
        end
    end

    return bool1
end

local function subtreeHasTracks(arg1)
    if folderHasTracks(arg1) then
        return true
    end
    for _, descendant in arg1:GetDescendants() do
        if descendant:IsA("Folder") and folderHasTracks(descendant) then
            return true
        end
    end
    return false
end

local function getFolderRoot(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    for _, child in arg1:GetChildren() do
        if child:IsA("Folder") then
            return child
        end
    end
    return nil
end

local function getAnimLength(folderRoot)
    local num1 = 0
    for _, descendant in folderRoot:GetDescendants() do
        if descendant:IsA("FloatCurve") then
            for _, key in descendant:GetKeys() do
                if num1 < key.Time then
                    num1 = key.Time
                end
            end
        elseif descendant:IsA("RotationCurve") then
            local numberOfKeys = descendant:GetNumberOfKeys()
            if numberOfKeys > 0 then
                local keyAtIndex = descendant:GetKeyAtIndex(numberOfKeys)
                if num1 < keyAtIndex.Time then
                    num1 = keyAtIndex.Time
                end
            end
        end
    end
    return num1
end

local function samplePosition(arg1, time: number): Vector3
    local position = arg1:FindFirstChild("Position")
    if not (position and position:IsA("Vector3Curve")) then
        return Vector3.new(0, 0, 0)
    end
    local x = position:FindFirstChild("X")
    local y = position:FindFirstChild("Y")
    local z = position:FindFirstChild("Z")
    return Vector3.new(
        if x and x:IsA("FloatCurve") then x:GetValueAtTime(time) else 0,
        if y and y:IsA("FloatCurve") then y:GetValueAtTime(time) else 0,
        if z and z:IsA("FloatCurve") then z:GetValueAtTime(time) else 0
    )
end

local function sampleRotation(arg1, time: number)
    local rotation = arg1:FindFirstChild("Rotation")
    if not rotation then
        return CFrame.new()
    elseif rotation:IsA("EulerRotationCurve") or rotation:IsA("RotationCurve") then
        return rotation:GetRotationAtTime(time)
    end

    return CFrame.new()
end

local function buildPoseAtTime(arg1, time: number, tbl1): Pose
    local pose = Instance.new("Pose")
    pose.Name = arg1.Name
    pose.Weight = 1

    local vec3 = samplePosition(arg1, time)
    pose.CFrame = sampleRotation(arg1, time) + vec3

    local tbl2 = ({})
    for _, child in arg1:GetChildren() do
        if child:IsA("Folder")
            and not tbl1[child.Name]
            and (CurveAnimationHierarchyUtils.isBodyPartFolderNameValid(child.Name)
                or child.Name == CurveAnimationHierarchyUtils.humanoidRootPartName
                or subtreeHasTracks(child))
        then
            tbl1[child.Name] = true
            buildPoseAtTime(child, time, tbl1).Parent = pose
            tbl2[child.Name] = true
        end
    end

    for _, value in CurveAnimationHierarchyUtils.calculateAcceptableChildBodyPartFolders(arg1.Name) do
        local valueName = value.Name
        if not valueName or tbl2[valueName] or tbl1[valueName] then
            continue
        end

        tbl1[valueName] = true
        local pose2 = Instance.new("Pose")
        pose2.Name = valueName
        pose2.CFrame = CFrame.new()
        pose2.Weight = 1
        pose2.Parent = pose
        tbl2[valueName] = true
    end

    return pose
end

local function buildEmoteKeyframeSequenceFromCurveAnim(arg1, num1: number?): KeyframeSequence
    local folderRoot = getFolderRoot(arg1)
    local num2 = num1 or 1 / 24

    if not folderRoot then
        warn("[buildEmoteKeyframeSequenceFromCurveAnim]: no folder root found in CurveAnimation")
        return Instance.new("KeyframeSequence")
    end

    local animLength = getAnimLength(folderRoot)
    if animLength <= 0 then
        warn("[buildEmoteKeyframeSequenceFromCurveAnim]: animation has no keyframes")
        return Instance.new("KeyframeSequence")
    end

    local emoteAnimation = Instance.new("KeyframeSequence")
    emoteAnimation.Name = "EmoteAnimation"
    local num3 = 0

    while num3 <= animLength + num2 * 0.5 do
        local time = math.min(num3, animLength)
        local keyframe = Instance.new("Keyframe")
        keyframe.Time = time

        local tbl1 = {
            [folderRoot.Name] = true
        }
        buildPoseAtTime(folderRoot, time, tbl1).Parent = keyframe
        keyframe.Parent = emoteAnimation

        num3 += num2
    end

    return emoteAnimation
end

return buildEmoteKeyframeSequenceFromCurveAnim
