-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:31:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local _Types = require(scriptParentParent.util.Types)
local AssetService = game:GetService("AssetService")
local ValidationEnums = require(scriptParentParent.validationSystem.ValidationEnums)
local R15plusUtils = require(scriptParentParent.util.R15plusUtils)
local RigBuilder = require(scriptParentParent.util.RigBuilder)
local buildEmoteKeyframeSequenceFromCurveAnim = require(scriptParentParent.util.buildEmoteKeyframeSequenceFromCurveAnim)

local getEngineFeatureEngineUGCValidateEmoteAnimationExport = require(scriptParentParent.flags.getEngineFeatureEngineUGCValidateEmoteAnimationExport)

local module = {
    requiredData = {
        ValidationEnums.SharedDataMember.renderMeshesData,
        ValidationEnums.SharedDataMember.innerCagesData,
        ValidationEnums.SharedDataMember.outerCagesData,
        ValidationEnums.SharedDataMember.meshTextures
    }
}

local function createCagePart(meshPart: MeshPart, arg1, arg2, str1: string)
    local meshPart2 = AssetService:CreateMeshPartAsync(Content.fromObject(arg2.editable))
    meshPart2.Name = `{meshPart}_{str1}`
    meshPart2.Size *= arg1.scale
    local var1 = CFrame.new(arg2.origin.Position * arg1.scale) * arg2.origin.Rotation
    meshPart2.CFrame = meshPart.CFrame * var1
    return meshPart2
end

local function copyMeshPart(arg1, arg2, arg3)
    local meshPart = AssetService:CreateMeshPartAsync(Content.fromObject(arg2.editable))
    if arg3 and not arg3.isPBR and arg3.Texture then
        meshPart.TextureContent = Content.fromObject(arg3.Texture.editable)
    elseif arg3 and arg3.isPBR then
        local surfaceAppearance = Instance.new("SurfaceAppearance")
        if arg3.ColorMap then
            surfaceAppearance.ColorMapContent = Content.fromObject(arg3.ColorMap.editable)
        end
        if arg3.MetalnessMap then
            surfaceAppearance.MetalnessMapContent = Content.fromObject(arg3.MetalnessMap.editable)
        end
        if arg3.NormalMap then
            surfaceAppearance.NormalMapContent = Content.fromObject(arg3.NormalMap.editable)
        end
        if arg3.RoughnessMap then
            surfaceAppearance.RoughnessMapContent = Content.fromObject(arg3.RoughnessMap.editable)
        end
        if arg3.EmissiveMask then
            surfaceAppearance.EmissiveMaskContent = Content.fromObject(arg3.EmissiveMask.editable)
        end

        surfaceAppearance.Parent = meshPart
    end

    meshPart.Name = arg1.Name
    meshPart.Size = arg1.Size
    meshPart.CFrame = arg1.CFrame

    for _, child in arg1:GetChildren() do
        if (child:IsA("Attachment") or child:IsA("FaceControls"))
            and not (R15plusUtils.checkFlagEnabledForAllowHrd() and child:IsA("Bone"))
        then
            child:Clone().Parent = meshPart
        end
    end

    if R15plusUtils.checkFlagEnabledForAllowHrd() then
        local avatarBoneSchema = R15plusUtils.getAvatarBoneSchema(arg1.Name)
        for attachmentName, value2 in (R15plusUtils.getNameWhitelistOfClassInSchema(avatarBoneSchema, "Attachment")) do
            if not value2 or meshPart:FindFirstChild(attachmentName) ~= nil then
                continue
            end

            local var1 = arg1:FindFirstChild(attachmentName, true)
            local worldCFrame = if var1 ~= nil then var1.WorldCFrame else meshPart.CFrame
            local attachment = Instance.new("Attachment")
            attachment.Name = attachmentName
            attachment.Parent = meshPart
            attachment.WorldCFrame = worldCFrame
        end
    end

    return meshPart
end

local function addBonesFromPoses(arg1, parent, arg2)
    for _, child in arg1:GetChildren() do
        if not child:IsA("Pose") then
            continue
        end

        local childName = child.Name
        local var1 = arg2:FindFirstChild(childName)
        if var1 and var1:IsA("BasePart") then
            addBonesFromPoses(child, var1, arg2)
        else
            local bone = Instance.new("Bone")
            bone.Name = childName
            bone.Parent = parent
            addBonesFromPoses(child, bone, arg2)
        end
    end
end

local function createEmoteExportScene(arg1)
    local defaultCharacter = RigBuilder.createDefaultCharacter(false)
    local emoteKeyframeSequenceFromCurveAnim = if arg1.curveAnimations and #arg1.curveAnimations > 0 then buildEmoteKeyframeSequenceFromCurveAnim(arg1.curveAnimations[1]) else nil

    if not emoteKeyframeSequenceFromCurveAnim then
        error("Emote export requires a curve animation, but none was available")
    end

    emoteKeyframeSequenceFromCurveAnim.Parent = defaultCharacter

    local children = emoteKeyframeSequenceFromCurveAnim:GetChildren()
    local humanoidRootPart = defaultCharacter:FindFirstChild("HumanoidRootPart")
    if #children > 0 and humanoidRootPart and humanoidRootPart:IsA("BasePart") then
        addBonesFromPoses(children[1], humanoidRootPart, defaultCharacter)
    end

    defaultCharacter:PivotTo(CFrame.new())
    return defaultCharacter
end

function module.createModelForGltfExport(arg1)
    if getEngineFeatureEngineUGCValidateEmoteAnimationExport()
        and arg1.uploadCategory == ValidationEnums.UploadCategory.EMOTE_ANIMATION
    then
        return (createEmoteExportScene(arg1))
    end

    local model = Instance.new("Model")
    local descendants = arg1.rootInstance:GetDescendants()
    table.insert(descendants, arg1.rootInstance)
    for _, descendant in descendants do
        if not descendant:IsA("MeshPart") then
            continue
        end

        local descendantName = descendant.Name
        local var1 = arg1.renderMeshesData[descendantName]
        if not var1 then
            error("Missing editable data")
        end

        local var2 = arg1.meshTextures[descendantName]
        local meshPart = copyMeshPart(descendant, var1, var2)
        meshPart.Parent = model

        local var3 = arg1.outerCagesData[descendantName]
        if var3 then
            createCagePart(meshPart, var1, var3, "OuterCage").Parent = model
        end

        local var4 = arg1.innerCagesData[descendantName]
        if var4 then
            createCagePart(meshPart, var1, var4, "InnerCage").Parent = model
        end

        if arg1.uploadCategory == ValidationEnums.UploadCategory.FULL_BODY then
            meshPart.Name = `{descendantName}_Geo`
        end
    end

    model:PivotTo(CFrame.new())
    return model
end

return module
