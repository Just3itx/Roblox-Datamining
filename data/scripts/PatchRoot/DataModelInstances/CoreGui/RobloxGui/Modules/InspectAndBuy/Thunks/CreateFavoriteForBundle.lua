-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:21:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Promise = require(CorePackages.Packages.Promise)
local PerformFetch = require(CorePackages.Workspace.Packages.Http).PerformFetch
local scriptParentParent = script.Parent.Parent
local Thunk = require(scriptParentParent.Thunk)
local Network = require(scriptParentParent.Services.Network)
local Analytics = require(scriptParentParent.Services.Analytics)
local SetFavoriteBundle = require(scriptParentParent.Actions.SetFavoriteBundle)
local SetBundles = require(scriptParentParent.Actions.SetBundles)
local BundleInfo = require(scriptParentParent.Models.BundleInfo)
local createInspectAndBuyKeyMapper = require(scriptParentParent.createInspectAndBuyKeyMapper)
local SendCounter = require(scriptParentParent.Thunks.SendCounter)
local Constants = require(scriptParentParent.Constants)

local tbl1 = { Network, Analytics }

local inspectAndBuyKeyMapper = createInspectAndBuyKeyMapper("createFavoriteForBundle")

local function CreateFavoriteForBundle(arg1)
    return Thunk.new(script.Name, tbl1, function(arg2, arg3)
        local var1 = arg3[Network]
        local var2 = arg3[Analytics]

        local var3 = inspectAndBuyKeyMapper(arg2:getState().storeId, arg1)

        return PerformFetch.Single(var3, function()
            return var1.createFavoriteForBundle(arg1):andThen(function()
                arg2:dispatch(SetFavoriteBundle(arg1, true))
                local numFavorites = arg2:getState().bundles[arg1].numFavorites

                local getBundleFavoriteCount = BundleInfo.fromGetBundleFavoriteCount(arg1, numFavorites + 1)
                arg2:dispatch(SetBundles({ getBundleFavoriteCount }))
                var2.reportFavoriteItem("Bundle", arg1, true, true, "", numFavorites + 1)
                arg2:dispatch(SendCounter(Constants.Counters.CreateFavoriteForBundle .. Constants.CounterSuffix.RequestSucceeded))

                return Promise.resolve()
            end, function(arg4)
                arg2:dispatch(SendCounter(Constants.Counters.CreateFavoriteForBundle .. Constants.CounterSuffix.RequestRejected))

                return Promise.reject(tostring(arg4.StatusMessage))
            end)
        end)(arg2):catch(function(arg4)
            local numFavorites = arg2:getState().bundles[arg1].numFavorites
            var2.reportFavoriteItem("Bundle", arg1, true, false, arg4, numFavorites)
            arg2:dispatch(SendCounter(Constants.Counters.CreateFavoriteForBundle .. Constants.CounterSuffix.RequestFailed))
        end)
    end)
end

return CreateFavoriteForBundle
