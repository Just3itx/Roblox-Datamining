-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:30:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local PerformFetch = require(CorePackages.Workspace.Packages.Http).PerformFetch
local scriptParentParent = script.Parent.Parent
local Thunk = require(scriptParentParent.Thunk)
local Network = require(scriptParentParent.Services.Network)
local SetBundles = require(scriptParentParent.Actions.SetBundles)
local BundleInfo = require(scriptParentParent.Models.BundleInfo)
local createInspectAndBuyKeyMapper = require(scriptParentParent.createInspectAndBuyKeyMapper)
local SendCounter = require(scriptParentParent.Thunks.SendCounter)
local Constants = require(scriptParentParent.Constants)

local tbl1 = { Network }

local inspectAndBuyKeyMapper = createInspectAndBuyKeyMapper("getBundleFavoriteCount")

local function GetBundleFavoriteCount(arg1)
    return Thunk.new(script.Name, tbl1, function(arg2, arg3)
        local var1 = arg3[Network]

        local var2 = inspectAndBuyKeyMapper(arg2:getState().storeId, arg1)

        return PerformFetch.Single(var2, function(_)
            return var1.getBundleFavoriteCount(arg1):andThen(function(arg4)
                if arg4 then
                    local getBundleFavoriteCount = BundleInfo.fromGetBundleFavoriteCount(arg1, arg4)
                    arg2:dispatch(SetBundles({ getBundleFavoriteCount }))
                end
                arg2:dispatch(SendCounter(Constants.Counters.GetBundleFavoriteCount .. Constants.CounterSuffix.RequestSucceeded))
            end, function(_)
                arg2:dispatch(SendCounter(Constants.Counters.GetBundleFavoriteCount .. Constants.CounterSuffix.RequestRejected))
            end)
        end)(arg2):catch(function(_)
            arg2:dispatch(SendCounter(Constants.Counters.GetBundleFavoriteCount .. Constants.CounterSuffix.RequestFailed))
        end)
    end)
end

return GetBundleFavoriteCount
