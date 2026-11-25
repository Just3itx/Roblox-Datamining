-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:01:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent

local _AvatarExperienceInspectAndBuy = require(ProfilePlatformParent.AvatarExperienceInspectAndBuy)
local _Types = require(ProfilePlatform.Common.Types)

local function facing(normal: vector?, fullDegrees: number, zeroDegrees: number, weight: number?) -- Luacid: unused: defined but never referenced
    return {
        normal = normal,
        fullDegrees = fullDegrees,
        zeroDegrees = zeroDegrees,
        weight = weight or 1
    }
end

local tbl1 = { normal = Vector3.new(0, 0, -1), fullDegrees = 55, zeroDegrees = 86, weight = 1 }
local tbl2 = { normal = Vector3.new(0, 0, 1), fullDegrees = 55, zeroDegrees = 86, weight = 1 }
local tbl3 = { normal = nil, fullDegrees = 0, zeroDegrees = 180, weight = 1 }

local tbl4 = {
    FaceFrontAttachment = { tbl1 },
    FaceCenterAttachment = { tbl1 },
    NeckAttachment = { tbl1 },
    BodyFrontAttachment = { tbl1 },
    WaistFrontAttachment = { tbl1 },
    LeftCollarAttachment = { tbl1 },
    RightCollarAttachment = { tbl1 },
    BodyBackAttachment = {{
        normal = Vector3.new(0, 0, 1),
        fullDegrees = 65,
        zeroDegrees = 100,
        weight = 1
    }},
    WaistBackAttachment = {{
        normal = Vector3.new(0, 0, 1),
        fullDegrees = 65,
        zeroDegrees = 100,
        weight = 1
    }},
    LeftShoulderAttachment = {
        { normal = Vector3.new(-1, 0, 0), fullDegrees = 65, zeroDegrees = 100, weight = 1 },
        { normal = Vector3.new(0, 0, -1), fullDegrees = 35, zeroDegrees = 75, weight = 0.85 }
    },
    RightShoulderAttachment = {
        { normal = Vector3.new(1, 0, 0), fullDegrees = 65, zeroDegrees = 100, weight = 1 },
        { normal = Vector3.new(0, 0, -1), fullDegrees = 35, zeroDegrees = 75, weight = 0.85 }
    }
}
local tbl5 = {
    TShirt = Enum.AvatarAssetType.TShirt.Value,
    Shirt = Enum.AvatarAssetType.Shirt.Value,
    Pants = Enum.AvatarAssetType.Pants.Value,
    Head = Enum.AvatarAssetType.Head.Value,
    Face = Enum.AvatarAssetType.Face.Value,
    DynamicHead = Enum.AvatarAssetType.DynamicHead.Value,
    Gear = Enum.AvatarAssetType.Gear.Value
}

local tbl6 = {
    [tbl5.TShirt] = "GraphicTShirt",
    [tbl5.Shirt] = "Shirt",
    [tbl5.Pants] = "Pants",
    [tbl5.Head] = "Head",
    [tbl5.DynamicHead] = "Head",
    [tbl5.Face] = "Face"
}

local tbl7 = {
    head = { "Head" },
    torso = { "UpperTorso", "Torso" },
    legs = { "LeftUpperLeg", "Left Leg" },
    leftFoot = { "LeftFoot", "Left Leg" },
    rightFoot = { "RightFoot", "Right Leg" }
}

local function findBodyPart(arg1, str1: string)
    for _, value in tbl7[str1] do
        local var1 = arg1:FindFirstChild(value)
        if var1 and var1:IsA("BasePart") then
            return var1
        end
    end
    return nil
end

local function surfaceAnchors(part, tbl8, target)
    local result = {}
    for _, value in tbl8 do
        local normal = value.normal
        local var1 = part.Size.Z / 2 + 0.05
        table.insert(result, {
            part = part,
            offset = Vector3.new(0, 0, normal.Z * var1),
            normal = normal,
            fullDegrees = value.fullDegrees,
            zeroDegrees = value.zeroDegrees,
            weight = value.weight,
            target = target
        })
    end
    return result
end

local function regionAnchors(arg1, str1: string, tbl8, accessory: Accessory) -- Luacid: Inlined by compiler; 1 call site recovered
    local bodyPart = findBodyPart(arg1, str1)
    if not bodyPart then
        return {}
    end
    return (surfaceAnchors(bodyPart, tbl8, accessory or bodyPart))
end

local tbl8 = {
    [Enum.AccessoryType.Jacket] = "torso",
    [Enum.AccessoryType.Sweater] = "torso",
    [Enum.AccessoryType.TShirt] = "torso",
    [Enum.AccessoryType.Shirt] = "torso",
    [Enum.AccessoryType.Pants] = "legs",
    [Enum.AccessoryType.Shorts] = "legs",
    [Enum.AccessoryType.DressSkirt] = "legs",
    [Enum.AccessoryType.LeftShoe] = "leftFoot",
    [Enum.AccessoryType.RightShoe] = "rightFoot",
    [Enum.AccessoryType.Eyebrow] = "head",
    [Enum.AccessoryType.Eyelash] = "head"
}

