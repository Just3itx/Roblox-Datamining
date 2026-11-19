-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:10:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RunService = game:GetService("RunService")

local engineFeature = game:GetEngineFeature("AvatarJointUpgradeFeature")

local module = {}

local tbl1 = {
    UpperAngle = 10,
    TwistLowerAngle = -10,
    TwistUpperAngle = 10,
    StrengthTorque = 400,
    ReferenceMass = 0.43671694397926
}

local tbl2 = {
    UpperAngle = 20,
    TwistLowerAngle = 5,
    TwistUpperAngle = 120,
    StrengthTorque = 1200,
    ReferenceMass = 0.70196455717087
}

local tbl3 = {
    UpperAngle = 30,
    TwistLowerAngle = -10,
    TwistUpperAngle = 10,
    StrengthTorque = 400,
    ReferenceMass = 0.69132566452026
}

local tbl4 = {
    UpperAngle = 5,
    TwistLowerAngle = -120,
    TwistUpperAngle = -5,
    StrengthTorque = 2000,
    ReferenceMass = 0.65389388799667
}

local tbl5 = {
    UpperAngle = 110,
    TwistLowerAngle = -85,
    TwistUpperAngle = 85,
    FrictionTorque = 600,
    StrengthTorque = 4000,
    ReferenceMass = 0.90918225049973
}

local tbl6 = {
    UpperAngle = 40,
    TwistLowerAngle = -5,
    TwistUpperAngle = 80,
    FrictionTorque = 600,
    StrengthTorque = 4000,
    ReferenceMass = 1.9175016880035
}

local tbl7 = { UpperAngle = 110, TwistLowerAngle = -85, TwistUpperAngle = 85 }

local tbl8 = { UpperAngle = 40, TwistLowerAngle = -5, TwistUpperAngle = 80 }

local vec3 = Vector3.new()

local tbl9 = {
    {
        "UpperTorso",
        "RightShoulderRagdollAttachment",
        CFrame.fromMatrix(vec3, Vector3.new(1, 0, 0), Vector3.new(0, 1, 0)),
        "RightShoulderRigAttachment"
    },
    {
        "RightUpperArm",
        "RightShoulderRagdollAttachment",
        CFrame.fromMatrix(vec3, Vector3.new(0, -1, 0), Vector3.new(1, 0, 0)),
        "RightShoulderRigAttachment"
    },
    {
        "UpperTorso",
        "LeftShoulderRagdollAttachment",
        CFrame.fromMatrix(vec3, Vector3.new(-1, 0, 0), Vector3.new(0, 1, 0)),
        "LeftShoulderRigAttachment"
    },
    {
        "LeftUpperArm",
        "LeftShoulderRagdollAttachment",
        CFrame.fromMatrix(vec3, Vector3.new(0, -1, 0), Vector3.new(-1, 0, 0)),
        "LeftShoulderRigAttachment"
    }
}
local tbl10 = {
    {
        "UpperTorso",
        "Head",
        "NeckRigAttachment",
        {
            UpperAngle = 45,
            TwistLowerAngle = -40,
            TwistUpperAngle = 40,
            FrictionTorque = 400,
            StrengthTorque = 400,
            ReferenceMass = 1.0249234437943
        }
    },
    {
        "LowerTorso",
        "UpperTorso",
        "WaistRigAttachment",
        {
            UpperAngle = 20,
            TwistLowerAngle = -40,
            TwistUpperAngle = 20,
            FrictionTorque = 750,
            StrengthTorque = 5000,
            ReferenceMass = 2.861558675766
        }
    },
    { "UpperTorso", "LeftUpperArm", "LeftShoulderRagdollAttachment", tbl5 },
    { "LeftUpperArm", "LeftLowerArm", "LeftElbowRigAttachment", tbl2 },
    { "LeftLowerArm", "LeftHand", "LeftWristRigAttachment", tbl3 },
    { "UpperTorso", "RightUpperArm", "RightShoulderRagdollAttachment", tbl5 },
    { "RightUpperArm", "RightLowerArm", "RightElbowRigAttachment", tbl2 },
    { "RightLowerArm", "RightHand", "RightWristRigAttachment", tbl3 },
    { "LowerTorso", "LeftUpperLeg", "LeftHipRigAttachment", tbl6 },
    { "LeftUpperLeg", "LeftLowerLeg", "LeftKneeRigAttachment", tbl4 },
    { "LeftLowerLeg", "LeftFoot", "LeftAnkleRigAttachment", tbl1 },
    { "LowerTorso", "RightUpperLeg", "RightHipRigAttachment", tbl6 },
    { "RightUpperLeg", "RightLowerLeg", "RightKneeRigAttachment", tbl4 },
    { "RightLowerLeg", "RightFoot", "RightAnkleRigAttachment", tbl1 }
}

