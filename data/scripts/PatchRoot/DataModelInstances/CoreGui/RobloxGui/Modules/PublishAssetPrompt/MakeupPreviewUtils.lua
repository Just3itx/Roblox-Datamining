-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:20:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AssetService = game:GetService("AssetService")
local CorePackages = game:GetService("CorePackages")
local Players = game:GetService("Players")

local Thumbnailing = require(CorePackages.Packages.Thumbnailing)
local FFlagSharedMakeupThumbnailCamera = Thumbnailing.FFlagSharedMakeupThumbnailCamera

local scriptParent = script.Parent
local Constants = require(scriptParent.Constants)

local brickColor = BrickColor.new(194)

local function makeCameraCFrame(at: vector, vec1: vector): CFrame -- Luacid: unused: defined but never referenced
    return CFrame.lookAt(at, at + vec1)
end

local cFrame = CFrame.lookAt(Vector3.new(0, 0.0936213, -15.755899), Vector3.new(0, 0.0936213, -14.755899))
local tbl1 = {
    [Enum.AvatarAssetType.FaceMakeup] = cFrame,
    [Enum.AvatarAssetType.LipMakeup] = CFrame.lookAt(Vector3.new(0, -0.2991416, -6.4134803), Vector3.new(0, -0.2991416, -5.4134803)),
    [Enum.AvatarAssetType.EyeMakeup] = CFrame.lookAt(Vector3.new(0, 0.10852961, -9.357428), Vector3.new(0, 0.10852961, -8.357428)),
    [Enum.AvatarAssetType.EyebrowAccessory] = CFrame.lookAt(Vector3.new(4.5928926, 0.37917417, -7.374273), Vector3.new(4.0461125, 0.35952252, -6.537227)),
    [Enum.AvatarAssetType.EyelashAccessory] = CFrame.lookAt(Vector3.new(4.593966, 0.2791934, -7.375918), Vector3.new(4.047186, 0.25954175, -6.5388722))
}

local module = {}

function module.getHeadPreviewCameraData(arg1)
    local head = arg1:FindFirstChild("Head")
    if head and head:IsA("MeshPart") and not arg1:FindFirstChild("HumanoidRootPart") then
        return head.CFrame, head.Size
    end

    return nil, nil
end

function module.setupMakeupThumbnailCamera(arg1, arg2, arg3): boolean
    local head = arg1:FindFirstChild("Head")
    if not (head and head:IsA("MeshPart")) then
        return false
    end

    if FFlagSharedMakeupThumbnailCamera then
        Thumbnailing.MakeupCameraUtility.SetupCamera(arg2, head.CFrame, if arg3 then arg3.Value else nil)
        return true
    end

    local cFrame2 = cFrame
    if arg3 then
        cFrame2 = tbl1[arg3] or cFrame2
    end
    arg2.CFrame = head.CFrame * cFrame2
    arg2.Focus = head.CFrame
    arg2.FieldOfView = 5
    return true
end

function module.isMakeupAssetType(arg1): boolean
    return Constants.MakeupAssetTypes[arg1] == true
end

local tbl2 = {
    [Enum.AvatarAssetType.FaceMakeup] = Enum.MakeupType.Face,
    [Enum.AvatarAssetType.LipMakeup] = Enum.MakeupType.Lip,
    [Enum.AvatarAssetType.EyeMakeup] = Enum.MakeupType.Eye
}

local tbl3 = {
    [Enum.AvatarAssetType.EyebrowAccessory] = Enum.AccessoryType.Eyebrow,
    [Enum.AvatarAssetType.EyelashAccessory] = Enum.AccessoryType.Eyelash
}

local tbl4 = {
    [Enum.AccessoryType.Hat] = true,
    [Enum.AccessoryType.Hair] = true,
    [Enum.AccessoryType.Face] = true,
    [Enum.AccessoryType.Eyebrow] = true,
    [Enum.AccessoryType.Eyelash] = true
}

local function removeMatchingChildren(description: HumanoidDescription, func1: (...any) -> (...any))
    for _, child in ipairs(description:GetChildren()) do
        if func1(child) then
            child:Destroy()
        end
    end
end

local function addAssetToDescription(description: HumanoidDescription, instance, arg1)
    local makeupType = arg1 and tbl2[arg1]
    local accessoryType = arg1 and tbl3[arg1]

    if makeupType then
        removeMatchingChildren(description, function(arg2)
            return arg2:IsA("MakeupDescription")
        end)
        local makeupDescription = Instance.new("MakeupDescription")
        makeupDescription.MakeupType = makeupType
        makeupDescription.Instance = instance
        makeupDescription.Parent = description
        return
    end

    if not accessoryType then
        return
    end

    removeMatchingChildren(description, function(arg2)
        return arg2:IsA("AccessoryDescription") and arg2.AccessoryType == accessoryType
    end)
    local accessoryDescription = Instance.new("AccessoryDescription")
    accessoryDescription.AccessoryType = accessoryType
    accessoryDescription.Instance = instance
    accessoryDescription.IsLayered = true
    accessoryDescription.Parent = description
end

function module.stripToHead(arg1)
    local head = arg1:FindFirstChild("Head")
    if not head then
        return
    end

    for _, child in ipairs(arg1:GetChildren()) do
        if child:IsA("BasePart") then
            if child ~= head then
                child:Destroy()
            end
        elseif child:IsA("Accessory") and not tbl4[child.AccessoryType] then
            child:Destroy()
        end
    end
