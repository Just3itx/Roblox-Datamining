-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:31:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local Constants = require(scriptParentParent.Constants)

local module = {}

function module.fixUploadInstance(arg1)
    local humanoidRigDescription = arg1:FindFirstChildWhichIsA("HumanoidRigDescription")
    if not humanoidRigDescription then
        return
    end

    for _, value in Constants.R15_BODY_PARTS do
        local var1 = arg1:FindFirstChild(value)
        if not var1 then
            continue
        end
        local humanoidRigDescription2 = var1:FindFirstChildWhichIsA("HumanoidRigDescription")
        if humanoidRigDescription2 == nil then
            humanoidRigDescription2 = Instance.new("HumanoidRigDescription")
            humanoidRigDescription2.Parent = var1
        end

        if var1.Name == "LowerTorso" then
            humanoidRigDescription2.OriginOffset = humanoidRigDescription.OriginOffset
        end

        for _, containedJointLabel in humanoidRigDescription2:GetContainedJointLabels(value) do
            local joint = humanoidRigDescription:GetJoint(containedJointLabel)
            if not joint then
                continue
            end

            if joint:IsA("AnimationConstraint") then
                if joint.Attachment0 and joint.Attachment0:IsDescendantOf(var1) then
                    humanoidRigDescription2:SetJoint(containedJointLabel, joint.Attachment0)
                else
                    if not (joint.Attachment1 and joint.Attachment1:IsDescendantOf(var1)) then
                        continue
                    end

                    humanoidRigDescription2:SetJoint(containedJointLabel, joint.Attachment1)
                end
            else
                humanoidRigDescription2:SetJoint(containedJointLabel, joint)
            end

            humanoidRigDescription2:SetTposeAdjustment(
                containedJointLabel,
                humanoidRigDescription:GetTposeAdjustment(containedJointLabel)
            )
            humanoidRigDescription2:SetJointSize(containedJointLabel, humanoidRigDescription:GetJointSize(containedJointLabel))
            humanoidRigDescription2:SetJointRangeMin(
                containedJointLabel,
                humanoidRigDescription:GetJointRangeMin(containedJointLabel)
            )
            humanoidRigDescription2:SetJointRangeMax(
                containedJointLabel,
                humanoidRigDescription:GetJointRangeMax(containedJointLabel)
            )
        end
    end

    local leftHand = arg1:FindFirstChild("LeftHand")
    local rightHand = arg1:FindFirstChild("RightHand")
    for _, child in humanoidRigDescription:GetChildren() do
        if not child:IsA("DigitsRigDescription") then
            continue
        end

        if child.Side == Enum.DigitsRigDescriptionSide.Left and leftHand then
            child:Clone().Parent = leftHand
        else
            if child.Side ~= Enum.DigitsRigDescriptionSide.Right or not rightHand then
                continue
            end

            child:Clone().Parent = rightHand
        end
    end
end

return module
