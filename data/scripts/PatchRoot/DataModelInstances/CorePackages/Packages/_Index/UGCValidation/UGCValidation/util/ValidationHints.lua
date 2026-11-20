-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:40:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local Constants = require(scriptParentParent.Constants)

local _Types = require(scriptParentParent.util.Types)
local BoundsCalculator = require(scriptParentParent.util.BoundsCalculator)
local BoundsDataUtils = require(scriptParentParent.util.BoundsDataUtils)
local ParseContentIds = require(scriptParentParent.util.ParseContentIds)
local getMeshInfo = require(scriptParentParent.util.getMeshInfo)
local getMeshVerts = require(scriptParentParent.util.getMeshVerts)

local module = {}

local tbl1 = {
    MeshPart = { "MeshId" }
}

local tbl2 = {
    MeshPart = { MeshId = true }
}
local function validateMeshIds(arg1, arg2)
    if not ParseContentIds.parseWithErrorCheck({}, {}, arg1, tbl1, tbl2, arg2) then
        return false, { arg1.Name .. " does not have a MeshId" }
    end
    return true
end

local function validateAllMeshParts(arg1, arg2)
    for _, value in Constants.ASSET_TYPE_INFO do
        if not value.isBodyPart then
            continue
        end

        for k, subPart in pairs(value.subParts) do
            local var1 = arg1[k]
            if not var1 or var1.ClassName ~= "MeshPart" then
                return false, { k .. " missing" }
            end

            if var1.Name ~= k then
                return false, { k .. " input data is incorrectly set-up" }
            end

            local var2, var3 = validateMeshIds(var1, arg2)
            if not var2 then
                return false, var3
            end

            local tbl3 = {
                [subPart.rigAttachmentToParent.name] = 0
            }
            local num1 = 1
            for k2 in subPart.otherAttachments do
                if string.find(k2, "RigAttachment$") ~= nil then
                    tbl3[k2] = 0
                    num1 += 1
                end
            end

            local num2 = 0
            for _, child in var1:GetChildren() do
                if child.ClassName ~= "Attachment" or not tbl3[child.Name] then
                    continue
                end

                if tbl3[child.Name] == 1 then
                    return false, { k .. " has duplicate rig attachments: " .. child.Name }
                end
                tbl3[child.Name] = tbl3[child.Name] + 1
                num2 += 1
            end

            if num2 ~= num1 then
                return false, { "Missing rig attachments" }
            end
        end
    end
    return true
end

local function isWindowValid(min: number, max: number): boolean -- Luacid: Inlined by compiler; 3 call sites recovered
    return min <= max
end

local tbl3 = { "X", "Y", "Z" }
local function calculateScalingWindow(arg1, arg2)
    local scalingWindow = {}
    local meshSize, _, overallSize = BoundsDataUtils.calculateBoundsDimensions(arg1)

    scalingWindow.meshSize = meshSize
    scalingWindow.overallSize = overallSize
    scalingWindow.scaleTypes = {}

    for value, value2 in arg2 do
        local tbl4 = {
            max = math.huge,
            min = -math.huge
        }

        for _, value3 in tbl3 do
            local tbl5 = {
                min = 0.00005 + value2.minSize[value3] / meshSize[value3],
                max = value2.maxSize[value3] / overallSize[value3] - 0.00005
            }
            tbl4[value3] = tbl5
            tbl4[value3].ok = not not isWindowValid(tbl4[value3].min, tbl4[value3].max)
            tbl4.max = math.min(tbl4.max, tbl4[value3].max)
            tbl4.min = math.max(tbl4.min, tbl4[value3].min)
        end

        tbl4.ok = not not isWindowValid(tbl4.min, tbl4.max)
        scalingWindow.scaleTypes[value] = tbl4
    end
    return scalingWindow
end

local function combineScalingWindows(arg1)
    local result = ({})
    for _, value in arg1 do
        for value2, value3 in value.scaleTypes do
            result[value2] = result[value2] or {
                max = math.huge,
                min = -math.huge
            }

            local var1 = result[value2]
            var1.max = math.min(result[value2].max, value3.max)
            local var2 = result[value2]
            var2.min = math.max(result[value2].min, value3.min)
        end
    end
    return result
