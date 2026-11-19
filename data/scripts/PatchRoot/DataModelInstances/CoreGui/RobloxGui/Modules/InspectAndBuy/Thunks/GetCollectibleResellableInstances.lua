-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:30:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local PerformFetch = require(CorePackages.Workspace.Packages.Http).PerformFetch
local scriptParentParent = script.Parent.Parent
local Thunk = require(scriptParentParent.Thunk)
local Network = require(scriptParentParent.Services.Network)
local SetCollectibleResellableInstances = require(scriptParentParent.Actions.SetCollectibleResellableInstances)
local createInspectAndBuyKeyMapper = require(scriptParentParent.createInspectAndBuyKeyMapper)
local SendCounter = require(scriptParentParent.Thunks.SendCounter)
local Constants = require(scriptParentParent.Constants)

local tbl1 = { Network }

local inspectAndBuyKeyMapper = createInspectAndBuyKeyMapper("getCollectibleResellableInstances")

local function GetCollectibleResellableInstances(arg1, arg2)
    return Thunk.new(script.Name, tbl1, function(arg3, arg4)
        local var1 = arg4[Network]

        local var2 = inspectAndBuyKeyMapper(arg3:getState().storeId, arg1, arg2)

        return PerformFetch.Single(var2, function()
            return var1.getCollectibleResellableInstances(arg1, arg2):andThen(function(arg5)
                local itemInstances = arg5 and arg5.itemInstances
                if itemInstances then
                    arg3:dispatch(SetCollectibleResellableInstances(arg1, itemInstances))
                end

                if itemInstances then
                    arg3:dispatch(
                        SendCounter(Constants.Counters.GetCollectibleResellableInstances .. Constants.CounterSuffix.RequestSucceeded)
                    )
                    return
                end

                arg3:dispatch(SendCounter(Constants.Counters.GetCollectibleResellableInstancesRequestSucceededWithoutResult))
            end, function(_)
                arg3:dispatch(
                    SendCounter(Constants.Counters.GetCollectibleResellableInstances .. Constants.CounterSuffix.RequestRejected)
                )
            end)
        end)(arg3):catch(function(_)
            arg3:dispatch(
                SendCounter(Constants.Counters.GetCollectibleResellableInstances .. Constants.CounterSuffix.RequestFailed)
            )
        end)
    end)
end

return GetCollectibleResellableInstances