local tbl11 = {
    { "LowerTorso", "LeftUpperArm" },
    { "LeftUpperArm", "LeftHand" },
    { "LowerTorso", "RightUpperArm" },
    { "RightUpperArm", "RightHand" },
    { "LeftUpperLeg", "RightUpperLeg" },
    { "UpperTorso", "RightUpperLeg" },
    { "RightUpperLeg", "RightFoot" },
    { "UpperTorso", "LeftUpperLeg" },
    { "LeftUpperLeg", "LeftFoot" },
    { "UpperTorso", "LeftLowerLeg" },
    { "UpperTorso", "RightLowerLeg" },
    { "LowerTorso", "LeftLowerLeg" },
    { "LowerTorso", "RightLowerLeg" },
    { "UpperTorso", "LeftLowerArm" },
    { "UpperTorso", "RightLowerArm" },
    { "Head", "LeftUpperArm" },
    { "Head", "RightUpperArm" }
}

local tbl12 = {
    { "Waist", "UpperTorso" },
    { "Neck", "Head" },
    { "LeftShoulder", "LeftUpperArm" },
    { "LeftElbow", "LeftLowerArm" },
    { "LeftWrist", "LeftHand" },
    { "RightShoulder", "RightUpperArm" },
    { "RightElbow", "RightLowerArm" },
    { "RightWrist", "RightHand" },
    { "LeftHip", "LeftUpperLeg" },
    { "LeftKnee", "LeftLowerLeg" },
    { "LeftAnkle", "LeftFoot" },
    { "RightHip", "RightUpperLeg" },
    { "RightKnee", "RightLowerLeg" },
    { "RightAnkle", "RightFoot" }
}

local tbl13 = {
    { "Head", "NeckAttachment", CFrame.new(0, -0.5, 0) },
    { "Torso", "RightShoulderRagdollAttachment", CFrame.fromMatrix(Vector3.new(1, 0.5, 0), Vector3.new(1, 0, 0), Vector3.new(0, 1, 0)) },
    { "Right Arm", "RightShoulderRagdollAttachment", CFrame.fromMatrix(Vector3.new(-0.5, 0.5, 0), Vector3.new(0, -1, 0), Vector3.new(1, 0, 0)) },
    { "Torso", "LeftShoulderRagdollAttachment", CFrame.fromMatrix(Vector3.new(-1, 0.5, 0), Vector3.new(-1, 0, 0), Vector3.new(0, 1, 0)) },
    { "Left Arm", "LeftShoulderRagdollAttachment", CFrame.fromMatrix(Vector3.new(0.5, 0.5, 0), Vector3.new(0, -1, 0), Vector3.new(-1, 0, 0)) },
    { "Torso", "RightHipAttachment", CFrame.new(0.5, -1, 0) },
    { "Right Leg", "RightHipAttachment", CFrame.new(0, 1, 0) },
    { "Torso", "LeftHipAttachment", CFrame.new(-0.5, -1, 0) },
    { "Left Leg", "LeftHipAttachment", CFrame.new(0, 1, 0) }
}
local tbl14 = {
    {
        "Torso",
        "Head",
        "NeckAttachment",
        { UpperAngle = 30, TwistLowerAngle = -40, TwistUpperAngle = 40 }
    },
    { "Torso", "Left Leg", "LeftHipAttachment", tbl8 },
    { "Torso", "Right Leg", "RightHipAttachment", tbl8 },
    { "Torso", "Left Arm", "LeftShoulderRagdollAttachment", tbl7 },
    { "Torso", "Right Arm", "RightShoulderRagdollAttachment", tbl7 }
}

