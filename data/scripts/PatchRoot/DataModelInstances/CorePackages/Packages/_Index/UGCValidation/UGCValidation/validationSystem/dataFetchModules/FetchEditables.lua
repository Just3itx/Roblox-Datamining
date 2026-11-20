-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:11:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local createEditableInstancesForContext = require(scriptParentParentParent.util.createEditableInstancesForContext)
local getMeshSize = require(scriptParentParentParent.util.getMeshSize)
local SharedDataMember = require(scriptParentParentParent.validationSystem.ValidationEnums).SharedDataMember
local _Types = require(scriptParentParentParent.util.Types)

local getFFlagUGCValidateEmissiveAreaChecksFixedAlgo = require(scriptParentParentParent.flags.getFFlagUGCValidateEmissiveAreaChecksFixedAlgo)

local module = {}

function module.cleanup(tbl1)
    for value, value2 in tbl1 do
        if value2.createdInValidation then
            value2.editable:Destroy()
        end

        if value2.isPBR ~= nil then
            for _, value3 in value2 do
                if typeof(value3) == "table" and value3.createdInValidation then
                    value3.editable:Destroy()
                end
            end
        end

        tbl1[value] = nil
    end
end

local function getMeshData(arg1, bool1: boolean, tbl1)
    local var1 = arg1:IsA("MeshPart") and arg1.MeshContent or Content.fromUri(arg1.MeshId)
    local var2, var3 = createEditableInstancesForContext.getEditableInstanceInfo(var1, tbl1, "EditableMesh", bool1)

    if not var2 then
        return false
    end

    local var4 = nil
    local scale = nil
    if arg1:IsA("MeshPart") then
        if arg1.MeshContent.SourceType == Enum.ContentSourceType.Object then
            var4 = getMeshSize({ editableMesh = var3.instance })
            scale = Vector3.new(1, 1, 1)
        else
            var4 = arg1.MeshSize
            scale = arg1.Size / arg1.MeshSize
        end
    elseif arg1:IsA("SpecialMesh") then
        var4 = getMeshSize({ editableMesh = var3.instance })
        scale = arg1.Scale
    end

    return true, {
        editable = var3.instance,
        createdInValidation = var3.created,
        originalSize = var4,
        scale = scale
    }
end

local function getTextureData(arg1, bool1: boolean, tbl1)
    local surfaceAppearance = arg1:FindFirstChildWhichIsA("SurfaceAppearance")
    local tbl2

    if surfaceAppearance ~= nil then
        tbl2 = {
            isPBR = true,
            ColorMap = surfaceAppearance.ColorMapContent,
            MetalnessMap = surfaceAppearance.MetalnessMapContent,
            NormalMap = surfaceAppearance.NormalMapContent,
            RoughnessMap = surfaceAppearance.RoughnessMapContent
        }
        tbl2.EmissiveMask = surfaceAppearance.EmissiveMaskContent
    else
        tbl2 = {
            isPBR = false,
            Texture = if arg1:IsA("MeshPart") then arg1.TextureContent else Content.fromUri(arg1.TextureId)
        }
    end

    local tbl3 = {
        isPBR = tbl2.isPBR
    }

    if getFFlagUGCValidateEmissiveAreaChecksFixedAlgo() and surfaceAppearance ~= nil then
        tbl3.EmissiveTint = surfaceAppearance.EmissiveTint
        tbl3.EmissiveStrength = surfaceAppearance.EmissiveStrength
    end

    local num1 = 2

    for value, value2 in tbl2 do
        if getFFlagUGCValidateEmissiveAreaChecksFixedAlgo() then
            if value == "isPBR"
                or value == "EmissiveTint"
                or value == "EmissiveStrength"
                or value2.SourceType == Enum.ContentSourceType.None
            then
                continue
            end
        elseif value == "isPBR" or value2.SourceType == Enum.ContentSourceType.None then
            continue
        end

        local var1, var2 = createEditableInstancesForContext.getEditableInstanceInfo(value2, tbl1, "EditableImage", bool1)

        if not var1 then
            num1 = 1
            break
        end

        local tbl4 = {
            editable = var2.instance,
            createdInValidation = var2.created
        }
        tbl3[value] = tbl4
    end

    if num1 ~= 1 then
        return true, tbl3
    end

    module.cleanup(tbl3)
    return false
end

local function getCageData(arg1, bool1: boolean, bool2: boolean, tbl1)
    local var1, var2

    if not bool1 and arg1.ClassName == "WrapLayer" then
        var1 = arg1.ReferenceMeshContent
        var2 = arg1.ReferenceOrigin
    else
        var1 = arg1.CageMeshContent
        var2 = arg1.CageOrigin
    end

    local var3, var4 = createEditableInstancesForContext.getEditableInstanceInfo(var1, tbl1, "EditableMesh", bool2)

    if not var3 then
        return false
    end

    return true, {
        editable = var4.instance,
        createdInValidation = var4.created,
        originalSize = getMeshSize({ editableMesh = var4.instance }),
        origin = var2
    }
end

local function getDataInstance(arg1, str1: string)
    local var1 = arg1:IsA("MeshPart") and arg1 or arg1:FindFirstChildOfClass("SpecialMesh")

    if var1 then
        local baseWrap = arg1:FindFirstChildWhichIsA("BaseWrap")
        if str1 == SharedDataMember.renderMeshesData then
            return true, var1
        end

        if str1 == SharedDataMember.meshTextures then
            local bool1 = var1:FindFirstChildWhichIsA("SurfaceAppearance") ~= nil
            local bool2 = var1.ClassName == "SpecialMesh" and var1.TextureId ~= ""
            return var1.ClassName == "MeshPart" and var1.TextureContent.SourceType ~= Enum.ContentSourceType.None or bool1 or bool2, var1
        end

        if str1 == SharedDataMember.outerCagesData and baseWrap then
            return baseWrap.CageMeshContent.SourceType ~= Enum.ContentSourceType.None, baseWrap
        end

        if str1 == SharedDataMember.innerCagesData and baseWrap and baseWrap.ClassName == "WrapLayer" then
            return baseWrap.ReferenceMeshContent.SourceType ~= Enum.ContentSourceType.None, baseWrap
        end
    end

    return false
end

function module.getDatas(arg1, str1: string, bool1: boolean, tbl1, tbl2)
    local datas = {}
    local descendants = arg1:GetDescendants()
    table.insert(descendants, arg1)
    for _, descendant in descendants do
        local var1, var2 = getDataInstance(descendant, str1)

        if not var1 then
            continue
        end

        local var3 = nil
        local var4 = nil
        if str1 == SharedDataMember.renderMeshesData then
            var3, var4 = getMeshData(var2, bool1, tbl1)
        elseif str1 == SharedDataMember.innerCagesData or str1 == SharedDataMember.outerCagesData then
            local bool2 = str1 == SharedDataMember.outerCagesData

            var3, var4 = getCageData(var2, bool2, bool1, tbl1)
        elseif str1 == SharedDataMember.meshTextures then
            var3, var4 = getTextureData(var2, bool1, tbl2)
        end

        if not var3 or var4 == nil then
            module.cleanup(datas)
            return
        end

        datas[descendant.Name] = var4
    end

    return datas
end

return module
