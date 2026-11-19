-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:11:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarEditorService = game:GetService("AvatarEditorService")
local CorePackages = game:GetService("CorePackages")

local Promise = require(CorePackages.Packages.Promise)

local currentHumanoidDescription = nil
local var1 = nil

local function removeDefaultClothing(arg1, callback, callback2)
    local avatarRulesAsync = AvatarEditorService:GetAvatarRulesAsync()

    if not avatarRulesAsync.DefaultClothingAssetLists then
        callback2("No default clothing in avatar rules")
        return
    end

    local defaultShirtAssetIds = avatarRulesAsync.DefaultClothingAssetLists.DefaultShirtAssetIds
    local defaultPantAssetIds = avatarRulesAsync.DefaultClothingAssetLists.DefaultPantAssetIds

    if not (defaultShirtAssetIds and defaultPantAssetIds) then
        callback2("No default clothing ids in avatar rules")
        return
    end

    local var2 = nil
    for _, defaultShirtAssetId in ipairs(defaultShirtAssetIds) do
        if defaultShirtAssetId == arg1.Shirt then
            var2 = var2 or arg1:Clone()
            var2.Shirt = 0
        end
    end

    for _, defaultPantAssetId in ipairs(defaultPantAssetIds) do
        if defaultPantAssetId == arg1.Pants then
            var2 = var2 or arg1:Clone()
            var2.Pants = 0
        end
    end

    callback(var2 or arg1)
end

local function GetConformedHumanoidDescription(humanoidDescription: HumanoidDescription, arg1)
    if humanoidDescription == currentHumanoidDescription then
        if arg1 then
            return Promise.resolve(var1)
        end
        return Promise.new(function(callback, arg2)
            removeDefaultClothing(var1, callback, arg2)
        end)
    end

    return Promise.new(function(callback, callback2)
        coroutine.wrap(function()
            local success, result = pcall(function(): HumanoidDescription
                return AvatarEditorService:ConformToAvatarRulesAsync(humanoidDescription)
            end)

            if not success then
                callback2(result)

                return
            end

            currentHumanoidDescription = humanoidDescription
            var1 = result

            if arg1 then
                callback(result)
                return
            end
            removeDefaultClothing(result, callback, callback2)
        end)()
    end)
end

return GetConformedHumanoidDescription
