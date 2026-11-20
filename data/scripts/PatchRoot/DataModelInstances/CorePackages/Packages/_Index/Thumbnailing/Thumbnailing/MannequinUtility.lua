-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T16:20:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}

local InsertService = game:GetService("InsertService")

local tbl1 = { R6 = true, R15 = true, R15ArtistIntent = true }

module.CharacterPartNames = {
    R6 = {
        HumanoidRootPart = true,
        Head = true,
        Torso = true,
        ["Left Arm"] = true,
        ["Left Leg"] = true,
        ["Right Arm"] = true,
        ["Right Leg"] = true,
        CharacterMesh = true
    },
    R15 = {
        HumanoidRootPart = true,
        Head = true,
        UpperTorso = true,
        LowerTorso = true,
        LeftUpperLeg = true,
        LeftLowerLeg = true,
        LeftFoot = true,
        RightUpperLeg = true,
        RightLowerLeg = true,
        RightFoot = true,
        LeftUpperArm = true,
        LeftLowerArm = true,
        LeftHand = true,
        RightUpperArm = true,
        RightLowerArm = true,
        RightHand = true
    }
}

module.R15PartNameToEnum = {
    Head = Enum.BodyPartR15.Head,
    UpperTorso = Enum.BodyPartR15.UpperTorso,
    LowerTorso = Enum.BodyPartR15.LowerTorso,
    LeftUpperLeg = Enum.BodyPartR15.LeftUpperLeg,
    LeftLowerLeg = Enum.BodyPartR15.LeftLowerLeg,
    LeftFoot = Enum.BodyPartR15.LeftFoot,
    RightUpperLeg = Enum.BodyPartR15.RightUpperLeg,
    RightLowerLeg = Enum.BodyPartR15.RightLowerLeg,
    RightFoot = Enum.BodyPartR15.RightFoot,
    LeftUpperArm = Enum.BodyPartR15.LeftUpperArm,
    LeftLowerArm = Enum.BodyPartR15.LeftLowerArm,
    LeftHand = Enum.BodyPartR15.LeftHand,
    RightUpperArm = Enum.BodyPartR15.RightUpperArm,
    RightLowerArm = Enum.BodyPartR15.RightLowerArm,
    RightHand = Enum.BodyPartR15.RightHand
}

module.CharacterPartNames.All = {}

for k, _ in pairs(module.CharacterPartNames.R6) do
    module.CharacterPartNames.All[k] = true
end

for k, _ in pairs(module.CharacterPartNames.R15) do
    module.CharacterPartNames.All[k] = true
end

local function loadMannequin(assetPath: string, bool1: boolean?) -- Luacid: Inlined by compiler; 5 call sites recovered
    if bool1 == nil then
        bool1 = true
    end

    local localAssetResult = InsertService:LoadLocalAsset(assetPath)
    local humanoid = localAssetResult:FindFirstChild("Humanoid")
    assert(humanoid, "Assert Humanoid is not nil to silence type checker")
    humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None

    if bool1 then
        localAssetResult.Parent = workspace
    end

    return localAssetResult
end

function module.LoadR15Mannequin(bool1: boolean?): Instance
    return loadMannequin("rbxasset://models/Thumbnails/Mannequins/R15.rbxm", bool1)
end

function module.LoadR6Mannequin(bool1: boolean?): Instance
    return loadMannequin("rbxasset://models/Thumbnails/Mannequins/R6.rbxm", bool1)
end

function module.LoadRthroMannequin(bool1: boolean?): Instance
    return loadMannequin("rbxasset://models/Thumbnails/Mannequins/Rthro.rbxm", bool1)
end

function module.LoadR15PlusMannequin(bool1: boolean?)
    if game:GetEngineFeature("R15PlusMannequinContent") then
        return loadMannequin("rbxasset://models/Thumbnails/Mannequins/R15-plus.rbxm", bool1)
    end

    return loadMannequin("rbxasset://models/Thumbnails/Mannequins/R15.rbxm", bool1)
end

function module.LoadMannequinForScaleType(arg1, bool1: boolean?)
    if arg1 == "Classic" then
        return module.LoadR15Mannequin(bool1)
    end
    return module.LoadRthroMannequin(bool1)
end

