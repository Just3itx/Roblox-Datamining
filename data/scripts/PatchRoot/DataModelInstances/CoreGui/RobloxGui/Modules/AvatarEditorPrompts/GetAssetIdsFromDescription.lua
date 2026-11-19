-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:11:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local FFlagAXSpawnEffectSaveRoundTrip = require(CorePackages.Workspace.Packages.AvatarExperienceFlags).FFlagAXSpawnEffectSaveRoundTrip

local tbl1 = {
    "ClimbAnimation",
    "Face",
    "FallAnimation",
    "GraphicTShirt",
    "Head",
    "IdleAnimation",
    "JumpAnimation",
    "LeftArm",
    "LeftLeg",
    "Pants",
    "RightArm",
    "RightLeg",
    "RunAnimation",
    "Shirt",
    "SwimAnimation",
    "Torso",
    "WalkAnimation"
}

return function(arg1)
    local result = {}

    for _, value in ipairs(tbl1) do
        local var1 = arg1[value]
        if typeof(var1) == "number" and var1 > 0 then
            table.insert(result, var1)
        elseif typeof(var1) == "string" and var1 ~= "" then
            for value2 in var1:gmatch("([%d]+),?") do
                table.insert(result, tonumber(value2))
            end
        end
    end

    local accessories = arg1:GetAccessories(true)
    for _, value in ipairs(accessories) do
        table.insert(result, value.AssetId)
    end

    for _, child in (arg1:GetChildren()) do
        if (child:IsA("MakeupDescription") or FFlagAXSpawnEffectSaveRoundTrip and child:IsA("AvatarEffectDescription"))
            and child.AssetId > 0
        then
            table.insert(result, child.AssetId)
        end
    end

    local emotes = arg1:GetEmotes()
    local equippedEmotes = arg1:GetEquippedEmotes()

    for _, value in ipairs(equippedEmotes) do
        local var1 = emotes[value.Name]
        if not var1 then
            continue
        end

        for _, value2 in ipairs(var1) do
            table.insert(result, value2)
        end
    end

    return result
end
