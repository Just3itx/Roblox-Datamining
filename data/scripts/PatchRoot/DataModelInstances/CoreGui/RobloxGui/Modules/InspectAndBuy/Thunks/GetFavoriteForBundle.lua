-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:31:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local PerformFetch = require(CorePackages.Workspace.Packages.Http).PerformFetch
local scriptParentParent = script.Parent.Parent
local Thunk = require(scriptParentParent.Thunk)
local Network = require(scriptParentParent.Services.Network)
local SetFavoriteBundle = require(scriptParentParent.Actions.SetFavoriteBundle)
local createInspectAndBuyKeyMapper = require(scriptParentParent.createInspectAndBuyKeyMapper)
local SendCounter = require(scriptParentParent.Thunks.SendCounter)
local Constants = require(scriptParentParent.Constants)

local tbl1 = { Network }

local inspectAndBuyKeyMapper = createInspectAndBuyKeyMapper("getFavoriteForBundle")

local function GetFavoriteForBundle(arg1)
    return Thunk.new(script.Name, tbl1, function(arg2, arg3)
        local var1 = arg3[Network]

        local var2 = inspectAndBuyKeyMapper(arg2:getState().storeId, arg1)

        return PerformFetch.Single(var2, function(_)
            return var1.getFavoriteForBundle(arg1):andThen(function(arg4)
                if arg4 == "null" then
                    arg2:dispatch(SetFavoriteBundle(tostring(arg1), false))
                else
                    arg2:dispatch(SetFavoriteBundle(tostring(arg1), true))
                end
                arg2:dispatch(SendCounter(Constants.Counters.GetFavoriteForBundle .. Constants.CounterSuffix.RequestSucceeded))
            end, function(_)
                arg2:dispatch(SendCounter(Constants.Counters.GetFavoriteForBundle .. Constants.CounterSuffix.RequestRejected))
            end)
        end)(arg2):catch(function(_)
            arg2:dispatch(SendCounter(Constants.Counters.GetFavoriteForBundle .. Constants.CounterSuffix.RequestFailed))
        end)
    end)
end

return GetFavoriteForBundle
