-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T23:01:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")

local bool1 = game:DefineFastFlag("GetHumanoidDescriptionUpdatesV2B", false)

local GetHumanoidDescriptionParent = script:FindFirstAncestor("GetHumanoidDescription").Parent
local GetFFlagGetHumanoidDescriptionUpdatesV2E = require(GetHumanoidDescriptionParent.SharedFlags).GetFFlagGetHumanoidDescriptionUpdatesV2E

local function func1(arg1)
    local result = {}
    for _, value in ipairs(arg1) do
        table.insert(result, {
            AccessoryType = value.AccessoryType.Value,
            AssetId = value.AssetId,
            IsLayered = value.IsLayered,
            Order = value.Order,
            Puffiness = value.Puffiness
        })
    end
    return result
end

local function func2(arg1, arg2)
    local result = {}
    for _, value in ipairs(arg2) do
        local var1 = arg1[value.Name]
        if not var1 then
            continue
        end

        local num1 = #var1

        for i = 1, math.min(8, num1) do
            table.insert(result, var1[i])
        end
    end

    return result
end

local function func3(arg1: Instance)
    local result = {}
    for _, playingAnimationTrack in (arg1:GetPlayingAnimationTracks()) do
        local var1 = string.match(playingAnimationTrack.Animation.AnimationId, "(%d+)$")
        if var1 then
            table.insert(result, var1)
        end
        if #result >= 8 then
            break
        end
    end

    return result
end

return function(userId: number)
    local player = Players:GetPlayerByUserId(userId)

    local tbl1 = {
        BackAccessory = "",
        BodyTypeScale = 0,
        ClimbAnimation = 0,
        DepthScale = 0,
        Face = 0,
        FaceAccessory = "",
        FallAnimation = 0,
        FrontAccessory = "",
        GraphicTShirt = 0,
        HairAccessory = "",
        HatAccessory = "",
        Head = 0,
        HeadColor = { 0, 0, 0 },
        HeadScale = 0,
        HeightScale = 0,
        IdleAnimation = 0,
        JumpAnimation = 0,
        LeftArm = 0,
        LeftArmColor = { 0, 0, 0 },
        LeftLeg = 0,
        LeftLegColor = { 0, 0, 0 },
        MoodAnimation = 0,
        NeckAccessory = "",
        Pants = 0,
        ProportionScale = 0,
        RightArm = 0,
        RightArmColor = { 0, 0, 0 },
        RightLeg = 0,
        RightLegColor = { 0, 0, 0 },
        RunAnimation = 0,
        Shirt = 0,
        ShouldersAccessory = "",
        SwimAnimation = 0,
        Torso = 0,
        TorsoColor = { 0, 0, 0 },
        WaistAccessory = "",
        WalkAnimation = 0,
        WidthScale = 0
    }

    if not player then
        return tbl1, "ERR_RA_HUMPLAYER"
    end

    local character = player.Character

    if not character then
        return tbl1, "ERR_RA_CHARACTER"
    end

    local humanoid = character:WaitForChild("Humanoid", 1)

    if not humanoid then
        return tbl1, "ERR_RA_HUMOBJ"
    end

    local success, result = pcall(function(): HumanoidDescription
        return (humanoid:GetAppliedDescription())
    end)

    local var1 = result

    if not success then
        return tbl1, "ERR_RA_HUMOBJ"
    end

    if not var1 then
        return tbl1, "ERR_RA_HUMDESC"
    end

    local num1 = 0

    local function func4(arg1)
        if typeof(var1[arg1]) ~= "Color3" then
            tbl1[arg1] = var1[arg1]

            return
        end

        tbl1[arg1] = { var1[arg1].R, var1[arg1].G, var1[arg1].B }
    end
    for k, _ in pairs(tbl1) do
        if not pcall(func4, k) then
            num1 += 1
        end
    end

    local success2, result2 = pcall(var1.GetAccessories, var1, false)
    if success2 then
        local success3, result3 = pcall(func1, result2)
        if success3 then
            tbl1.AccessoryBlob = result3
        else
            num1 += 1
        end
    else
        num1 += 1
    end

    if bool1 then
        local success3, result3 = pcall(var1.GetEmotes, var1)
        if success3 then
            tbl1.Emotes = result3
        else
            num1 += 1
        end
    end

    local success3, result3 = pcall(var1.GetEquippedEmotes, var1)
    local success4, result4 = pcall(var1.GetEmotes, var1)

    if success3 and success4 then
        local success5, result5 = pcall(func2, result4, result3)
        if success5 then
            tbl1.Emotes = result5

            if GetFFlagGetHumanoidDescriptionUpdatesV2E() then
                local success6, result6 = pcall(func3, humanoid)

                if success6 then
                    tbl1.CurrentlyPlayingAnimationIds = result6
                else
                    num1 += 1
                end
            end
        end
    else
        num1 += 1
    end

    tbl1.FieldErrorCount = num1

    return tbl1, "OK"
end
