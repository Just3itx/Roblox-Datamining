-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:31:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local PerformFetch = require(CorePackages.Workspace.Packages.Http).PerformFetch
local scriptParentParent = script.Parent.Parent
local Thunk = require(scriptParentParent.Thunk)
local AssetInfo = require(scriptParentParent.Models.AssetInfo)
local BundleInfo = require(scriptParentParent.Models.BundleInfo)
local Network = require(scriptParentParent.Services.Network)
local SetAssets = require(scriptParentParent.Actions.SetAssets)
local SetBundles = require(scriptParentParent.Actions.SetBundles)
local GetExperiencePlayability = require(scriptParentParent.Thunks.GetExperiencePlayability)
local GetExperienceInfo = require(scriptParentParent.Thunks.GetExperienceInfo)
local createInspectAndBuyKeyMapper = require(scriptParentParent.createInspectAndBuyKeyMapper)
local SendCounter = require(scriptParentParent.Thunks.SendCounter)
local Constants = require(scriptParentParent.Constants)

local tbl1 = { Network }

local inspectAndBuyKeyMapper = createInspectAndBuyKeyMapper("getItemDetails")

local function GetItemDetails(arg1, avatarItemType)
    return Thunk.new(script.Name, tbl1, function(arg2, arg3)
        local var1 = arg3[Network]

        local var2 = inspectAndBuyKeyMapper(arg2:getState().storeId, arg1, avatarItemType)

        return PerformFetch.Single(var2, function()
            return var1.getItemDetails(arg1, avatarItemType):andThen(function(arg4)
                if avatarItemType == Enum.AvatarItemType.Asset then
                    local getItemDetails = AssetInfo.fromGetItemDetails(arg4)
                    arg2:dispatch(SetAssets({ getItemDetails }))
                elseif avatarItemType == Enum.AvatarItemType.Bundle then
                    local getItemDetails = BundleInfo.fromGetItemDetails(arg4)
                    arg2:dispatch(SetBundles({ getItemDetails }))
                else
                    arg2:dispatch(SendCounter(Constants.Counters.GetItemDetailsRespondedWithUnknownItemType))
                end

                if arg4.CreatingUniverseId then
                    arg2:dispatch(GetExperiencePlayability(arg4.CreatingUniverseId))
                    arg2:dispatch(GetExperienceInfo(arg4.CreatingUniverseId))
                end

                arg2:dispatch(SendCounter(Constants.Counters.GetItemDetails .. Constants.CounterSuffix.RequestSucceeded))
            end, function(_)
                arg2:dispatch(SendCounter(Constants.Counters.GetItemDetails .. Constants.CounterSuffix.RequestRejected))
            end)
        end)(arg2):catch(function(_)
            arg2:dispatch(SendCounter(Constants.Counters.GetItemDetails .. Constants.CounterSuffix.RequestFailed))
        end)
    end)
end

return GetItemDetails
