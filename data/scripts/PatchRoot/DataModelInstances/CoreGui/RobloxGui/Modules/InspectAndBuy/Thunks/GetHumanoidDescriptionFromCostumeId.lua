-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:31:02Z
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

local inspectAndBuyKeyMapper = createInspectAndBuyKeyMapper("getHumanoidDescriptionFromCostumeId")

local function GetHumanoidDescriptionFromCostumeId(arg1, callback: (...any) -> (...any))
    return Thunk.new(script.Name, tbl1, function(arg2, arg3)
        local var1 = arg3[Network]

        local var2 = inspectAndBuyKeyMapper(arg2:getState().storeId, arg1)

        return PerformFetch.Single(var2, function()
            return var1.getHumanoidDescriptionFromCostumeId(arg1):andThen(function(arg4)
                callback(arg4)
                arg2:dispatch(
                    SendCounter(Constants.Counters.GetHumanoidDescriptionFromCostumeId .. Constants.CounterSuffix.RequestSucceeded)
                )
            end, function(_)
                arg2:dispatch(
                    SendCounter(Constants.Counters.GetHumanoidDescriptionFromCostumeId .. Constants.CounterSuffix.RequestRejected)
                )
            end)
        end)(arg2):catch(function(_)
            arg2:dispatch(
                SendCounter(Constants.Counters.GetHumanoidDescriptionFromCostumeId .. Constants.CounterSuffix.RequestFailed)
            )
        end)
    end)
end

return GetHumanoidDescriptionFromCostumeId
