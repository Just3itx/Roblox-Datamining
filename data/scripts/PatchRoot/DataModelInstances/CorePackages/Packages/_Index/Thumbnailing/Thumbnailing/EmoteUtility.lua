-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T16:20:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AnimationClipProvider = game:GetService("AnimationClipProvider")
local InsertService = game:GetService("InsertService")
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")

local FallbackKeyframeSequenceAssetId = game:DefineFastString("EmoteUtilityFallbackKeyframeSequenceAssetId", "10921261056")
local bool1 = game:DefineFastFlag("EmoteUtilityDefaultMoodFromCharacter", false)
local bool2 = game:DefineFastFlag("EmoteUtilityUseIdleAnimationFallback", false)

local bool3 = game:DefineFastFlag("EmoteUtilityReportPoseAnimationDownloadFailure", false)
local bool4 = game:DefineFastFlag("EmoteUtilityRetargetPoses", false)

local str2 = game:DefineFastString("EmoteUtilityCanonicalR15RigUri", "rbxasset://avatar/characterR15.rbxm")
local bool5 = game:DefineFastFlag("EmoteUtilityCurveRotationOnlyJoints", false)
local bool6 = game:DefineFastFlag("EmoteUtilityMoodOverride", false)

local module = {
    FallbackKeyframeSequenceAssetId = FallbackKeyframeSequenceAssetId,
    debugLoadAssetsFromFiles = false,
    mapAssetIdToFileName = nil,
    EmoteUtilitySupportAJU = true,
    FALLBACK_KEYFRAME_SEQUENCE_ASSET_URL = "http://www.roblox.com/asset/?id=" .. FallbackKeyframeSequenceAssetId
}

local tbl1 = ({})

local function clearJointBlacklist() -- Luacid: Inlined by compiler; 4 call sites recovered
    tbl1 = {}
end

local function blacklistJoint(jointBetween) -- Luacid: Inlined by compiler; 1 call site recovered
    tbl1[jointBetween] = true
end

local function jointIsBlacklisted(arg1): boolean -- Luacid: unused: defined but never referenced
    return not not tbl1[arg1]
end

local function getCameraOffset(num1: number, extentsSize: vector): number -- Luacid: Inlined by compiler; 1 call site recovered
    local extentsSizeX = extentsSize.X
    local extentsSizeY = extentsSize.Y
    local extentsSizeZ = extentsSize.Z

    local num2 = math.sqrt(extentsSizeX ^ 2 + extentsSizeY ^ 2 + extentsSizeZ ^ 2)
    local num3 = 1 / math.tan(math.rad(num1) / 2)

    return num2 / 2 * num3
end

local function isOnRCC() -- Luacid: Inlined by compiler; 5 call sites recovered
    local success, result = pcall(function(): boolean
        return game.GetService(game, "ThumbnailGenerator") ~= nil
    end)
    return success and result
end

local function getAnalyticsTarget(): string -- Luacid: Inlined by compiler; 6 call sites recovered
    return if isOnRCC() then "RCC" else "Client"
end

local function reportCounter(str3: string, bool7: boolean) -- Luacid: Inlined by compiler; 2 call sites recovered
    local counterName = getAnalyticsTarget() .. "_" .. str3 .. "_" .. (if bool7 then "Success" else "Failure")

    RbxAnalyticsService:ReportCounter(counterName)
end

local function getAnimationAndIsIdle(animationAssetIdOrUrl)
    assert(
        typeof(animationAssetIdOrUrl) == "number" or typeof(animationAssetIdOrUrl) == "string",
        "getAnimationAndIsIdle expects animationAssetIdOrUrl to be a number or string"
    )

    local var1 = nil
    local success, str3

    if typeof(animationAssetIdOrUrl) == "number" then
        local var2
        success, var2 = module.LoadAsset(animationAssetIdOrUrl)
        if success and var2 then
            var1 = var2:GetChildren()[1]
        end

        str3 = "EmoteUtility_LoadAsset"
    else
        local result

        success, result = pcall(function(): Instance
            return game:GetObjects(animationAssetIdOrUrl)[1]
        end)
        if success then
            var1 = result or var1
        end

        str3 = "EmoteUtility_GetObjects"
    end

    reportCounter(str3, success)

    if not (success and var1) then
        local eventName = str3 .. "_Failed"
        RbxAnalyticsService:SendEventDeferred(
            getAnalyticsTarget(),
            "EmoteUtility_getPoseAsset",
            eventName,
            { animationAssetIdOrUrl = animationAssetIdOrUrl }
        )

        return nil, nil
    end

    assert(var1, "animation is non-nil. Silence type checker.")
    local bool7

    if var1.ClassName == "Folder" then
        bool7 = true
        local var2 = var1:FindFirstChild("Pose", true) or var1:FindFirstChild("pose", true)
        if var2 == nil then
            var2 = var1:FindFirstChild("Idle", true) or var1:FindFirstChild("idle", true)
        end
        if var2 then
            var1 = var2:FindFirstChildWhichIsA("Animation", true)
        else
            var1 = var1:FindFirstChildWhichIsA("Animation", true)
        end
    else
        bool7 = false
    end

    return var1, bool7
end

local function getAnimationClipByAssetId(keyframeSequenceId: string)
    local result = nil
    local success

    if module.debugLoadAssetsFromFiles then
        local var1 = nil
        for value in string.gmatch(keyframeSequenceId, ".*id=([0-9]+)") do
            var1 = value
        end

        assert(var1, "assetId should be non-nil")
        local assetId = tonumber(var1)
        assert(assetId, "assetIdAsNumber should be non-nil")
        local var2
        success, var2 = module.LoadAsset(assetId)
        if success and var2 then
            result = var2
        end
    else
        success, result = pcall(function()
            return AnimationClipProvider:GetAnimationClipAsync(keyframeSequenceId)
        end)
    end

    reportCounter("EmoteUtility_GetAnimationClipAsync", success)

    if success then
        return result
    end

    RbxAnalyticsService:SendEventDeferred(
        getAnalyticsTarget(),
        "EmoteUtility_GetAnimationClip",
        "EmoteUtility_GetAnimationClip_GetAnimationClipAsyncFailed",
        { keyframeSequenceId = keyframeSequenceId }
    )
    return nil
