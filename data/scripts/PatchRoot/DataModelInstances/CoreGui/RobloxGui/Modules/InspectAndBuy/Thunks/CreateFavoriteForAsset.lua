-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:21:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Promise = require(CorePackages.Packages.Promise)
local PerformFetch = require(CorePackages.Workspace.Packages.Http).PerformFetch
local scriptParentParent = script.Parent.Parent
local Thunk = require(scriptParentParent.Thunk)
local Network = require(scriptParentParent.Services.Network)
local Analytics = require(scriptParentParent.Services.Analytics)
local SetFavoriteAsset = require(scriptParentParent.Actions.SetFavoriteAsset)
local SetAssets = require(scriptParentParent.Actions.SetAssets)
local AssetInfo = require(scriptParentParent.Models.AssetInfo)
local createInspectAndBuyKeyMapper = require(scriptParentParent.createInspectAndBuyKeyMapper)
local SendCounter = require(scriptParentParent.Thunks.SendCounter)
local Constants = require(scriptParentParent.Constants)

local tbl1 = { Network, Analytics }

local inspectAndBuyKeyMapper = createInspectAndBuyKeyMapper("createFavoriteForAsset")

local function CreateFavoriteForAsset(arg1)
    return Thunk.new(script.Name, tbl1, function(arg2, arg3)
        local var1 = arg3[Network]
        local var2 = arg3[Analytics]

        local var3 = inspectAndBuyKeyMapper(arg2:getState().storeId, arg1)

        return PerformFetch.Single(var3, function(_)
            return var1.createFavoriteForAsset(arg1):andThen(function()
                arg2:dispatch(SetFavoriteAsset(arg1, true))
                local numFavorites = arg2:getState().assets[arg1].numFavorites
                local getAssetFavoriteCount = AssetInfo.fromGetAssetFavoriteCount(arg1, numFavorites + 1)
                arg2:dispatch(SetAssets({ getAssetFavoriteCount }))
                var2.reportFavoriteItem("Asset", arg1, true, true, "", numFavorites + 1)

                arg2:dispatch(SendCounter(Constants.Counters.CreateFavoriteForAsset .. Constants.CounterSuffix.RequestSucceeded))

                return Promise.resolve()
            end, function(arg4)
                arg2:dispatch(SendCounter(Constants.Counters.CreateFavoriteForAsset .. Constants.CounterSuffix.RequestRejected))

                return Promise.reject(tostring(arg4.StatusMessage))
            end)
        end)(arg2):catch(function(arg4)
            local numFavorites = arg2:getState().assets[arg1].numFavorites
            var2.reportFavoriteItem("Asset", arg1, true, false, arg4, numFavorites)
            arg2:dispatch(SendCounter(Constants.Counters.CreateFavoriteForAsset .. Constants.CounterSuffix.RequestFailed))
        end)
    end)
end

return CreateFavoriteForAsset