function module.AssertObjectsFormat(tbl2)
    local bool1 = false
    for _, value in tbl2 do
        assert(value:IsA("Folder"), "object should always be a Folder")
        if not tbl1[value.Name] then
            continue
        end

        bool1 = true
        for _, child in value:GetChildren() do
            assert(
                module.CharacterPartNames.All[child.Name],
                string.format("Name of %s of Folder %s does not exist in CharacterParts", child.Name, value.Name)
            )
        end
    end

    assert(bool1, "objects does not have at least one of R15ArtistIntent, R15, and R6 folders")
end

function module.CreateBodyPartMannequin(tbl2, bool1: boolean?)
    local bool2 = false
    local bool3 = false
    local str1 = "Classic"

    module.AssertObjectsFormat(tbl2)
    for _, value in tbl2 do
        if value.Name ~= "R15" and value.Name ~= "R15ArtistIntent" then
            continue
        end

        bool2 = true

        local avatarPartScaleType = value:FindFirstChild("AvatarPartScaleType", true)
        if avatarPartScaleType then
            str1 = avatarPartScaleType.Value
        end

        break
    end

    for _, value in tbl2 do
        if value.Name == "R15ArtistIntent" then
            bool3 = true
            break
        end
    end

    local var1 = if bool2 then module.LoadMannequinForScaleType(str1, bool1) else module.LoadR6Mannequin(bool1)
    local humanoid = var1:FindFirstChildOfClass("Humanoid")

    humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
    local bodyTypeScale = humanoid:FindFirstChild("BodyTypeScale")

    if bodyTypeScale == nil then
        bodyTypeScale = Instance.new("NumberValue")
        bodyTypeScale.Name = "BodyTypeScale"
        bodyTypeScale.Value = 0
        bodyTypeScale.Parent = humanoid
    end

    local bodyProportionScale = humanoid:FindFirstChild("BodyProportionScale")
    if bodyProportionScale == nil then
        bodyProportionScale = Instance.new("NumberValue")
        bodyProportionScale.Name = "BodyProportionScale"
        bodyProportionScale.Value = 0
        bodyProportionScale.Parent = humanoid
    end

    if str1 == "ProportionsNormal" then
        bodyTypeScale.Value = 1
        bodyProportionScale.Value = 0
    elseif str1 == "ProportionsSlender" then
        bodyTypeScale.Value = 1
        bodyProportionScale.Value = 1
    end

    return bool2, bool3, var1
end

function module.SetupBodyPartMannequin(bool1: boolean, bool2: boolean, arg1, tbl2, str1: string?)
    module.AssertObjectsFormat(tbl2)
    local bool3 = false

    if str1 then
        game:GetObjects(str1)[1].Parent = arg1
    end

    local function addFolderChildren(arg2, tbl3, tbl4)
        for _, child in pairs(arg2:GetChildren()) do
            assert(child:IsA("BasePart"), "Only BaseParts should be in Folders")

            if string.find(child.Name, "Right") then
                bool3 = true
            end
            arg1:FindFirstChild("Humanoid"):ReplaceBodyPartR15(module.R15PartNameToEnum[child.Name], child)
            table.insert(tbl3, child.Name)
            table.insert(tbl4, child)
        end
    end

    local str2 = if bool1 and bool2 then "R15ArtistIntent" else "R15"

    local tbl3 = {}
    local tbl4 = {}

    for _, value in pairs(tbl2) do
        if bool1 and value.Name == str2 or not bool1 and value.Name == "R6" then
            addFolderChildren(value, tbl4, tbl3)
        elseif not string.find(value.Name, "R15") then
            value.Parent = arg1
        end
    end

    if bool1 then
        local humanoidRootPart = arg1:FindFirstChild("HumanoidRootPart")
        arg1.PrimaryPart = humanoidRootPart
        humanoidRootPart.CFrame = CFrame.new(Vector3.new(0, 5, 0)) * CFrame.Angles(0, math.pi, 0)
        humanoidRootPart.Anchored = true
        arg1:FindFirstChildOfClass("Humanoid"):BuildRigFromAttachments()
    end
    return bool3, tbl4
end

function module.CreateHeadModel(arg1): Model
    local model = Instance.new("Model")

    arg1.Name = "Head"
    arg1.Parent = model

    local humanoid = Instance.new("Humanoid")
    humanoid.RigType = Enum.HumanoidRigType.R15
    humanoid.Parent = model

    humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None

    return model
end

return module