local tbl15 = {
    { "Left Leg", "Right Leg" },
    { "Head", "Right Arm" },
    { "Head", "Left Arm" }
}

local tbl16 = {
    { "Neck", "Torso" },
    { "Left Shoulder", "Torso" },
    { "Right Shoulder", "Torso" },
    { "Left Hip", "Torso" },
    { "Right Hip", "Torso" }
}

local function indexParts(arg1)
    local result = ({})
    for _, child in ipairs(arg1:GetChildren()) do
        if not child:IsA("BasePart") then
            continue
        end

        local name = child.name

        if not result[name] then
            result[name] = child
        end
    end

    return result
end

local function createRigJoints(tbl17, tbl18: {any}, arg1)
    if arg1 then
        local root = Instance.new("AnimationConstraint")
        root.Name = "Root"
        root.Attachment0 = tbl17.HumanoidRootPart.RootRigAttachment
        root.Attachment1 = tbl17.LowerTorso.RootRigAttachment
        root.IsKinematic = true
        tbl17.LowerTorso.Root:Destroy()
        root.Parent = tbl17.LowerTorso
    end

    for _, value in ipairs(tbl18) do
        local var1, var2, var3, var4 = unpack(value)
        local var5 = tbl17[var1]
        local var6 = tbl17[var2]
        if not (var5 and var6) then
            continue
        end

        local attachment0 = var5:FindFirstChild(var3)
        local attachment1 = var6:FindFirstChild(var3)
        if not (attachment0 and attachment1 and attachment0:IsA("Attachment") and attachment1:IsA("Attachment")) then
            continue
        end

        local ragdollBallSocket = var6:FindFirstChild("RagdollBallSocket")
        if not ragdollBallSocket then
            ragdollBallSocket = Instance.new("BallSocketConstraint")
            ragdollBallSocket.Name = "RagdollBallSocket"
        end
        ragdollBallSocket.Attachment0 = attachment0
        ragdollBallSocket.Attachment1 = attachment1
        ragdollBallSocket.LimitsEnabled = true
        ragdollBallSocket.UpperAngle = var4.UpperAngle
        ragdollBallSocket.TwistLimitsEnabled = true
        ragdollBallSocket.TwistLowerAngle = var4.TwistLowerAngle
        ragdollBallSocket.TwistUpperAngle = var4.TwistUpperAngle

        local num1 = workspace.Gravity / 196.2
        if arg1 then
            num1 = math.max(num1, 0.2)
        end
        local referenceMass = var4.ReferenceMass
        local var9 = referenceMass and var6:GetMass() / referenceMass or 1
        ragdollBallSocket.MaxFrictionTorque = (var4.FrictionTorque or 500) * var9 * num1
        if arg1 then
            ragdollBallSocket.MaxFrictionTorque /= 100
        end
        ragdollBallSocket.Parent = var6

        if not arg1 then
            continue
        end

        local motor6D = var6:FindFirstChildWhichIsA("Motor6D")
        assert(motor6D)

        local animationConstraint = Instance.new("AnimationConstraint")
        animationConstraint.Name = motor6D.Name
        animationConstraint.Attachment0 = motor6D.Part0:FindFirstChild(motor6D.Name .. "RigAttachment")
        animationConstraint.Attachment1 = motor6D.Part1:FindFirstChild(motor6D.Name .. "RigAttachment")
        animationConstraint.IsKinematic = true
        animationConstraint.MaxTorque = (var4.StrengthTorque or 500) * var9 * num1
        animationConstraint.MaxForce = 0
        animationConstraint.Parent = motor6D.parent
        motor6D:Destroy()
    end
end

