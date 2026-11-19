-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:30:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local PerformFetch = require(CorePackages.Workspace.Packages.Http).PerformFetch
local scriptParentParent = script.Parent.Parent
local Thunk = require(scriptParentParent.Thunk)
local Network = require(scriptParentParent.Services.Network)
local createInspectAndBuyKeyMapper = require(scriptParentParent.createInspectAndBuyKeyMapper)
local SendCounter = require(scriptParentParent.Thunks.SendCounter)
local Constants = require(scriptParentParent.Constants)

local tbl1 = { Network }

local inspectAndBuyKeyMapper = createInspectAndBuyKeyMapper("getPlayerModel")

local function GetCharacterModelFromUserId(arg1, arg2, callback)
    return Thunk.new(script.Name, tbl1, function(arg3, arg4)
        local var1 = arg4[Network]

        local var2 = inspectAndBuyKeyMapper(arg3:getState().storeId, arg1, arg2)

        return PerformFetch.Single(var2, function()
            return var1.getModelFromUserId(arg1):andThen(function(arg5)
                callback(arg5)
                arg3:dispatch(SendCounter(Constants.Counters.GetCharacterModelFromUserId .. Constants.CounterSuffix.RequestSucceeded))
            end, function(_)
                arg3:dispatch(SendCounter(Constants.Counters.GetCharacterModelFromUserId .. Constants.CounterSuffix.RequestRejected))
            end)
        end)(arg3):catch(function(_)
            arg3:dispatch(SendCounter(Constants.Counters.GetCharacterModelFromUserId .. Constants.CounterSuffix.RequestFailed))
        end)
    end)
end

return GetCharacterModelFromUserId
