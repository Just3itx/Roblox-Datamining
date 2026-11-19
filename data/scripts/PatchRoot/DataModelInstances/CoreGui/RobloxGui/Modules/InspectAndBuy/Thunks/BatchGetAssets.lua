-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:21:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local PerformFetch = require(CorePackages.Workspace.Packages.Http).PerformFetch
local scriptParentParent = script.Parent.Parent
local Thunk = require(scriptParentParent.Thunk)
local Network = require(scriptParentParent.Services.Network)
local SendCounter = require(scriptParentParent.Thunks.SendCounter)
local Constants = require(scriptParentParent.Constants)
local SetAssets = require(scriptParentParent.Actions.SetAssets)
local GetProductInfo = require(scriptParentParent.Thunks.GetProductInfo)
local GetAssetBundles = require(scriptParentParent.Thunks.GetAssetBundles)
local GetVersionInfo = require(scriptParentParent.Thunks.GetVersionInfo)

local tbl1 = { Network }

local function BatchGetAssets(arg1)
    return Thunk.new(script.Name, tbl1, function(arg2, arg3)
        local var1 = arg3[Network]

        local tbl2 = {}
        if arg1 then
            for _, value in arg1 do
                table.insert(tbl2, tonumber(value.assetId))
            end
        end

        return PerformFetch.Single("BatchGetAssets", function()
            return var1.getBatchItemDetails(tbl2, Enum.AvatarItemType.Asset):andThen(function(arg4)
                local tbl3 = {}
                for _, value in arg4 do
                    table.insert(tbl3, { assetId = tostring(value.Id) })
                end

                for _, value in tbl3 do
                    coroutine.wrap(function()
                        arg2:dispatch(GetProductInfo(value.assetId))

                        if value.parentBundleId == nil then
                            arg2:dispatch(GetAssetBundles(value.assetId))
                        end

                        arg2:dispatch(GetVersionInfo(value.assetId))
                    end)()
                end

                arg2:dispatch(SetAssets(tbl3))

                arg2:dispatch(SendCounter(Constants.Counters.BatchGetAssets .. Constants.CounterSuffix.RequestSucceeded))
            end, function(_)
                arg2:dispatch(SendCounter(Constants.Counters.BatchGetAssets .. Constants.CounterSuffix.RequestRejected))
            end)
        end)(arg2):catch(function(_)
            arg2:dispatch(SendCounter(Constants.Counters.BatchGetAssets .. Constants.CounterSuffix.RequestFailed))
        end)
    end)
end

return BatchGetAssets