local function createAdditionalAttachments(tbl17, tbl18: {any})
    for _, value in ipairs(tbl18) do
        local var1, attachmentName, var3, var4 = unpack(value)
        local var5 = tbl17[var1]
        if not var5 then
            continue
        end

        local var6 = var5:FindFirstChild(attachmentName)

        if var6 and not var6:IsA("Attachment") then
            continue
        end

        if var4 then
            local var7 = var5:FindFirstChild(var4)
            if var7 and var7:IsA("Attachment") then
                var3 = var7.CFrame * var3
            end
        end

        if not var6 then
            local attachment = Instance.new("Attachment")
            attachment.Name = attachmentName
            attachment.CFrame = var3
            attachment.Parent = var5
        else
            var6.CFrame = var3
        end
    end
end

local function createNoCollides(tbl17, tbl18: {any})
    local tbl19 = ({})

    for _, value in ipairs(tbl18) do
        local var1, var2 = unpack(value)
        local var3 = tbl17[var1]
        local var4 = tbl17[var2]
        if not (var3 and var4) then
            continue
        end

        local tbl20 = tbl19[var4]
        if not tbl20 then
            tbl20 = {}
            tbl19[var4] = tbl20
        end
        tbl20[var3] = true
    end

    local tbl20 = ({})
    for k, value in pairs(tbl19) do
        local tbl21 = {}
        for _, child in ipairs(k:GetChildren()) do
            if not child:IsA("NoCollisionConstraint") or child.Name ~= "RagdollNoCollision" then
                continue
            end

            local part0 = child.Part0
            if child.Part1 == k and value[part0] then
                value[part0] = nil
            else
                table.insert(tbl21, child)
            end
        end

        tbl20[k] = tbl21
    end

    for part1, value in pairs(tbl19) do
        local var1 = tbl20[part1]
        for part0, _ in pairs(value) do
            local var2 = table.remove(var1) or Instance.new("NoCollisionConstraint")

            var2.Name = "RagdollNoCollision"
            var2.Part0 = part0
            var2.Part1 = part1
            var2.Parent = part1
        end
    end
end

