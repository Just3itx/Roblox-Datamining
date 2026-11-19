-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:30:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local PerformFetch = require(CorePackages.Workspace.Packages.Http).PerformFetch
local scriptParentParent = script.Parent.Parent
local Thunk = require(scriptParentParent.Thunk)
local Network = require(scriptParentParent.Services.Network)
local BundleInfo = require(scriptParentParent.Models.BundleInfo)
local SetBundles = require(scriptParentParent.Actions.SetBundles)
local GetProductInfo = require(scriptParentParent.Thunks.GetProductInfo)
local createInspectAndBuyKeyMapper = require(scriptParentParent.createInspectAndBuyKeyMapper)
local SetAssetToBundlesMapping = require(scriptParentParent.Actions.SetAssetToBundlesMapping)
local SendCounter = require(scriptParentParent.Thunks.SendCounter)
local Constants = require(scriptParentParent.Constants)

local tbl1 = { Network }

local inspectAndBuyKeyMapper = createInspectAndBuyKeyMapper("getAssetBundles")

local function GetAssetBundles(arg1)
    return Thunk.new(script.Name, tbl1, function(arg2, arg3)
        local var1 = arg3[Network]

        local var2 = inspectAndBuyKeyMapper(arg2:getState().storeId, arg1)

        return PerformFetch.Single(var2, function(_)
            return var1.getAssetBundles(arg1):andThen(function(arg4)
                local tbl2 = {}
                local tbl3 = {}

                for _, value in pairs(arg4.data) do
                    local getAssetBundles = BundleInfo.fromGetAssetBundles(value)
                    table.insert(tbl3, getAssetBundles)
                    table.insert(tbl2, tostring(getAssetBundles.bundleId))

                    local bool1 = false
                    for _, item in pairs(value.items) do
                        if item.type == "UserOutfit" then
                            bool1 = true
                            break
                        end
                    end

                    if bool1 then
                        continue
                    end

                    for _, item in pairs(value.items) do
                        if not arg2:getState().assets[item.id] then
                            coroutine.wrap(function()
                                arg2:dispatch(GetProductInfo(item.id))
                            end)()
                        end
                    end
                end

                arg2:dispatch(SetBundles(tbl3))

                arg2:dispatch(SetAssetToBundlesMapping(tostring(arg1), tbl2))

                arg2:dispatch(SendCounter(Constants.Counters.GetAssetBundles .. Constants.CounterSuffix.RequestSucceeded))
            end, function(_)
                arg2:dispatch(SendCounter(Constants.Counters.GetAssetBundles .. Constants.CounterSuffix.RequestRejected))
            end)
        end)(arg2):catch(function(_)
            arg2:dispatch(SendCounter(Constants.Counters.GetAssetBundles .. Constants.CounterSuffix.RequestFailed))
        end)
    end)
end

return GetAssetBundles