end

local function getControlNames(mainThumbnailKeyframe)
    local controlNames = {}
    for _, descendant in mainThumbnailKeyframe:GetDescendants() do
        if descendant:IsA("NumberPose") and descendant.Parent and descendant.Parent:IsA("Folder") then
            controlNames[descendant.Name] = true
        end
    end
    return controlNames
end

local function getThumbnailKeyframeFromAnimationOrUrl(keyframeSequenceId, num1: number, num2: number?)
    local numberValueWithDefault = nil
    local var1

    if typeof(keyframeSequenceId) == "string" then
        var1 = getAnimationClipByAssetId(keyframeSequenceId)
    else
        num2 = module.GetNumberValueWithDefault(keyframeSequenceId, "ThumbnailKeyframe", num2)
        numberValueWithDefault = module.GetNumberValueWithDefault(keyframeSequenceId, "ThumbnailTime", nil)
        var1 = module.GetAnimationClip(keyframeSequenceId)
    end
    if not var1 then
        return nil
    end

    local animationRigData = var1:FindFirstChildOfClass("AnimationRigData")
    if var1:IsA("KeyframeSequence") then
        return module.GetThumbnailKeyframe(num2, var1, num1), animationRigData
    end

    if var1:IsA("CurveAnimation") then
        return module.GetThumbnailKeyframeFromCurve(numberValueWithDefault, var1, num1), animationRigData
    end
    error("Unsupported Animation type:" .. var1.ClassName)
    return nil
end

local function trySetProperty(arg1, name: string, arg2) -- Luacid: Inlined by compiler; 1 call site recovered
    pcall(function()
        arg1[name] = arg2
    end)
end

local function applyControlsFolder(arg1, arg2, arg3, tbl2)
    if not arg2 then
        return
    end
    assert(arg2, "parentPose is non-nil. Silence type checker.")

    local var1 = arg1:FindFirstChild(arg2.Name)
    if not var1 then
        return
    end

    local var2 = var1:FindFirstChild(arg3.Name)
    if not var2 then
        return
    end

    for _, child in arg3:GetChildren() do
        if child:IsA("NumberPose") and not (bool6 and tbl2 and tbl2[child.Name]) then
            trySetProperty(var2, child.Name, child.Value)
        end
    end
end

local function applyKeyframeControls(arg1, moodKeyframe, moodSkippedControls)
    local function recurApplyControls(arg2, arg3)
        if arg3:IsA("Folder") then
            applyControlsFolder(arg1, arg2, arg3, if bool6 then moodSkippedControls else nil)
            return
        end

        for _, child in arg3:GetChildren() do
            recurApplyControls(arg3, child)
        end
    end

    if not moodKeyframe then
        return
    end

    for _, value in moodKeyframe:GetPoses() do
        recurApplyControls(nil, value)
    end
end

local function applyKeyframeInner(arg1, arg2, tbl2)
    local function recurApplyPoses(arg3, arg4)
        if arg3 and arg4:IsA("Pose") then
            local var1 = arg1:FindFirstChild(arg3.Name)
            local var2 = arg1:FindFirstChild(arg4.Name)
            local jointBetween = module.GetJointBetween(var1, var2)
            local var3 = jointBetween and not tbl1[jointBetween]

            if var3 then
                assert(jointBetween, "joint is non-nil. Silence type checker.")

                jointBetween.Transform = arg4.CFrame
                blacklistJoint(jointBetween)
            end
        end

        if arg4:IsA("Folder") then
            applyControlsFolder(arg1, arg3, arg4, if bool6 then tbl2 else nil)
            return
        end

        for _, child in arg4:GetChildren() do
            recurApplyPoses(arg4, child)
        end
    end

    if not arg2 then
        return
    end

    for _, value in pairs(arg2:GetPoses()) do
        if value:IsA("Folder") then
            continue
        end

        for _, child in value:GetChildren() do
            recurApplyPoses(value, child)
        end
    end
end

local function getRotatedKeyframe(arg1, num1: number?)
    if not num1 or num1 == 0 then
        return arg1
    end
    assert(num1, "rotationDegrees is non-nil. Silence type checker.")

    local argClone = arg1:Clone()

    local var1 = argClone:GetPoses()[1]
    if var1 then
        local var2 = var1:GetSubPoses()[1]
        if var2 then
            var2.CFrame *= CFrame.Angles(0, math.rad(num1), 0)
        end
    end

    return argClone
end

local function getRotationCFrame(rotation, time: number)
    if rotation:IsA("EulerRotationCurve") then
        return rotation:GetRotationAtTime(time)
    end

    if rotation:IsA("RotationCurve") then
        return rotation:GetValueAtTime(time)
    end
    error("Unsupported rotation type:" .. rotation.ClassName)
    return nil
end

local function findAttachmentsRecur(arg1, tbl2)
    for _, child in pairs(arg1:GetChildren()) do
        if child:IsA("Attachment") then
            tbl2[child.Name] = child
        elseif not (child:IsA("Tool") or child:IsA("Accoutrement")) then
            findAttachmentsRecur(child, tbl2)
        end
    end
end

local function findAttachmentsInTool(tool) -- Luacid: Inlined by compiler; 1 call site recovered
    local attachmentsInTool = {}
    findAttachmentsRecur(tool, attachmentsInTool)
    return attachmentsInTool
end

