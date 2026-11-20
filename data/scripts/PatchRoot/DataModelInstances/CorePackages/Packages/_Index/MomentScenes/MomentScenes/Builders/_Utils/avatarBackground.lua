-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T10:01:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local loadAsset = require(script.Parent.loadAsset)

local cFrame = CFrame.Angles(0, math.pi, 0)

local function pinToParent(arg1, arg2) -- Luacid: Inlined by compiler; 1 call site recovered
    arg1.WorldPivot = arg2:GetPivot()
end

local function findBackgroundFolder(arg1: Instance)
    local avatarBackground = arg1:FindFirstChild("AvatarBackground")
    if avatarBackground ~= nil then
        return avatarBackground
    end
    if arg1:FindFirstChild("ImageId") ~= nil and arg1:FindFirstChild("Color") ~= nil then
        return arg1
    end
    for _, child in arg1:GetChildren() do
        if child:FindFirstChild("ImageId") ~= nil and child:FindFirstChild("Color") ~= nil then
            return child
        end
    end
    return nil
end

local function readBackgroundData(arg1: Instance)
    local backgroundFolder = findBackgroundFolder(arg1)
    if backgroundFolder == nil then
        return nil
    end
    local imageId = backgroundFolder:FindFirstChild("ImageId")
    local color = backgroundFolder:FindFirstChild("Color")

    if imageId == nil or not imageId:IsA("IntValue") then
        return nil
    end

    if color == nil or not color:IsA("Color3Value") then
        return nil
    end

    return {
        imageId = imageId.Value,
        backgroundColor = color.Value
    }
end

local function hasMeshes(arg1): boolean -- Luacid: Inlined by compiler; 3 call sites recovered
    return not (arg1:FindFirstChild("texture_mesh") == nil) and arg1:FindFirstChild("color_mesh") ~= nil
end

local function extractCycloramaModel(model: Instance)
    local avatarCyclorama = model:FindFirstChild("AvatarCyclorama")

    if avatarCyclorama ~= nil and avatarCyclorama:IsA("Model") and hasMeshes(avatarCyclorama) then
        return avatarCyclorama
    end
    local model2 = model:FindFirstChildWhichIsA("Model")

    if model2 == nil or not hasMeshes(model2) then
        if model:IsA("Model") and hasMeshes(model) then
            return model
        end

        return nil
    end

    return model2
end

local function loadCyclorama()
    local success, result = pcall(loadAsset.loadAsset, 94967210842404)

    if not success then
        warn(`avatarBackground: cyclorama {94967210842404} failed to load: {result}`)
        return nil
    elseif result == nil or typeof(result) ~= "Instance" then
        warn(`avatarBackground: cyclorama {94967210842404} loaded a {typeof(result)}, expected an Instance`)
        return nil
    else
        local var1 = extractCycloramaModel(result)
        if var1 == nil then
            warn(`avatarBackground: cyclorama {94967210842404} has no Model holding both texture_mesh and color_mesh`)
            result:Destroy()
            return nil
        end
        if var1 ~= result then
            var1.Parent = nil
            result:Destroy()
        end
        var1.Name = "AvatarCyclorama"
        return var1
    end
end

local function loadBackgroundData(num1: number)
    local success, result = pcall(loadAsset.loadAsset, num1)
    if not success then
        warn(`avatarBackground: background {num1} failed to load: {result}`)
        return nil
    end
    if result == nil or typeof(result) ~= "Instance" then
        warn(`avatarBackground: background {num1} loaded a {typeof(result)}, expected an Instance`)
        return nil
    end
    local var1 = readBackgroundData(result)
    if var1 == nil then
        warn(`avatarBackground: background {num1} has no folder with an ImageId IntValue and a Color Color3Value`)
    end
    result:Destroy()
    return var1
end

local function applyTexture(basePart: BasePart, imageId: number)
    local textureId = `rbxassetid://{imageId}`
    if basePart:IsA("MeshPart") then
        basePart.TextureID = textureId
    end

    local success, result = pcall(function()
        basePart.TextureContent = Content.fromUri(textureId)
    end)
    if not success then
        warn(`avatarBackground: TextureContent assignment failed for {imageId}: {result}`)
    end
end

local function applyBackground(arg1, tbl1)
    local textureMesh = arg1:FindFirstChild("texture_mesh")
    local colorMesh = arg1:FindFirstChild("color_mesh")
    if textureMesh ~= nil and textureMesh:IsA("BasePart") then
        textureMesh.Anchored = true
        textureMesh.Transparency = 0.015
        applyTexture(textureMesh, tbl1.imageId)
    end
    if colorMesh ~= nil and colorMesh:IsA("BasePart") then
        colorMesh.Anchored = true
        colorMesh.Transparency = 0
        colorMesh.Color = tbl1.backgroundColor
    end
end

local function resolveAssetId(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    if arg1 == false or arg1 == "none" then
        return nil
    end

    if type(arg1) == "number" then
        if arg1 <= 0 then
            return nil
        end

        return arg1
    end

    return 121199209890990
end

return {
    attach = function(arg1, arg2)
        local var1 = resolveAssetId(arg2)

        if var1 == nil then
            return nil
        end
        local var2 = loadCyclorama()
        if var2 == nil then
            return nil
        end
        local var3 = loadBackgroundData(var1)
        if var3 == nil then
            var2:Destroy()
            return nil
        end
        applyBackground(var2, var3)

        var2:PivotTo(CFrame.new() * cFrame)
        var2.Parent = arg1
        pinToParent(var2, arg1)
        return var2
    end,
    pinToParent = pinToParent,
    REST = cFrame,
    applyBackground = applyBackground,
    resolveAssetId = resolveAssetId,
    CYCLORAMA_ASSET_ID = 94967210842404,
    DEFAULT_ASSET_ID = 121199209890990,
    FRONT_VISIBLE_TRANSPARENCY = 0.015
}
