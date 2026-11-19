-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:30:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local Thunk = require(scriptParentParent.Thunk)
local GetProductInfo = require(scriptParentParent.Thunks.GetProductInfo)
local GetVersionInfo = require(scriptParentParent.Thunks.GetVersionInfo)
local AssetInfo = require(scriptParentParent.Models.AssetInfo)
local SetAssets = require(scriptParentParent.Actions.SetAssets)
local SetEquippedAssets = require(scriptParentParent.Actions.SetEquippedAssets)
local Constants = require(scriptParentParent.Constants)
local GetAssetBundles = require(scriptParentParent.Thunks.GetAssetBundles)
local BatchGetAssets = require(scriptParentParent.Thunks.BatchGetAssets)

local FFlagAXEnableRegionalFilteringofAssets = require(scriptParentParent.Flags.FFlagAXEnableRegionalFilteringofAssets)

local tbl1 = {}

local function getAssetIds(arg1)
    local assetIds = {}

    for k, value in pairs(Constants.AssetTypeIdStringToHumanoidDescriptionProp) do
        if Constants.AssetTypeIdToAccessoryTypeEnum[k] ~= nil then
            continue
        end

        local var1 = arg1[value] or ""
        for _, value2 in pairs(string.split(var1)) do
            if tonumber(value2) and value2 ~= "0" then
                table.insert(assetIds, AssetInfo.fromHumanoidDescription(value2))
            end
        end
    end

    local accessories = arg1:GetAccessories(true)
    for _, value in pairs(accessories) do
        assetIds[#assetIds + 1] = AssetInfo.fromHumanoidDescription(value.AssetId)
    end

    local emotes = arg1:GetEmotes()

    for _, value in pairs(emotes) do
        for _, value2 in pairs(value) do
            assetIds[#assetIds + 1] = AssetInfo.fromHumanoidDescription(value2)
        end
    end

    return assetIds
end

local function GetAssetsFromHumanoidDescription(arg1, arg2)
    return Thunk.new(script.Name, tbl1, function(arg3, _)
        local assetIds = getAssetIds(arg1)
        if arg2 then
            arg3:dispatch(SetEquippedAssets(assetIds))

            return
        end

        if FFlagAXEnableRegionalFilteringofAssets then
            arg3:dispatch(BatchGetAssets(assetIds))
            return
        end

        for _, assetId in ipairs(assetIds) do
            coroutine.wrap(function()
                arg3:dispatch(GetProductInfo(assetId.assetId))

                if assetId.parentBundleId == nil then
                    arg3:dispatch(GetAssetBundles(assetId.assetId))
                end

                arg3:dispatch(GetVersionInfo(assetId.assetId))
            end)()
        end
        arg3:dispatch(SetAssets(assetIds))
    end)
end
return GetAssetsFromHumanoidDescription
