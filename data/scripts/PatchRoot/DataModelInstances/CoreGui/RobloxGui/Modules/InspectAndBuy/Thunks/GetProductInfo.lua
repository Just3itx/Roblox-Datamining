-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:31:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local PerformFetch = require(CorePackages.Workspace.Packages.Http).PerformFetch
local scriptParentParent = script.Parent.Parent
local Thunk = require(scriptParentParent.Thunk)
local Network = require(scriptParentParent.Services.Network)
local AssetInfo = require(scriptParentParent.Models.AssetInfo)
local SetAssets = require(scriptParentParent.Actions.SetAssets)
local createInspectAndBuyKeyMapper = require(scriptParentParent.createInspectAndBuyKeyMapper)
local SendCounter = require(scriptParentParent.Thunks.SendCounter)
local Constants = require(scriptParentParent.Constants)

local tbl1 = { Network }

local inspectAndBuyKeyMapper = createInspectAndBuyKeyMapper("getProductInfo")

local function GetProductInfo(arg1)
    return Thunk.new(script.Name, tbl1, function(arg2, arg3)
        local var1 = arg3[Network]

        local var2 = inspectAndBuyKeyMapper(arg2:getState().storeId, arg1)

        return PerformFetch.Single(var2, function()
            return var1.getProductInfo(arg1):andThen(function(arg4)
                local getProductInfo = AssetInfo.fromGetProductInfo(arg4)
                arg2:dispatch(SetAssets({ getProductInfo }))
                arg2:dispatch(SendCounter(Constants.Counters.GetProductInfo .. Constants.CounterSuffix.RequestSucceeded))
            end, function(_)
                arg2:dispatch(SendCounter(Constants.Counters.GetProductInfo .. Constants.CounterSuffix.RequestRejected))
            end)
        end)(arg2):catch(function(_)
            arg2:dispatch(SendCounter(Constants.Counters.GetProductInfo .. Constants.CounterSuffix.RequestFailed))
        end)
    end)
end

return GetProductInfo
