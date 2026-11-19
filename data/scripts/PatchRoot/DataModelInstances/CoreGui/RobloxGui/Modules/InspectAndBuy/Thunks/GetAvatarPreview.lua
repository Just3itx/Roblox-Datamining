-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:30:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local PerformFetch = require(CorePackages.Workspace.Packages.Http).PerformFetch
local scriptParentParent = script.Parent.Parent
local Thunk = require(scriptParentParent.Thunk)
local Network = require(scriptParentParent.Services.Network)
local SendCounter = require(scriptParentParent.Thunks.SendCounter)
local Constants = require(scriptParentParent.Constants)
local SetAvatarPreviewDetails = require(scriptParentParent.Actions.SetAvatarPreviewDetails)
local AssetInfo = require(scriptParentParent.Models.AssetInfo)
local BundleInfo = require(scriptParentParent.Models.BundleInfo)
local SetAssets = require(scriptParentParent.Actions.SetAssets)
local SetBundles = require(scriptParentParent.Actions.SetBundles)
local AvatarExperienceInspectAndBuy = require(CorePackages.Workspace.Packages.AvatarExperienceInspectAndBuy)
local AvatarExperienceFlags = require(CorePackages.Workspace.Packages.AvatarExperienceFlags)
local ItemTypeEnum = require(CorePackages.Workspace.Packages.AvatarExperienceModel).Enums.ItemTypeEnum
local GetItemDetails = require(scriptParentParent.Thunks.GetItemDetails)
local FFlagAXEnableBatchItemDetailsFetchV2 = AvatarExperienceFlags.FFlagAXEnableBatchItemDetailsFetchV2
local BatchItemDetailsPerformFetchKey = AvatarExperienceInspectAndBuy.Constants.BatchItemDetailsPerformFetchKey
local FFlagAXWrapInspectAndBuyThunksInTasks = require(scriptParentParent.Flags.FFlagAXWrapInspectAndBuyThunksInTasks)

local tbl1 = { Network }

local function GetAvatarPreview(arg1)
    return Thunk.new(script.Name, tbl1, function(arg2, arg3)
        local var1 = arg3[Network]

        local tbl2 = {}
        if arg1 then
            for _, value in arg1 do
                table.insert(tbl2, { id = value.assetId, meta = value.meta })
            end
        end

        return PerformFetch.Single("PreviewAvatar", function()
            return var1.getPreviewAvatar(tbl2):andThen(function(arg4)
                arg2:dispatch(SetAvatarPreviewDetails(arg4))

                if not FFlagAXEnableBatchItemDetailsFetchV2 and arg4.look and arg4.look.items then
                    for _, item in arg4.look.items do
                        if FFlagAXWrapInspectAndBuyThunksInTasks then
                            task.spawn(function()
                                if item.itemType == ItemTypeEnum.Asset then
                                    arg2:dispatch(GetItemDetails(item.id, Enum.AvatarItemType.Asset))
                                elseif item.itemType == ItemTypeEnum.Bundle then
                                    arg2:dispatch(GetItemDetails(item.id, Enum.AvatarItemType.Bundle))
                                end
                            end)
                        elseif item.itemType == ItemTypeEnum.Asset then
                            arg2:dispatch(GetItemDetails(item.id, Enum.AvatarItemType.Asset))
                        elseif item.itemType == ItemTypeEnum.Bundle then
                            arg2:dispatch(GetItemDetails(item.id, Enum.AvatarItemType.Bundle))
                        end
                    end
                end

                if not FFlagAXEnableBatchItemDetailsFetchV2 then
                    return
                end

                local tbl3 = {}
                if arg4.look and arg4.look.items then
                    for _, item in arg4.look.items do
                        table.insert(tbl3, {
                            itemType = if item.itemType == ItemTypeEnum.Asset then Enum.AvatarItemType.Asset.Value else Enum.AvatarItemType.Bundle.Value,
                            id = tonumber(item.id) or 0
                        })
                    end
                end
                PerformFetch.Single(BatchItemDetailsPerformFetchKey, function()
                    return var1.getBatchItemDetailsV2(tbl3):andThen(function(arg5)
                        if FFlagAXWrapInspectAndBuyThunksInTasks and arg5 and arg5.data then
                            task.spawn(function()
                                local tbl4 = {}
                                local tbl5 = {}
                                for _, value in arg5.data do
                                    if value.itemType == ItemTypeEnum.Asset then
                                        table.insert(tbl4, AssetInfo.fromGetItemDetailsV2(value))
                                    elseif value.itemType == ItemTypeEnum.Bundle then
                                        table.insert(tbl5, BundleInfo.fromGetItemDetailsV2(value))
                                    end
                                end

                                arg2:dispatch(SetAssets(tbl4))
                                arg2:dispatch(SetBundles(tbl5))
                            end)

                            return
                        end

                        if not arg5 or not arg5.data then
                            return
                        end

                        local tbl4 = {}
                        local tbl5 = {}
                        for _, value in arg5.data do
                            if value.itemType == ItemTypeEnum.Asset then
                                table.insert(tbl4, AssetInfo.fromGetItemDetailsV2(value))
                            elseif value.itemType == ItemTypeEnum.Bundle then
                                table.insert(tbl5, BundleInfo.fromGetItemDetailsV2(value))
                            end
                        end

                        arg2:dispatch(SetAssets(tbl4))
                        arg2:dispatch(SetBundles(tbl5))
                    end, function(_)
                        arg2:dispatch(SendCounter(Constants.Counters.BatchGetItemDetails .. Constants.CounterSuffix.RequestRejected))
                    end)
                end)(arg2)

                arg2:dispatch(SendCounter(Constants.Counters.BatchGetItemDetails .. Constants.CounterSuffix.RequestSucceeded))
            end, function(_)
                arg2:dispatch(SendCounter(Constants.Counters.GetAvatarPreview .. Constants.CounterSuffix.RequestRejected))
            end)
        end)(arg2):catch(function(_)
            arg2:dispatch(SendCounter(Constants.Counters.GetAvatarPreview .. Constants.CounterSuffix.RequestFailed))
        end)
    end)
end

return GetAvatarPreview
