-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:21:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local getEngineFeatureEngineSplitHumanoidRigDescriptionInUpload = require(scriptParentParent.flags.getEngineFeatureEngineSplitHumanoidRigDescriptionInUpload)

local getFFlagUGCValidationStripAccessoryHandleAttributes = require(scriptParentParent.flags.getFFlagUGCValidationStripAccessoryHandleAttributes)
local SplitHumanoidRigDescriptionForUpload = require(scriptParentParent.util.SplitHumanoidRigDescriptionForUpload)

local function fixUpPreValidation(arg1)
    arg1 = arg1:Clone()

    if getEngineFeatureEngineSplitHumanoidRigDescriptionInUpload() then
        SplitHumanoidRigDescriptionForUpload.fixUploadInstance(arg1)
    end

    local descendants = arg1:GetDescendants()
    table.insert(descendants, arg1)

    for _, descendant in descendants do
        if descendant.Parent ~= nil
            and (descendant:IsA("Motor6D")
                or descendant.Name == "OriginalSize"
                or descendant.Name == "OriginalPosition"
                or descendant:IsA("Weld") and descendant.Name == "AccessoryWeld"
                or getEngineFeatureEngineSplitHumanoidRigDescriptionInUpload()
                    and (descendant:IsA("Constraint") or descendant:isA("NoCollisionConstraint")))
        then
            descendant:Destroy()
        else
            if descendant:IsA("BasePart") then
                descendant.Velocity = Vector3.new(0, 0, 0)
                descendant.RotVelocity = Vector3.new(0, 0, 0)
            end

            local isAccessory = if descendant.Parent then descendant.Parent:IsA("Accessory") else false

            if descendant:IsA("MeshPart")
                and not isAccessory
                and descendant.TextureID == ""
                and not descendant:FindFirstChildWhichIsA("SurfaceAppearance")
            then
                Instance.new("SurfaceAppearance").Parent = descendant
            end

            if getFFlagUGCValidationStripAccessoryHandleAttributes()
                and (descendant:IsA("MeshPart") or descendant:IsA("Part"))
                and descendant.Name == "Handle"
                and isAccessory
            then
                for value in descendant:GetAttributes() do
                    descendant:SetAttribute(value, nil)
                end
            end
        end
    end
    return arg1
end

return fixUpPreValidation
