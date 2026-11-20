-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T10:01:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")

local R15 = Enum.HumanoidRigType.R15

local function isKnownAvatarType(str1: string?): boolean -- Luacid: Inlined by compiler; 3 call sites recovered
    return str1 == "R6" or str1 == "R15"
end

local function rigTypeFromName(str1: string?): Enum.HumanoidRigType -- Luacid: Inlined by compiler; 2 call sites recovered
    if not isKnownAvatarType(str1) then
        warn(`resolveOutfit: unrecognized PlayerAvatarType {str1}, assuming R15`)
    end
    return if str1 == "R6" then Enum.HumanoidRigType.R6 else R15
end

local function gearAssetIdFromAssets(arg1)
    if typeof(arg1) ~= "table" then
        return nil
    end
    for _, value in arg1 do
        if typeof(value) ~= "table" then
            continue
        end

        local var1 = value.AssetType or value.assetType

        if (if typeof(var1) == "table" then var1.Id or var1.id else nil) ~= Enum.AssetType.Gear.Value then
            continue
        end

        local var2 = value.Id or value.id
        if typeof(var2) == "number" and var2 > 0 then
            return var2
        end
    end

    return nil
end

local function resolveDetails(outfitId: number)
    local success, result = pcall(function()
        return game:GetService("AvatarEditorService"):GetOutfitDetailsAsync(outfitId)
    end)
    if success and typeof(result) == "table" then
        return {
            rigType = rigTypeFromName(result.PlayerAvatarType),
            gearAssetId = gearAssetIdFromAssets(result.Assets)
        }
    end

    warn(`resolveOutfit: outfit {outfitId} details unavailable, assuming R15 ({result})`)
    return { rigType = R15, gearAssetId = nil }
end

local function resolveUserDetails(userId: number)
    local success, result = pcall(function()
        return Players:GetCharacterAppearanceInfoAsync(userId)
    end)
    if success and typeof(result) == "table" then
        return {
            rigType = rigTypeFromName(result.playerAvatarType),
            gearAssetId = gearAssetIdFromAssets(result.assets)
        }
    end

    warn(`resolveOutfit: user {userId} appearance info unavailable, assuming R15 ({result})`)
    return { rigType = R15, gearAssetId = nil }
end

return {
    resolve = function(outfitId: number)
        local success, result = pcall(function(): HumanoidDescription
            return Players:GetHumanoidDescriptionFromOutfitIdAsync(outfitId)
        end)
        if not success or typeof(result) ~= "Instance" then
            error(`resolveOutfit: outfit {outfitId} did not resolve ({result})`)
        end

        local var1 = resolveDetails(outfitId)
        return {
            rigType = var1.rigType,
            humanoidDescription = result,
            gearAssetId = var1.gearAssetId
        }
    end,
    resolveUser = function(userId: number)
        local success, result = pcall(function(): HumanoidDescription
            return Players:GetHumanoidDescriptionFromUserIdAsync(userId)
        end)
        if not success or typeof(result) ~= "Instance" then
            error(`resolveOutfit: user {userId} did not resolve ({result})`)
        end

        local var1 = resolveUserDetails(userId)
        return {
            rigType = var1.rigType,
            humanoidDescription = result,
            gearAssetId = var1.gearAssetId
        }
    end,
    rigTypeFromName = rigTypeFromName,
    isKnownAvatarType = isKnownAvatarType,
    gearAssetIdFromAssets = gearAssetIdFromAssets
}