local function accessoryAnchors(arg1, target)
    local handle = target:FindFirstChild("Handle")
    if not (handle and handle:IsA("BasePart")) then
        return {}
    end

    if handle:FindFirstChildWhichIsA("WrapLayer") and target:IsA("Accessory") then
        local var1 = tbl8[target.AccessoryType]
        if var1 then
            return regionAnchors(arg1, var1, var1 == "head" and { tbl1 } or { tbl1, tbl2 }, target)
        end
    end

    local attachment = handle:FindFirstChildWhichIsA("Attachment")

    local var1 = (if attachment then tbl4[attachment.Name] else nil) or { tbl3 }

    local specialMesh = handle:FindFirstChildWhichIsA("SpecialMesh")
    local vec3 = if specialMesh then specialMesh.Offset else Vector3.new(0, 0, 0)
    local result = {}
    for _, value in var1 do
        table.insert(result, {
            part = handle,
            offset = vec3,
            normal = value.normal,
            fullDegrees = value.fullDegrees,
            zeroDegrees = value.zeroDegrees,
            weight = value.weight,
            target = target
        })
    end
    return result
end

local module = {}

function module.findAppliedAccessory(arg1, assetId: number)
    local humanoid = arg1:FindFirstChildOfClass("Humanoid")
    local var1 = humanoid and humanoid:FindFirstChildOfClass("HumanoidDescription")
    if not var1 then
        return nil
    end
    for _, child in var1:GetChildren() do
        if not child:IsA("AccessoryDescription") or child.AssetId ~= assetId then
            continue
        end
        local success, result = pcall(function()
            return child:GetAppliedInstance()
        end)
        if success and result then
            return result
        end
    end

    return nil
end

local function anchorsForAsset(arg1, num1: number, num2: number?, func1: (...any) -> (...any))
    local var1 = func1(num1)
    if var1 then
        return (accessoryAnchors(arg1, var1))
    elseif num2 == tbl5.Shirt then
        local tbl9 = { tbl1, tbl2 }
        local bodyPart = findBodyPart(arg1, "torso")
        if not bodyPart then
            return {}
        end
        return (surfaceAnchors(bodyPart, tbl9, bodyPart))
    elseif num2 == tbl5.TShirt then
        local tbl9 = { tbl1 }
        local bodyPart = findBodyPart(arg1, "torso")
        if not bodyPart then
            return {}
        end
        return (surfaceAnchors(bodyPart, tbl9, bodyPart))
    elseif num2 == tbl5.Pants then
        local tbl9 = { tbl1, tbl2 }
        local bodyPart = findBodyPart(arg1, "legs")
        if not bodyPart then
            return {}
        end
        return (surfaceAnchors(bodyPart, tbl9, bodyPart))
    elseif num2 == tbl5.Face or num2 == tbl5.Head or num2 == tbl5.DynamicHead then
        local tbl9 = { tbl1 }
        local bodyPart = findBodyPart(arg1, "head")
        if not bodyPart then
            return {}
        end
        return (surfaceAnchors(bodyPart, tbl9, bodyPart))
    else
        if num2 == tbl5.Gear then
            local tool = arg1:FindFirstChildOfClass("Tool")
            local handle = tool and tool:FindFirstChild("Handle")
            if tool and handle and handle:IsA("BasePart") then
                return {{
                    part = handle,
                    offset = Vector3.new(0, 0, 0),
                    normal = nil,
                    fullDegrees = tbl3.fullDegrees,
                    zeroDegrees = tbl3.zeroDegrees,
                    weight = 1,
                    target = tool
                }}
            end
        end

        return {}
    end
end

local function isBundlePartWorn(arg1, num1: number, num2: number?): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    local var1 = if num2 then tbl6[num2] else nil

    if not var1 then
        return true
    end
    local humanoid = arg1:FindFirstChildOfClass("Humanoid")
    local var2 = humanoid and humanoid:FindFirstChildOfClass("HumanoidDescription")
    return not (var2 == nil) and var2[var1] == num1
end

function module.resolve(arg1, tbl9, func1: ((...any) -> (...any))?)
    local var1 = func1 or function(assetId: number)
        return module.findAppliedAccessory(arg1, assetId)
    end

    local result = {}
    for _, value in tbl9 do
        local id = value.id
        local var2 = tonumber(id)
        if not (id and var2) then
            continue
        end

        local tbl10 = {}
        if value.itemType == "Bundle" then
            for _, value2 in value.assetsInBundle or {} do
                local var3 = tonumber(value2.id)
                local var4 = tonumber(value2.assetType)

                if not (var3 and isBundlePartWorn(arg1, var3, var4)) then
                    continue
                end

                for _, value3 in anchorsForAsset(arg1, var3, var4, var1) do
                    table.insert(tbl10, value3)
                end
            end
        else
            local func2 = anchorsForAsset
            local itemSubType = value.itemSubType
            tbl10 = func2(arg1, var2, tonumber(itemSubType), var1)
        end

        if #tbl10 > 0 then
            table.insert(result, { itemId = id, anchors = tbl10 })
        end
    end
    return result
end

return module
