-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:21:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CollectionService = game:GetService("CollectionService")

local tbl1 = {
    Accessory = "Accessory",
    CharacterMesh = "CharacterMesh",
    Decal = "Decal",
    MeshPart = "MeshPart",
    Pants = "Pants",
    Part = "Part",
    Shirt = "Shirt",
    ShirtGraphic = "ShirtGraphic",
    SpecialMesh = "SpecialMesh",
    SurfaceAppearance = "SurfaceAppearance"
}

local function getFaceControls(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    if arg1 ~= nil then
        return (arg1:FindFirstChildWhichIsA("FaceControls", true))
    end
end

local function findObjectOfNameAndTypeName(name: string, str1: string, arg1)
    if arg1 == nil then
        return nil
    end
    for _, descendant in (arg1:GetDescendants()) do
        if descendant:IsA(str1) and descendant.Name == name then
            return descendant
        end
    end
    return nil
end

local function getHead(arg1)
    if not arg1 then
        return nil
    end

    local faceControls = getFaceControls(arg1)
    return (if faceControls ~= nil
        and faceControls.Parent
        and (faceControls.Parent.ClassName == "MeshPart" or faceControls.Parent.ClassName == "Part") then faceControls.Parent else nil)
        or findObjectOfNameAndTypeName("Head", "MeshPart", arg1)
        or findObjectOfNameAndTypeName("Head", "Part", arg1)
end

local function getAnimator(arg1, timeOut: number)
    local animator = nil
    local humanoid

    if timeOut > 0 then
        humanoid = arg1:WaitForChild("Humanoid", timeOut)
        if not (humanoid and humanoid:IsA("Humanoid")) then
            humanoid = arg1:FindFirstChildWhichIsA("Humanoid")
        end
    else
        humanoid = arg1:FindFirstChildWhichIsA("Humanoid")
    end

    if humanoid ~= nil then
        if timeOut > 0 then
            animator = humanoid:WaitForChild("Animator", timeOut)
        else
            animator = humanoid:FindFirstChild("Animator")
        end
    end

    if animator == nil then
        animator = arg1:FindFirstChildWhichIsA("Animator", true)
    end

    return animator
end

local tbl2 = {
    "Head",
    "UpperTorso",
    "LowerTorso",
    "Torso",
    "LeftFoot",
    "LeftLowerLeg",
    "LeftUpperLeg",
    "RightFoot",
    "RightLowerLeg",
    "RightUpperLeg",
    "LeftHand",
    "LeftLowerArm",
    "LeftUpperArm",
    "RightHand",
    "RightLowerArm",
    "RightUpperArm"
}

local function removeChild(arg1, str1: string) -- Luacid: Inlined by compiler; 2 call sites recovered
    local var1 = arg1:FindFirstChild(str1)
    if var1 then
        var1:Destroy()
    end
end

local tbl3 = {
    Accessory = "Accessory",
    Animator = "Animator",
    Attachment = "Attachment",
    AnimationConstraint = "AnimationConstraint",
    BallSocketConstraint = "BallSocketConstraint",
    BodyColors = "BodyColors",
    Bone = "Bone",
    CharacterMesh = "CharacterMesh",
    Decal = "Decal",
    DigitsRigDescription = "DigitsRigDescription",
    FaceControls = "FaceControls",
    Humanoid = "Humanoid",
    HumanoidDescription = "HumanoidDescription",
    HumanoidRigDescription = "HumanoidRigDescription",
    MeshPart = "MeshPart",
    Motor6D = "Motor6D",
    NumberValue = "NumberValue",
    Pants = "Pants",
    Part = "Part",
    Shirt = "Shirt",
    ShirtGraphic = "ShirtGraphic",
    SpecialMesh = "SpecialMesh",
    StringValue = "StringValue",
    SurfaceAppearance = "SurfaceAppearance",
    Vector3Value = "Vector3Value",
    WrapTarget = "WrapTarget",
    Weld = "Weld",
    WrapLayer = "WrapLayer",
    WeldConstraint = "WeldConstraint",
    AccessoryWeld = "AccessoryWeld",
    PackageLink = "PackageLink",
    Folder = "Folder",
    RigidConstraint = "RigidConstraint",
    WrapTextureTransfer = "WrapTextureTransfer"
}
local function disableScripts(arg1)
    for _, child in arg1:GetChildren() do
        if child:IsA("Script") then
            child.Disabled = true
            child.Parent = nil
        end

        disableScripts(child)
    end
end

local function removeUI(arg1)
    for _, child in arg1:GetChildren() do
        if child:IsA("GuiObject")
            or child:IsA("ScreenGui")
            or child:IsA("BillboardGui")
            or child:IsA("AdGui")
            or child:IsA("SurfaceGui")
        then
            child.Parent = nil
        end

        removeUI(child)
    end
end

local function removeInstancesStrict(arg1)
    for _, child in arg1:GetChildren() do
        if not tbl3[child.ClassName] then
            child.Parent = nil
        end

        removeInstancesStrict(child)
    end
end

return {
    getFaceControls = getFaceControls,
    getNeck = function(arg1, arg2)
        if arg1 == nil or arg2 == nil then
            return nil
        end

        local descendants = arg1:GetDescendants()
        for _, descendant in descendants do
            if descendant:IsA("Motor6D") and (descendant.Part1 == arg2 or descendant.Name == "Neck") then
                return descendant
            end
        end

        for _, descendant in descendants do
            if descendant:IsA("AnimationConstraint")
                and descendant.Parent == arg2
                and (descendant.Attachment0 ~= nil and descendant.Attachment0.Name == "NeckRigAttachment" or descendant.Name == "Neck")
            then
                return descendant
            end
        end

        return nil
    end,
    getHead = getHead,
    getAnimator = getAnimator,
    updateTransparency = function(arg1, arg2)
        for _, descendant in ipairs(arg1:GetDescendants()) do
            if descendant:IsA("Decal") then
                descendant.Transparency = 0
            elseif descendant:IsA("MeshPart") then
                if descendant.Parent and descendant.Parent:IsA("Accessory") or table.find(tbl2, descendant.Name) then
                    if not table.find(arg2, descendant.MeshId) then
                        arg2[descendant.MeshId] = descendant.Transparency
                    else
                        descendant.Transparency = arg2[descendant.MeshId]
                    end
                end
            elseif descendant:IsA("Part") then
                if descendant.Parent and descendant.Parent:IsA("Accessory") or table.find(tbl2, descendant.Name) then
                    descendant.Transparency = 0
                end
                if CollectionService:HasTag(descendant, "__RBX__LOCKED_TRANSPARENT") then
                    descendant.Transparency = 1
                end
            end
        end
    end,
    shouldMarkCloneDirtyForDescendant = function(arg1)
        if arg1:IsA("MeshPart") or arg1:IsA("Part") or arg1:IsA("Decal") then
            if arg1.Transparency < 1 then
                return true
            end
        elseif tbl1[arg1.ClassName] then
            return true
        end
        return false
    end,
    resetPartOrientation = function(arg1)
        for _, descendant in ipairs(arg1:GetDescendants()) do
            if descendant:IsA("Motor6D") then
                descendant.C0 = CFrame.new(descendant.C0.Position)
                descendant.C1 = CFrame.new(descendant.C1.Position)
            end
        end
    end,
    removeScripts = function(arg1)
        removeChild(arg1, "Animate")
        removeChild(arg1, "Health")

        for _, descendant in pairs(arg1:GetDescendants()) do
            if descendant:IsA("BaseScript") then
                descendant:Destroy()
            end
        end
    end,
    removeTags = function(instance: Instance)
        local tags = CollectionService:GetTags(instance)
        for _, tag in ipairs(tags) do
            if tag ~= "NoFace" then
                CollectionService:RemoveTag(instance, tag)
            end
        end

        for _, descendant in ipairs(instance:GetDescendants()) do
            local tags2 = CollectionService:GetTags(descendant)
            for _, tag in ipairs(tags2) do
                if tag ~= "NoFace" then
                    CollectionService:RemoveTag(descendant, tag)
                end
            end
        end

        local _tags = CollectionService:GetTags(instance)
    end,
    sanitizeCharacter = function(arg1)
        if not arg1 then
            return
        end

        removeInstancesStrict(arg1)
    end,
    isValidAvatar = function(arg1): boolean
        return if getAnimator(arg1, 10) then not not getHead(arg1) else false
    end,
    hasDynamicHead = function(arg1): boolean
        return getFaceControls(arg1) ~= nil
    end
}