end

local function createFinalResults(arg1)
    local tbl4 = {
        meshSize = arg1.meshSize,
        overallSize = arg1.overallSize
    }
    for value, value2 in arg1.scaleTypes do
        local tbl5 = {}

        for _, value3 in tbl3 do
            tbl5[value3] = value2[value3]
        end
        tbl5.ok = value2.ok
        tbl5.min = value2.min
        tbl5.max = value2.max

        tbl4[value] = tbl5
    end
    return tbl4
end

function module.preprocessDataAsync(arg1, arg2)
    local var1, errors = validateAllMeshParts(arg1, arg2)
    if not var1 then
        return { ok = false, errors = errors }
    end

    local meshData = {}
    for _, value in Constants.ASSET_TYPE_INFO do
        if not value.isBodyPart then
            continue
        end

        for k in value.subParts do
            assert(arg1[k].ClassName == "MeshPart")
            local var3 = arg1[k]

            local var4, var2, var6 = getMeshInfo(var3, Constants.MESH_CONTENT_TYPE.RENDER_MESH, arg2)
            if not var4 then
                return { ok = false, errors = var2 }
            end

            meshData[var3.MeshId] = {}
            local var7 = meshData[var3.MeshId]

            local var8, var5, verts = getMeshVerts(var6, arg2)
            if not var8 then
                return { ok = false, errors = var5 }
            end

            var7.verts = verts
        end
    end
    return {
        ok = true,
        cache = { meshData = meshData }
    }
end

function module.isPreprocessDataCached(arg1, arg2)
    local meshData = arg2.meshData
    for _, value in Constants.ASSET_TYPE_INFO do
        if not value.isBodyPart then
            continue
        end

        for k in pairs(value.subParts) do
            local var1 = arg1[k]
            if not var1 or var1.ClassName ~= "MeshPart" or var1.MeshId == "" then
                continue
            end

            if not meshData then
                return false
            end

            local var2 = meshData[var1.MeshId]
            if not var2 then
                return false
            end

            if not var2.verts then
                return false
            end
        end
    end
    return true
end

function module.calculateScaleToValidateBoundsAsync(arg1, arg2, arg3)
    local var1, errors = validateAllMeshParts(arg1, arg2)
    if not var1 then
        return { ok = false, errors = errors }
    end

    local var3, var2, var5 = BoundsCalculator.calculateIndividualFullBodyPartsData(arg1, arg2, arg3, true)
    if not var3 then
        return {
            ok = false,
            errors = var2 or { "Errors calculating parts metrics" }
        }
    end

    local tbl4 = {}
    for _, value in var5 do
        tbl4 = BoundsDataUtils.combineBounds(tbl4, value.boundsData)
    end
    local tbl5 = ({})
    tbl5.FullBody = calculateScalingWindow(tbl4, Constants.FULL_BODY_BOUNDS)

    for value, value2 in Constants.ASSET_TYPE_INFO do
        if not value2.isBodyPart then
            continue
        end

        local tbl6 = {}
        for k in value2.subParts do
            tbl6 = BoundsDataUtils.combineBounds(tbl6, var5[k].boundsData)
        end
        tbl5[value.Name] = calculateScalingWindow(tbl6, Constants.ASSET_TYPE_INFO[value].bounds)
    end

    local var6 = nil
    local var7 = nil
    for value, value2 in combineScalingWindows(tbl5) do
        if not isWindowValid(value2.min, value2.max) then
            continue
        end

        if value2.min <= 1 and value2.max >= 1 then
            var7 = value
            var6 = 1
            break
        end

        local var8 = if math.abs(1 - value2.min) < math.abs(1 - value2.max) then value2.min else value2.max

        if var6 and not (math.abs(1 - var8) < math.abs(1 - var6)) then
            continue
        end

        var7 = value
        var6 = var8
    end

    local tbl6 = { ok = true }
    tbl6.Overall = {
        ok = var6 ~= nil,
        scale = var6,
        scaleType = var7
    }

    for value, value2 in tbl5 do
        tbl6[value] = createFinalResults(value2)
    end
    return tbl6
end

return module