end

function module.anchorRigidPreviewParts(arg1)
    for _, descendant in ipairs(arg1:GetDescendants()) do
        if not descendant:IsA("BasePart") then
            continue
        end

        local accessory = descendant:FindFirstAncestorWhichIsA("Accessory")
        if not accessory or accessory:FindFirstChildWhichIsA("WrapLayer", true) == nil then
            descendant.Anchored = true
        end
    end
end

function module.getFolderAccessories(arg1, tbl5)
    local folderAccessories = {}
    for i, asset in ipairs(arg1:GetChildren()) do
        if not asset:IsA("Accessory") then
            continue
        end

        local assetType = if tbl5 and tbl5[i] then tbl5[i].assetType else nil
        table.insert(folderAccessories, { asset = asset, assetType = assetType })
    end

    return folderAccessories
end

local function createHeadWithAsset(humanoidDescription: HumanoidDescription, arg1, arg2, tbl5)
    if arg1 then
        addAssetToDescription(humanoidDescription, arg1, arg2)
    end

    if tbl5 then
        for _, value in ipairs(tbl5) do
            addAssetToDescription(humanoidDescription, value.asset, value.assetType)
        end
    end

    local var1 = nil
    if not (pcall(function()
        var1 = Players:CreateHumanoidModelFromDescriptionAsync(humanoidDescription, Enum.HumanoidRigType.R15)
    end) and var1) then
        return nil
    end

    local workspace = workspace
    var1.Parent = workspace
    var1:GetBoundingBox()
    var1.Parent = nil

    module.stripToHead(var1)

    module.anchorRigidPreviewParts(var1)

    return var1
end

function module.createMakeupHeadPreview(arg1, arg2, tbl5)
    local var1 = nil
    local localPlayer = Players.LocalPlayer
    if localPlayer then
        local success, result = pcall(function(): HumanoidDescription
            return Players:GetHumanoidDescriptionFromUserIdAsync(localPlayer.UserId)
        end)
        if success then
            var1 = result or var1
        end
    end

    local description = var1 or Instance.new("HumanoidDescription")

    return (createHeadWithAsset(description, arg1, arg2, tbl5))
end

function module.createMakeupThumbnailPreview(arg1, arg2)
    local humanoidDescription = Instance.new("HumanoidDescription")
    humanoidDescription.Head = 103273511207307

    if arg1 then
        addAssetToDescription(humanoidDescription, arg1, arg2)
    end

    local var1 = nil
    local var2

    if pcall(function()
        var1 = Players:CreateHumanoidModelFromDescriptionAsync(humanoidDescription, Enum.HumanoidRigType.R15)
    end) and var1 then
        local workspace = workspace
        var1.Parent = workspace
        var1:GetBoundingBox()
        var1.Parent = nil

        module.stripToHead(var1)

        module.anchorRigidPreviewParts(var1)

        var2 = var1
    else
        var2 = nil
    end

    if not var2 then
        return nil
    end

    local bodyColors = var2:FindFirstChildOfClass("BodyColors")
    if bodyColors then
        bodyColors.HeadColor = brickColor
    end
    local head = var2:FindFirstChild("Head")
    if head then
        head.Color = brickColor.Color
    end

    return var2
end

function module.compositeMakeupFolder(arg1, tbl5)
    local tbl6 = {}
    for _, child in ipairs(arg1:GetChildren()) do
        if child:IsA("Decal") then
            table.insert(tbl6, child)
        end
    end

    if #tbl6 == 0 then
        return nil
    end

    local object = tbl6[1].TextureContent and tbl6[1].TextureContent.Object
    if not object then
        return nil
    end

    if tbl5 then
        table.sort(tbl6, function(arg2, arg3): boolean
            return (tbl5[arg2.Name] or 0) < (tbl5[arg3.Name] or 0)
        end)
    end

    local objectSize = object.Size
    local vector2 = Vector2.new(objectSize.X, objectSize.Y)

    local decal = Instance.new("Decal")

    for _, value in ipairs({ "TextureContent", "RoughnessMapContent", "MetalnessMapContent", "NormalMapContent" }) do
        local bool1 = false
        for _, value2 in ipairs(tbl6) do
            local var1 = value2[value]
            if var1 and (var1.Object or var1.Uri) then
                bool1 = true
                break
            end
        end

        if not bool1 then
            continue
        end

        local editableImage = AssetService:CreateEditableImage({ Size = vector2 })
        local bool2 = false

        for _, value2 in ipairs(tbl6) do
            local var1 = value2[value]
            if not var1 then
                continue
            end

            local object2 = var1.Object
            if not object2 and var1.Uri and var1.Uri ~= "" then
                local success, result = pcall(function()
                    return AssetService:CreateEditableImageAsync(var1)
                end)
                if success then
                    object2 = result
                end
            end

            if object2 then
                local imageCombineType = if bool2 then Enum.ImageCombineType.AlphaBlend else Enum.ImageCombineType.Overwrite
                editableImage:DrawImage(Vector2.new(0, 0), object2, imageCombineType)
                bool2 = true
            end
        end

        decal[value] = Content.fromObject(editableImage)
    end

    local wrapTextureTransfer = tbl6[1]:FindFirstChildWhichIsA("WrapTextureTransfer")
    if wrapTextureTransfer then
        wrapTextureTransfer:Clone().Parent = decal
    end

    return decal
end

return module
