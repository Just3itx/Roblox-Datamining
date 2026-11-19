-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:30:54Z
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
local createInspectAndBuyKeyMapper = require(scriptParentParent.createInspectAndBuyKeyMapper)
local SendCounter = require(scriptParentParent.Thunks.SendCounter)
local Constants = require(scriptParentParent.Constants)

local tbl1 = { Network }

local inspectAndBuyKeyMapper = createInspectAndBuyKeyMapper("getEconomyProductInfo")

local function GetEconomyProductInfo(arg1, arg2, arg3)
    return Thunk.new(script.Name, tbl1, function(arg4, arg5)
        local var1 = arg5[Network]

        local var2 = inspectAndBuyKeyMapper(arg4:getState().storeId, arg1)

        return PerformFetch.Single(var2, function()
            return var1.getEconomyProductInfo(arg1):andThen(function(arg6)
                local bool1 = not arg6.purchasable and arg6.reason == "AlreadyOwned" or false
                local price = arg6.price or 0
                local purchasable = arg6.purchasable
                local premiumPricing = arg6.premiumPricing

                if not arg6.purchasable and arg6.reason == "InsufficientFunds" then
                    purchasable = true
                end

                if not arg2 then
                    local getEconomyProductInfo = AssetInfo.fromGetEconomyProductInfo(arg6, bool1, price, purchasable, premiumPricing)
                    arg4:dispatch(SetAssets({ getEconomyProductInfo }))
                else
                    local getEconomyProductInfo = BundleInfo.fromGetEconomyProductInfo(bool1, arg3, price, purchasable)
                    arg4:dispatch(SetBundles({ getEconomyProductInfo }))
                end
                arg4:dispatch(SendCounter(Constants.Counters.GetEconomyProductInfo .. Constants.CounterSuffix.RequestSucceeded))
            end, function(_)
                arg4:dispatch(SendCounter(Constants.Counters.GetEconomyProductInfo .. Constants.CounterSuffix.RequestRejected))
            end)
        end)(arg4):catch(function(_)
            arg4:dispatch(SendCounter(Constants.Counters.GetEconomyProductInfo .. Constants.CounterSuffix.RequestFailed))
        end)
    end)
end

return GetEconomyProductInfo