local function checkValidAttachment(arg1, arg2, attachment0, attachment1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return not (not attachment0 or attachment0.Parent ~= arg1 or not attachment1 or attachment1.Parent ~= arg2)
        or not not (attachment0 and attachment0.Parent == arg2 and attachment1 and attachment1.Parent == arg1)
end

local function hasValidConstraint(arg1, arg2)
    for _, child in ipairs(arg2:GetChildren()) do
        if child:IsA("BallSocketConstraint") and checkValidAttachment(arg1, arg2, child.Attachment0, child.Attachment1) then
            return true
        end
    end

    return false
end

local function hasRagdollJoint(arg1): boolean
    if engineFeature and not (arg1:IsA("Motor6D") or arg1:IsA("AnimationConstraint")) then
        return false
    end
    local var1 = nil
    local var2 = nil
    if arg1:IsA("Motor6D") then
        var1 = arg1.Part0
        var2 = arg1.Part1
    elseif engineFeature and arg1:IsA("AnimationConstraint") then
        local attachment0 = arg1.Attachment0
        local attachment1 = arg1.Attachment1
        var1 = attachment0 and attachment0.Parent
        var2 = attachment1 and attachment1.Parent
    end

    return if var1 and var2 then if hasValidConstraint(var1, var2) then true else not not hasValidConstraint(var2, var1) else false
end

local function disableMotorSet(arg1, tbl17: {any})
    local result = {}

    for _, value in ipairs(tbl17) do
        local var1 = arg1:FindFirstChild(value[2])
        if not var1 then
            continue
        end

        local var2 = var1:FindFirstChild(value[1])
        if var2 and (engineFeature or var2:IsA("Motor6D")) and hasRagdollJoint(var2) then
            table.insert(result, var2)
            var2.Enabled = false
        end
    end

    return result
end

function module.createRagdollJoints(arg1, humanoidRigType, arg2)
    local tbl17 = indexParts(arg1)
    if humanoidRigType == Enum.HumanoidRigType.R6 then
        createAdditionalAttachments(tbl17, tbl13)
        createRigJoints(tbl17, tbl14, false)
        createNoCollides(tbl17, tbl15)
    elseif humanoidRigType == Enum.HumanoidRigType.R15 then
        createAdditionalAttachments(tbl17, tbl9)
        createRigJoints(tbl17, tbl10, arg2)
        createNoCollides(tbl17, tbl11)
    else
        error("unknown rig type", 2)
    end
end

function module.disableMotors(arg1, humanoidRigType)
    local var1 = nil
    if humanoidRigType == Enum.HumanoidRigType.R6 then
        var1 = disableMotorSet(arg1, tbl16)
    elseif humanoidRigType == Enum.HumanoidRigType.R15 then
        var1 = disableMotorSet(arg1, tbl12)
    else
        error("unknown rig type", 2)
    end

    local var2 = arg1.PrimaryPart or arg1:FindFirstChild("HumanoidRootPart")
    if var2 and var2:IsA("BasePart") then
        var2.CanCollide = false
    end

    local head = arg1:FindFirstChild("Head")
    if head and head:IsA("BasePart") then
        head.CanCollide = true
    end

    return var1
end

function module.disableParticleEmittersAndFadeOut(arg1, arg2)
    if RunService:IsServer() then
        error("disableParticleEmittersAndFadeOut should not be called on the server.", 2)
    end

    local descendants = arg1:GetDescendants()
    local tbl17 = ({})
    for _, descendant in pairs(descendants) do
        if descendant:IsA("BasePart") or descendant:IsA("Decal") then
            tbl17[descendant] = descendant.Transparency
        elseif descendant:IsA("ParticleEmitter") then
            descendant.Enabled = false
        end
    end

    local num1 = 0

    while num1 < arg2 do
        num1 += RunService.Heartbeat:Wait()
        local num2 = math.min(num1 / arg2, 1)
        for k, value in pairs(tbl17) do
            k.Transparency = (1 - num2) * value + num2
        end
    end
end

function module.easeNongraphicJointFriction(arg1, arg2)
    local descendants = arg1:GetDescendants()

    local tbl17 = ({})
    for _, descendant in pairs(descendants) do
        if not descendant:IsA("BallSocketConstraint") or descendant.Name ~= "RagdollBallSocket" then
            continue
        end

        descendant.MaxFrictionTorque *= 100
        local maxFrictionTorque = descendant.MaxFrictionTorque

        local descendantParentName = descendant.Parent.Name
        tbl17[descendant] = { descendant, maxFrictionTorque, maxFrictionTorque * (if descendantParentName == "UpperTorso" or descendantParentName == "Head" then 0.5 else 0.05) }
    end

    local num1 = 0

    while num1 < arg2 do
        local _time, deltaTime = RunService.Stepped:Wait()
        num1 += deltaTime
        local num2 = math.min(num1 / arg2, 1)
        for _, value in pairs(tbl17) do
            local var1, var2, var3 = unpack(value)
            var1.MaxFrictionTorque = (1 - num2) * var2 + num2 * var3
        end
    end
end

function module.easeJointFriction_OLD(arg1, arg2)
    local descendants = arg1:GetDescendants()

    local tbl17 = ({})
    for _, descendant in pairs(descendants) do
        if not descendant:IsA("BallSocketConstraint") or descendant.Name ~= "RagdollBallSocket" then
            continue
        end

        local maxFrictionTorque = descendant.MaxFrictionTorque

        local descendantParentName = descendant.Parent.Name
        tbl17[descendant] = { descendant, maxFrictionTorque, maxFrictionTorque * (if descendantParentName == "UpperTorso" or descendantParentName == "Head" then 0.5 else 0.05) }
    end

    local num1 = 0

    while num1 < arg2 do
        local _time, deltaTime = RunService.Stepped:Wait()
        num1 += deltaTime
        local num2 = math.min(num1 / arg2, 1)
        for _, value in pairs(tbl17) do
            local var1, var2, var3 = unpack(value)
            var1.MaxFrictionTorque = (1 - num2) * var2 + num2 * var3
        end
    end
end

return module
