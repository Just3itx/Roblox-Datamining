-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:30:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local Thunk = require(scriptParentParent.Thunk)
local AssetInfo = require(scriptParentParent.Models.AssetInfo)
local SetEquippedAssets = require(scriptParentParent.Actions.SetEquippedAssets)
local Constants = require(scriptParentParent.Constants)
local GetAvatarPreview = require(scriptParentParent.Thunks.GetAvatarPreview)
local SendCounter = require(scriptParentParent.Thunks.SendCounter)

local CorePackages = game:GetService("CorePackages")
local Promise = require(CorePackages.Packages.Promise)
local AvatarExperienceFlags = require(CorePackages.Workspace.Packages.AvatarExperienceFlags)
local AvatarBackground = require(CorePackages.Workspace.Packages.DataHydration.AvatarBackground)
local FFlagAXInspectAndBuyMakeupSupport = AvatarExperienceFlags.FFlagAXInspectAndBuyMakeupSupport
local FFlagAXInspectAndBuyAvatarBackground = AvatarExperienceFlags.FFlagAXInspectAndBuyAvatarBackground

local tbl1 = {}

local function getAssetIds(arg1)
    local assetIds = {}

    local bool1 = false

    for value, value2 in Constants.AssetTypeIdStringToHumanoidDescriptionProp do
        if Constants.AssetTypeIdToAccessoryTypeEnum[value] ~= nil then
            continue
        end

        local var1 = arg1[value2] or ""

        local headValue = Enum.AssetType.Head.Value
        local bool2

        if value == tostring(headValue) then
            bool2 = true
        else
            local dynamicHeadValue = Enum.AssetType.DynamicHead.Value
            bool2 = value == tostring(dynamicHeadValue)
        end

        if bool1 and bool2 then
            continue
        end

        if bool2 then
            bool1 = true
        end

        for _, value3 in string.split(var1) do
            if tonumber(value3) and value3 ~= "0" then
                table.insert(assetIds, AssetInfo.fromHumanoidDescription(value3))
            end
        end
    end

    for _, value in (arg1:GetAccessories(true)) do
        assetIds[#assetIds + 1] = AssetInfo.fromHumanoidDescriptionAccessory(value)
    end

    for _, value in (arg1:GetEmotes()) do
        for _, value2 in value do
            assetIds[#assetIds + 1] = AssetInfo.fromHumanoidDescription(value2)
        end
    end

    if FFlagAXInspectAndBuyMakeupSupport then
        for _, child in arg1:GetChildren() do
            if child:IsA("MakeupDescription") and child.AssetId > 0 then
                assetIds[#assetIds + 1] = AssetInfo.fromHumanoidDescription(child.AssetId)
            end
        end
    end

    return assetIds
end

local function withEquippedBackground(arg1, assetIds, playerId)
    if playerId == nil or playerId == "" then
        return Promise.resolve(assetIds)
    end
    return AvatarBackground.getAvatarBackgroundStore(false).awaitAvatarBackground(playerId):andThen(function(arg2)
        if not arg2.assetId then
            return assetIds
        end
        local var1 = table.clone(assetIds)
        table.insert(var1, AssetInfo.fromHumanoidDescription(arg2.assetId))
        return var1
    end):catch(function()
        arg1:dispatch(SendCounter(Constants.Counters.GetAvatarBackground .. Constants.CounterSuffix.RequestFailed))
        return assetIds
    end)
end

local function dispatchPreviewWithEquippedBackground(arg1, assetIds, arg2) -- Luacid: Inlined by compiler; 1 call site recovered
    withEquippedBackground(arg1, assetIds, arg1:getState().playerId):andThen(function(arg3)
        if arg2 and not arg2() then
            return
        end
        arg1:dispatch(GetAvatarPreview(arg3))
    end)
end

local function GetAssetsFromHumanoidDescriptionV2(arg1, arg2, arg3)
    return Thunk.new(script.Name, tbl1, function(arg4, _)
        local assetIds = getAssetIds(arg1)
        if arg2 then
            arg4:dispatch(SetEquippedAssets(assetIds))

            return
        end

        if FFlagAXInspectAndBuyAvatarBackground then
            dispatchPreviewWithEquippedBackground(arg4, assetIds, arg3)
            return
        end
        arg4:dispatch(GetAvatarPreview(assetIds))
    end)
end
return GetAssetsFromHumanoidDescriptionV2