local function findAttachmentsInCharacter(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    local attachmentsInCharacter = {}
    findAttachmentsRecur(arg1, attachmentsInCharacter)
    return attachmentsInCharacter
end

local function weldAttachments(arg1, arg2): Weld -- Luacid: Inlined by compiler; 1 call site recovered
    local weld = Instance.new("Weld")
    weld.Part0 = arg1.Parent
    weld.Part1 = arg2.Parent
    weld.C0 = arg1.CFrame
    weld.C1 = arg2.CFrame
    weld.Parent = arg1.Parent
    return weld
end

local function attachToolToCharacter(arg1, humanoid, tool)
    local attachmentsInCharacter = findAttachmentsInCharacter(arg1)
    local attachmentsInTool = findAttachmentsInTool(tool)
    local bool7 = false
    for _, value in pairs(attachmentsInTool) do
        local var1 = attachmentsInCharacter[value.Name]
        if var1 then
            local _weld = weldAttachments(var1, value)
            bool7 = true
        end
    end

    if bool7 then
        tool.Parent = arg1
        return
    end
    tool.Parent = nil
    local handle = tool:FindFirstChild("Handle")
    local grip = tool.Grip
    if handle and grip then
        local rightGripAttachment = attachmentsInCharacter.RightGripAttachment
        if rightGripAttachment then
            handle.CFrame = rightGripAttachment.Parent.CFrame * rightGripAttachment.CFrame * grip:Inverse()
        end
    end
    humanoid:EquipTool(tool)
end

local function getToolBodyLayersInPriorityOrder(tbl2)
    local toolBodyLayersInPriorityOrder = {}
    local function addLayer(keyframe, sourceRig) -- Luacid: Inlined by compiler; 4 call sites recovered
        if keyframe then
            table.insert(toolBodyLayersInPriorityOrder, { keyframe = keyframe, sourceRig = sourceRig })
        end
    end
    if tbl2.suggestedKeyframeFromTool then
        addLayer(tbl2.suggestedKeyframeFromTool, tbl2.suggestedToolSourceRig)

        addLayer(tbl2.poseKeyframe, tbl2.poseSourceRig)

        return toolBodyLayersInPriorityOrder
    end

    addLayer(tbl2.defaultToolKeyframe, tbl2.defaultToolSourceRig)

    if tbl2.originalAnimationAssetId ~= nil then
        addLayer(tbl2.poseKeyframe, tbl2.poseSourceRig)
    end

    return toolBodyLayersInPriorityOrder
end

local function applyR15KeyframeWithTool(arg1, humanoid, tool, tbl2)
    for _, value in getToolBodyLayersInPriorityOrder(tbl2) do
        applyKeyframeInner(arg1, value.keyframe)
    end

    attachToolToCharacter(arg1, humanoid, tool)
end

local function rotationBetween(vec1: vector, vec2: vector)
    local var1 = vec1:Cross(vec2)
    if var1.Magnitude < 1e-6 then
        return CFrame.new()
    end
    return CFrame.fromAxisAngle(var1.Unit, math.atan2(var1.Magnitude, (vec1:Dot(vec2))))
end

local function asAnimatableJoint(arg1) -- Luacid: Inlined by compiler; 5 call sites recovered
    if arg1 and arg1:IsA("Motor6D") then
        return arg1
    end

    if arg1 and arg1:IsA("AnimationConstraint") and arg1.Attachment0 and arg1.Attachment1 then
        return arg1
    end

    return nil
end

local function findJointInPart(arg1, str3: string, str4: string) -- Luacid: Inlined by compiler; 3 call sites recovered
    local var1 = arg1:FindFirstChild(str3)
    return asAnimatableJoint(var1 and var1:FindFirstChild(str4))
end

local function findBodyJoint(arg1, name: string)
    for _, child in arg1:GetChildren() do
        if not child:IsA("BasePart") then
            continue
        end

        local var1 = child:FindFirstChild(name, true)

        if var1 and (var1:IsA("Bone") or asAnimatableJoint(var1)) then
            return var1
        end
    end

    return nil
end

local function getJointLocalFrames(jointInPart) -- Luacid: Inlined by compiler; 3 call sites recovered
    if jointInPart:IsA("Motor6D") then
        return jointInPart.C0, jointInPart.C1
    end
    local function inPart(arg1)
        local cFrame = arg1.CFrame
        local parent = arg1.Parent
        while parent and parent:IsA("Bone") do
            cFrame = parent.CFrame * cFrame
            parent = parent.Parent
        end
        return cFrame
    end

    return inPart(jointInPart.Attachment0), (inPart(jointInPart.Attachment1))
end

local function getArmRestGeometry(arg1, str3: string)
    local jointInPart = findJointInPart(arg1, str3 .. "UpperArm", str3 .. "Shoulder")
    local jointInPart2 = findJointInPart(arg1, str3 .. "LowerArm", str3 .. "Elbow")
    local jointInPart3 = findJointInPart(arg1, str3 .. "Hand", str3 .. "Wrist")
    if not (jointInPart and jointInPart2 and jointInPart3) then
        return nil
    end

    local shoulderFrame, var2 = getJointLocalFrames(jointInPart)
    local var3, var4 = getJointLocalFrames(jointInPart2)
    local var5, _ = getJointLocalFrames(jointInPart3)
    local var6 = shoulderFrame * var2:Inverse()
    local elbowFrame = var6 * var3
    local var8 = elbowFrame * var4:Inverse()
    local var9 = var8 * var5
    return {
        shoulderFrame = shoulderFrame,
        elbowFrame = elbowFrame,
        upperDirection = (elbowFrame.Position - var6.Position).Unit,
        lowerDirection = (var9.Position - var8.Position).Unit
    }
end

local function ensureRigDescription(parent): boolean
    if parent:FindFirstChildWhichIsA("HumanoidRigDescription", true) then
        return false
    end

    local humanoidRigDescription = Instance.new("HumanoidRigDescription")

    local jointNames = humanoidRigDescription:GetJointNames()
    for _, enumItem in Enum.RigLabel:GetEnumItems() do
        if not table.find(jointNames, enumItem.Name) then
            continue
        end

        local bodyJoint = findBodyJoint(parent, enumItem.Name)
        if bodyJoint then
            humanoidRigDescription:SetJoint(enumItem, bodyJoint)
        end
    end

    for _, value in {
        {
            name = "Right",
            outward = Vector3.new(1, 0, 0),
            shoulder = Enum.RigLabel.RightShoulder,
            elbow = Enum.RigLabel.RightElbow
        },
        {
            name = "Left",
            outward = vector.create(-1, -0, -0, -0),
            shoulder = Enum.RigLabel.LeftShoulder,
            elbow = Enum.RigLabel.LeftElbow
        }
    } do
        local armRestGeometry = getArmRestGeometry(parent, value.name)
        if armRestGeometry then
            humanoidRigDescription:SetTposeAdjustment(
                value.shoulder,
                rotationBetween(
                    armRestGeometry.shoulderFrame:VectorToObjectSpace(armRestGeometry.upperDirection),
                    armRestGeometry.shoulderFrame:VectorToObjectSpace(value.outward)
                )
            )
            humanoidRigDescription:SetTposeAdjustment(
                value.elbow,
                rotationBetween(
                    armRestGeometry.elbowFrame:VectorToObjectSpace(armRestGeometry.lowerDirection),
                    armRestGeometry.elbowFrame:VectorToObjectSpace(armRestGeometry.upperDirection)
                )
            )
        end
    end

    humanoidRigDescription.Parent = parent
    return true
end

local function restsArmsDown(arg1)
    for _, value in { "Right", "Left" } do
        local armRestGeometry = getArmRestGeometry(arg1, value)
        if armRestGeometry
            and math.deg(math.acos(math.clamp(armRestGeometry.upperDirection:Dot(vector.create(-0, -1, -0, -0)), -1, 1))) > 30
        then
            return false
        end
    end

    return true
end

module.RestsArmsDown = restsArmsDown
module.EnsureRigDescription = ensureRigDescription

local var1 = nil

local function loadCanonicalR15Rig()
    if var1 then
        return
    end
    local success, result = pcall(function(): Instance
        return game:GetObjects(str2)[1]
    end)
    local var2 = nil
    if success and result and result:IsA("Model") then
        ensureRigDescription(result)
        local animationRigData = Instance.new("AnimationRigData")
        if animationRigData:LoadFromModel(result) then
            var2 = animationRigData
        end
    end

    local counterName = getAnalyticsTarget() .. "_" .. "EmoteUtility_GetCanonicalR15Rig" .. "_" .. (if var2 ~= nil then "Success" else "Failure")
    RbxAnalyticsService:ReportCounter(counterName)

    var1 = var2
end

local tbl2 = {
    Enum.AnimationPriority.Action4,
    Enum.AnimationPriority.Action3,
    Enum.AnimationPriority.Action2,
    Enum.AnimationPriority.Action,
    Enum.AnimationPriority.Movement,
    Enum.AnimationPriority.Idle
}

local var2 = (setmetatable({}, { __mode = "k" }))

local function stopRetargetedTracks(arg1)
    local var3 = var2[arg1]
    if not var3 then
        return
    end
    for _, value in var3 do
        value:Stop(0)
        value:Destroy()
    end
    var2[arg1] = nil
end

local function applyKeyframesRetargeted(arg1, humanoid, tbl3)
    local tbl4 = ({})
    for value, value2 in tbl3 do
        local var3 = value2.sourceRig or var1
        if not var3 then
            return false
        end
        tbl4[value] = var3
    end

    for _, descendant in arg1:GetDescendants() do
        if descendant:IsA("AnimationConstraint") then
            descendant.Enabled = true
        end
    end

    local animator = humanoid:FindFirstChildOfClass("Animator")
    if ensureRigDescription(arg1) and animator then
        animator:Destroy()
        animator = nil
    end

    if not animator then
        animator = Instance.new("Animator")
        animator.Parent = humanoid
    end

    assert(animator, "animator is non-nil. Silence type checker.")

    stopRetargetedTracks(arg1)
    local tbl5 = {}
    var2[arg1] = tbl5
    local num1 = 1
    for value, value2 in tbl3 do
        local keyframeSequence = Instance.new("KeyframeSequence")
        for _, time in { 0, 1 } do
            local keyframeClone = value2.keyframe:Clone()
            keyframeClone.Time = time
            keyframeClone.Parent = keyframeSequence
        end
        tbl4[value]:Clone().Parent = keyframeSequence

        local animation = Instance.new("Animation")
        animation.AnimationId = AnimationClipProvider:RegisterActiveAnimationClip(keyframeSequence)
        local animationResult = animator:LoadAnimation(animation)
        animationResult.Priority = tbl2[math.min(num1, #tbl2)]
        animationResult:Play(0)
        table.insert(tbl5, animationResult)
        num1 += 1
    end
    animator:StepAnimations(1 / 30)
    return true
end

local function getMainThumbnailKeyframe(arg1, originalAnimationAssetId, bool7: boolean, bool8: boolean?)
    local var3 = nil
    local var4 = nil
    local bool9 = false
    local var5 = nil

    if originalAnimationAssetId then
        local var6, var7 = getAnimationAndIsIdle(originalAnimationAssetId)

        if var6 == nil then
            return nil, bool9, originalAnimationAssetId
        end
        assert(var6, "animation is non-nil. Silence type checker.")

        if not var7 then
            bool9 = true
        end

        local var8 = if bool7 then module.GetNumberValueWithDefault(var6, "ThumbnailCharacterRotation", 0) else 0

        var3, var4 = getThumbnailKeyframeFromAnimationOrUrl(var6, var8)
        var5 = originalAnimationAssetId
    elseif bool8 then
        var5 = module.FALLBACK_KEYFRAME_SEQUENCE_ASSET_URL
        local animate = arg1:FindFirstChild("Animate")
        if animate then
            local var6 = animate:FindFirstChild("Pose") or animate:FindFirstChild("pose")
            if not var6 and bool2 then
                var6 = animate:FindFirstChild("Idle") or animate:FindFirstChild("idle")
            end

            var5 = (if var6 then var6:FindFirstChildOfClass("Animation") else nil) or var5
        end

        var3, var4 = getThumbnailKeyframeFromAnimationOrUrl(var5, 0, 1)
        if typeof(var5) ~= "string" then
            var5 = var5.AnimationId
        end
    end

    return var3, bool9, var5, var4
end

local function getMoodThumbnailKeyframe(animationAssetIdOrUrl) -- Luacid: Inlined by compiler; 3 call sites recovered
    if not animationAssetIdOrUrl then
        return nil
    end
    assert(animationAssetIdOrUrl, "moodAssetId is non-nil. Silence type checker.")

    local var3, _ = getAnimationAndIsIdle(animationAssetIdOrUrl)

    if var3 == nil then
        return nil
    end
    assert(var3, "animation is non-nil. Silence type checker.")

    return getThumbnailKeyframeFromAnimationOrUrl(var3, 0)
end

local function getToolKeyframes(arg1, bool7: boolean)
    local thumbnailPose = nil
    local thumbnailKeyframe = nil
    local var3 = nil
    local var4 = nil
    local tool = arg1:FindFirstChildOfClass("Tool")
    if not tool then
        return nil, nil
    end
    assert(tool, "tool is non-nil. Silence type checker.")

    local bool8 = false
    if not bool7 then
        thumbnailPose = tool:FindFirstChild("ThumbnailPose")
        if thumbnailPose and thumbnailPose:IsA("Keyframe") then
            var3 = thumbnailPose:FindFirstChildOfClass("AnimationRigData")
            bool8 = true
        end
    end

    if not bool8 then
        thumbnailPose = nil
        local animate = arg1:FindFirstChild("Animate")
        if not animate then
            return nil, nil
        end
        assert(animate, "animateScript is non-nil. Silence type checker.")
        local toolnone = animate:FindFirstChild("toolnone")
        if not toolnone then
            return nil, nil
        end
        assert(toolnone, "toolNoneStringValue is non-nil. Silence type checker.")
        local toolNoneAnim = toolnone:FindFirstChild("ToolNoneAnim")
        if toolNoneAnim then
            local animationClip = module.GetAnimationClip(toolNoneAnim)
            if not animationClip then
                return nil, nil
            end
            assert(animationClip, "toolAnimationClip is non-nil. Silence type checker.")
            assert(animationClip:IsA("KeyframeSequence"), "ToolNoneAnim must be a KeyframeSequence")

            thumbnailKeyframe = module.GetThumbnailKeyframe(nil, animationClip, 0)
            var4 = animationClip:FindFirstChildOfClass("AnimationRigData")

            if not tool:IsDescendantOf(arg1) then
                return nil, nil
            end
        end
    end

    return thumbnailPose, thumbnailKeyframe, var3, var4
end

local function getAttachmentCFrame(attachment: Attachment)
    local attachmentCFrame = attachment.CFrame
    local attachmentParent = attachment.Parent

    while attachmentParent and attachmentParent:IsA("Bone") do
        if bool4 then
            attachmentCFrame = attachmentParent.CFrame * attachmentParent.Transform * attachmentCFrame
        else
            attachmentCFrame = attachmentParent.CFrame * attachmentCFrame
        end
        attachmentParent = attachmentParent.Parent
    end
    return attachmentCFrame
end

local function getJointParts(arg1)
    if arg1:IsA("JointInstance") then
        return arg1.Part0, arg1.Part1
    end

    if not arg1:IsA("Constraint") then
        return nil, nil
    end

    local attachment0 = arg1.Attachment0
    local attachment1 = arg1.Attachment1
    return attachment0 and attachment0:FindFirstAncestorWhichIsA("BasePart"), attachment1 and attachment1:FindFirstAncestorWhichIsA("BasePart")
end

local function applyCFrame(part0, part1, joint, cFrame: CFrame)
    if joint:IsA("AnimationConstraint") then
        local attachment0 = joint.Attachment0
        local attachment1 = joint.Attachment1
        part1.CFrame = part0.CFrame * getAttachmentCFrame(attachment0) * cFrame * getAttachmentCFrame(attachment1):Inverse()
    elseif joint:IsA("Motor6D") then
        local c0 = joint.C0
        local c1 = joint.C1
        part1.Anchored = true
        part1.CFrame = part0.CFrame * c0 * cFrame * c1:Inverse()
    end
end

local function getJointPose(joint)
    if joint:IsA("AnimationConstraint") then
        return joint.Transform
    end

    if not joint:IsA("Motor6D") then
        error("Unsupported joint type:" .. joint.ClassName)
        return CFrame.new()
    end

    local transform = joint.Transform
    if joint.CurrentAngle ~= 0 then
        transform *= CFrame.Angles(0, 0, joint.CurrentAngle)
    end
    return transform
end

function module.ForceAnimationToStep(arg1)
    local tbl3 = { (arg1:FindFirstChild("HumanoidRootPart")) }
    local tbl4 = ({})
    local tbl5 = {}

    while #tbl3 > 0 do
        local part0 = table.remove(tbl3, 1)
        if tbl4[part0] then
            continue
        end

        tbl4[part0] = true

        for _, joint in part0:GetJoints() do
            if not (joint:IsA("Motor6D") or joint:IsA("AnimationConstraint")) then
                continue
            end

            local var4, part1 = getJointParts(joint)
            if var4 ~= part0 or not part1 or tbl4[part1] then
                continue
            end

            table.insert(tbl5, { part0 = part0, part1 = part1, joint = joint })
            table.insert(tbl3, part1)
        end
    end

    for _, descendant in arg1:GetDescendants() do
        if descendant:IsA("AnimationConstraint") then
            descendant.Enabled = false
        end
    end

    for _, value in tbl5 do
        local joint = value.joint
        if joint:IsA("Motor6D") or joint:IsA("AnimationConstraint") then
            local jointPose = getJointPose(joint)
            applyCFrame(value.part0, value.part1, joint, jointPose)
        end
    end
end

function module.LoadAsset(assetId: number)
    local success, result = pcall(function()
        if not (module.debugLoadAssetsFromFiles and module.mapAssetIdToFileName) then
            return InsertService:LoadAsset(assetId)
        end

        local assetPath = "rbxasset://" .. module.mapAssetIdToFileName(assetId)
        return InsertService:LoadLocalAsset(assetPath)
    end)

    return success, result
end

function module.SetDebugLoadAssetsFromFiles(debugLoadAssetsFromFiles: boolean, mapAssetIdToFileName: (...any) -> (...any))
    module.debugLoadAssetsFromFiles = debugLoadAssetsFromFiles
    module.mapAssetIdToFileName = mapAssetIdToFileName
end

function module.GetJointBetween(part0, arg1)
    if not (part0 and arg1) then
        return nil
    end
    assert(part0, "part0 is non-nil. Silence type checker.")
    assert(arg1, "part1 is non-nil. Silence type checker.")

    for _, child in arg1:GetChildren() do
        if child:IsA("Motor6D") and child.Part0 == part0 then
            return child
        end

        if child:IsA("AnimationConstraint") and child.Part0 == part0 then
            return child
        end
    end

    return nil
end

module.GetMotor6DBetween = module.GetJointBetween

function module.PoseKeyframeHasFaceAnimation(arg1)
    if not arg1 then
        return false
    end
    assert(arg1, "poseKeyframe is non-nil. Silence type checker.")

    local function recurHasFaceAnimation(arg2)
        if arg2:IsA("Folder") then
            return true
        end
        for _, child in arg2:GetChildren() do
            if recurHasFaceAnimation(child) then
                return true
            end
        end

        return false
    end

    for _, value in pairs(arg1:GetPoses()) do
        if recurHasFaceAnimation(value) then
            return true
        end
    end
    return false
end

function module.ApplyKeyframe(arg1, arg2)
    clearJointBlacklist()
    applyKeyframeInner(arg1, arg2)
    clearJointBlacklist()

    if isOnRCC() then
        module.ForceAnimationToStep(arg1)
    end
end

function module.GetNumberValueWithDefault(arg1, str3: string, num1: number?): number?
    local var3 = arg1:FindFirstChild(str3)
    if var3 and var3:IsA("NumberValue") then
        num1 = var3.Value
    end
    return num1
end

function module.GetAnimationClip(arg1)
    if arg1:IsA("KeyframeSequence") then
        return arg1
    end

    if arg1:IsA("CurveAnimation") then
        return arg1
    end

    if arg1:IsA("Animation") then
        return (getAnimationClipByAssetId(arg1.AnimationId))
    end
    error("Cannot get AnimationClip from type:" .. arg1.ClassName)
    return nil
end

function module.GetThumbnailKeyframe(num1: number?, arg1, num2: number)
    local keyframes = arg1:GetKeyframes()
    local var3 = if num1 and num1 > 0 and num1 <= #keyframes then keyframes[num1] else keyframes[math.ceil(#keyframes / 2)]
    return (getRotatedKeyframe(var3, num2))
end

function module.GetCurveAnimationTimeLength(arg1): number
    local num1 = 0

    for _, descendant in arg1:GetDescendants() do
        if descendant:IsA("FloatCurve") and descendant.Length ~= 0 then
            num1 = math.max(num1, descendant:GetKeyAtIndex(descendant.Length).Time)
        end
    end

    return num1
end

function module.GetThumbnailKeyframeFromCurve(time: number?, arg1, num2: number)
    local curveAnimationTimeLength = module.GetCurveAnimationTimeLength(arg1)

    time = time and not (time < 0 or curveAnimationTimeLength < time) and time or curveAnimationTimeLength / 2

    assert(time, "thumbnailTime should be non-nil. Silence type checker")

    local tbl3 = { Position = true, Rotation = true }

    local function hasSubFolders(arg2) -- Luacid: Inlined by compiler; 1 call site recovered
        for _, child in arg2:GetChildren() do
            if child:IsA("Folder") then
                return true
            end
        end
        return false
    end

    local function recurGenerateKeyframe(arg2, arg3)
        local var3 = nil

        local position = arg3:FindFirstChild("Position")
        local rotation = arg3:FindFirstChild("Rotation")

        if if bool5 then position or rotation else position and rotation then
            local var4 = if rotation then getRotationCFrame(rotation, time) else CFrame.new()

            if not var4 and bool5 then
                var4 = CFrame.new()
            end
            if var4 then
                if position then
                    var4 += Vector3.new(table.unpack(position:GetValueAtTime(time)))
                end

                var3 = Instance.new("Pose")
                var3.CFrame = var4
                var3.Name = arg3.Name
                var3.Parent = arg2
            end
        elseif hasSubFolders(arg3) then
            local cFrame = CFrame.new()

            var3 = Instance.new("Pose")
            var3.CFrame = cFrame
            var3.Name = arg3.Name
            var3.Parent = arg2
        else
            var3 = Instance.new("Folder")
            var3.Name = arg3.Name
            var3.Parent = arg2
        end

        for _, child in arg3:GetChildren() do
            if child:IsA("FloatCurve") and not tbl3[child] then
                local numberPose = Instance.new("NumberPose")
                numberPose.Name = child.Name
                local numberPoseValue = child:GetValueAtTime(time) or 0

                assert(numberPoseValue, "valueAtTime should be non-nil. Silence type checker.")
                numberPose.Value = numberPoseValue
                numberPose.Parent = var3
            elseif child:IsA("Folder") then
                recurGenerateKeyframe(var3, child)
            end
        end
    end

    local keyframe = Instance.new("Keyframe")
    keyframe.Name = arg1.Name
    keyframe.Time = time
    for _, child in arg1:GetChildren() do
        if child:IsA("Folder") then
            recurGenerateKeyframe(keyframe, child)
        end
    end

    return (getRotatedKeyframe(keyframe, num2))
end

function module.ClearPlayerCharacterFace(arg1)
    local var3 = arg1:FindFirstChildWhichIsA("FaceControls", true)
    if not var3 then
        return
    end

    local parent = var3.Parent
    local children = var3:GetChildren()
    local faceControls = Instance.new("FaceControls")
    faceControls.Parent = parent
    for _, child in children do
        child.Parent = faceControls
    end
    var3:Destroy()
end

function module.AdjustArmOnR6ForTool(arg1)
    local tool = arg1:FindFirstChildOfClass("Tool")
    local torso = arg1:FindFirstChild("Torso")
    if not torso then
        return
    end

    local rightShoulder = torso:FindFirstChild("Right Shoulder")
    if not rightShoulder then
        return
    end

    if tool then
        rightShoulder.CurrentAngle = math.pi / 2
        rightShoulder.DesiredAngle = math.pi / 2
        return
    end
    rightShoulder.CurrentAngle = 0
    rightShoulder.DesiredAngle = 0
end

function module.SetPlayerCharacterFace(arg1, animationAssetIdOrUrl)
    if not animationAssetIdOrUrl or animationAssetIdOrUrl == "" or animationAssetIdOrUrl == 0 then
        return
    end

    assert(
        typeof(animationAssetIdOrUrl) == "number" or typeof(animationAssetIdOrUrl) == "string",
        "EmoteUtility.SetPlayerCharacterFace expects animationAssetIdOrUrl to be a number or string"
    )

    if not arg1:FindFirstChildOfClass("Humanoid") then
        return
    end

    local moodThumbnailKeyframe = getMoodThumbnailKeyframe(animationAssetIdOrUrl)

    if not moodThumbnailKeyframe then
        return
    end

    module.ClearPlayerCharacterFace(arg1)
    module.ApplyKeyframe(arg1, moodThumbnailKeyframe)
end

function module.SetPlayerCharacterNeutralPose(arg1)
    local humanoid = arg1:FindFirstChildOfClass("Humanoid")
    if not humanoid then
        return
    end
    assert(humanoid, "humanoid should be non-nil. Silence type checker.")

    humanoid:BuildRigFromAttachments()

    if humanoid.RigType ~= Enum.HumanoidRigType.R15 then
        return
    end

    module.ClearPlayerCharacterFace(arg1)

    local function recurResetJoint(arg2)
        if arg2:IsA("Motor6D") or arg2:IsA("AnimationConstraint") or bool4 and arg2:IsA("Bone") then
            arg2.Transform = CFrame.new()
        end

        for _, child in (arg2:GetChildren()) do
            recurResetJoint(child)
        end
    end

    recurResetJoint(arg1)
end

function module.FindDefaultMoodAnimationId(arg1)
    local animate = arg1:FindFirstChild("Animate")
    if not animate then
        return nil
    end

    local mood = animate:FindFirstChild("mood")
    if not mood then
        return nil
    end

    local animation = mood:FindFirstChildOfClass("Animation")
    return if animation and animation.AnimationId ~= "" then animation.AnimationId else nil
end

local function loadKeyframesForPoseR15(arg1, originalAnimationAssetId: number?, animationAssetIdOrUrl: number?, bool7: boolean?, bool8: boolean?)
    local tbl3 = { originalAnimationAssetId = originalAnimationAssetId }

    local bool9 = not bool8

    if bool4 and isOnRCC() then
        loadCanonicalR15Rig()
    end

    local poseKeyframe, var4, finalAnimationAssetIdOrUrl, poseSourceRig = getMainThumbnailKeyframe(arg1, originalAnimationAssetId, not bool7, bool9)
    local var7, var8, var9, var10

    if bool8 or not poseKeyframe then
        var7 = nil
        var8 = nil
        var9 = nil
        var10 = nil
    else
        var8, var7, var10, var9 = getToolKeyframes(arg1, var4)
    end

    local thumbnailKeyframe = nil
    local var11 = nil

    local bool10 = false
    if bool1 or animationAssetIdOrUrl and animationAssetIdOrUrl ~= 0 then
        if bool6 then
            bool10 = true
            tbl3.moodSkippedControls = if var4 and poseKeyframe then getControlNames(poseKeyframe) else nil
        elseif originalAnimationAssetId == nil or not module.PoseKeyframeHasFaceAnimation(poseKeyframe) then
            bool10 = true
        end
    end

    if bool10 then
        if bool1 then
            if animationAssetIdOrUrl and animationAssetIdOrUrl ~= 0 then
                thumbnailKeyframe, var11 = getMoodThumbnailKeyframe(animationAssetIdOrUrl)
            end

            if not thumbnailKeyframe then
                local defaultMoodAnimationId = module.FindDefaultMoodAnimationId(arg1)
                if defaultMoodAnimationId then
                    local animationClipByAssetId = getAnimationClipByAssetId(defaultMoodAnimationId)
                    if animationClipByAssetId and animationClipByAssetId:IsA("KeyframeSequence") then
                        thumbnailKeyframe = module.GetThumbnailKeyframe(nil, animationClipByAssetId, 0)
                        var11 = animationClipByAssetId:FindFirstChildOfClass("AnimationRigData")
                    end
                end
            end
        else
            thumbnailKeyframe, var11 = getMoodThumbnailKeyframe(animationAssetIdOrUrl)
        end
    end

    tbl3.poseKeyframe = poseKeyframe
    tbl3.moodKeyframe = thumbnailKeyframe
    tbl3.defaultToolKeyframe = var7
    tbl3.suggestedKeyframeFromTool = var8
    tbl3.finalAnimationAssetIdOrUrl = finalAnimationAssetIdOrUrl
    tbl3.poseSourceRig = poseSourceRig
    tbl3.moodSourceRig = var11
    tbl3.defaultToolSourceRig = var9
    tbl3.suggestedToolSourceRig = var10

    return tbl3
end

function module.LoadKeyframesForPose(arg1, originalAnimationAssetId: number?, animationAssetIdOrUrl: number?, bool7: boolean?, bool8: boolean?)
    assert(arg1, "character should be non-nil")
    if originalAnimationAssetId ~= nil then
        assert(
            typeof(originalAnimationAssetId) == "number",
            "EmoteUtility.LoadKeyframesForPose expects animationAssetId to be a number or nil"
        )

        assert(
            originalAnimationAssetId > 0,
            "EmoteUtility.LoadKeyframesForPose expects animationAssetId to be a real asset ID (positive number)"
        )
    end

    if animationAssetIdOrUrl ~= nil then
        assert(
            typeof(animationAssetIdOrUrl) == "number",
            "EmoteUtility.LoadKeyframesForPose expects moodAssetId to be a number or nil"
        )
    end

    local humanoid = arg1:FindFirstChildOfClass("Humanoid")
    if not humanoid then
        return nil
    end
    assert(humanoid, "humanoid should be non-nil. Silence type checker.")

    if humanoid.RigType == Enum.HumanoidRigType.R15 then
        return (loadKeyframesForPoseR15(arg1, originalAnimationAssetId, animationAssetIdOrUrl, bool7, bool8))
    end

    return { originalAnimationAssetId = originalAnimationAssetId }
end

function module.ApplyKeyframesForPose(arg1, tbl3)
    assert(arg1, "character should be non-nil")
    if not tbl3 then
        return
    end
    assert(tbl3, "keyframesForPose should be non-nil. Silence type checker.")

    local humanoid = arg1:FindFirstChildOfClass("Humanoid")
    if not humanoid then
        return
    end
    assert(humanoid, "humanoid should be non-nil. Silence type checker.")

    module.SetPlayerCharacterNeutralPose(arg1)
    clearJointBlacklist()
    local tool = arg1:FindFirstChildOfClass("Tool")
    local bool7 = false

    local bool8 = bool4

    if bool8 then
        if humanoid.RigType == Enum.HumanoidRigType.R15 then
            bool8 = isOnRCC()

            if bool8 then
                bool8 = not restsArmsDown(arg1)

                if not bool8 then
                    if tool == nil or tbl3.suggestedKeyframeFromTool == nil then
                        bool8 = false
                    else
                        bool8 = tbl3.suggestedToolSourceRig ~= nil
                    end
                end
            end
        else
            bool8 = false
        end
    end
    if bool8 then
        local tbl4 = not tool and {} or getToolBodyLayersInPriorityOrder(tbl3)
        if not tool and tbl3.poseKeyframe then
            table.insert(tbl4, { keyframe = tbl3.poseKeyframe, sourceRig = tbl3.poseSourceRig })
        end

        if tbl3.moodKeyframe then
            table.insert(tbl4, { keyframe = tbl3.moodKeyframe, sourceRig = tbl3.moodSourceRig })
        end

        bool7 = applyKeyframesRetargeted(arg1, humanoid, tbl4)
        if bool7 and tool then
            attachToolToCharacter(arg1, humanoid, tool)
        end
    end

    if humanoid.RigType == Enum.HumanoidRigType.R15 and not bool7 then
        if tool then
            applyR15KeyframeWithTool(arg1, humanoid, tool, tbl3)
        else
            applyKeyframeInner(arg1, tbl3.poseKeyframe)
        end
    elseif humanoid.RigType ~= Enum.HumanoidRigType.R15 then
        module.AdjustArmOnR6ForTool(arg1)
    end

    if humanoid.RigType == Enum.HumanoidRigType.R15 then
        if bool7 then
            applyKeyframeControls(arg1, tbl3.moodKeyframe, tbl3.moodSkippedControls)
        else
            applyKeyframeInner(arg1, tbl3.moodKeyframe, tbl3.moodSkippedControls)
        end
    end

    clearJointBlacklist()

    if isOnRCC() then
        module.ForceAnimationToStep(arg1)
    end
end

function module.SetPlayerCharacterPoseWithMoodFallback(arg1, originalAnimationAssetId: number?, animationAssetIdOrUrl: number?, bool7: boolean?, bool8: boolean?)
    local humanoid = arg1:FindFirstChildOfClass("Humanoid")
    if not humanoid then
        return
    end

    assert(humanoid, "humanoid should be non-nil.  Silence type checker.")

    local var3 = module.LoadKeyframesForPose(arg1, originalAnimationAssetId, animationAssetIdOrUrl, bool7, bool8)
    module.ApplyKeyframesForPose(arg1, var3)

    if bool3 and var3 then
        if humanoid.RigType == Enum.HumanoidRigType.R15 and originalAnimationAssetId ~= nil and var3.poseKeyframe == nil then
            return "Failed to download requested pose animation"
        end

        return nil
    end

    return nil
end

function module.ThumbnailZoomExtents(model, num1: number, x: number, num2: number, num3: number)
    local modelCFrame = model:GetModelCFrame()
    local lookVector = modelCFrame.LookVector

    local humanoidRootPart = model:FindFirstChild("HumanoidRootPart")
    if humanoidRootPart then
        lookVector = humanoidRootPart.CFrame.LookVector
    end

    local cFrame = CFrame.new(modelCFrame.Position + lookVector * 5, modelCFrame.Position)

    local var3 = modelCFrame.Position + Vector3.new(x, -num2, 0)

    local num4 = getCameraOffset(num1, (model:GetExtentsSize())) * (1 / num3)

    return cFrame - cFrame.Position + var3 + lookVector * num4
end

return module
