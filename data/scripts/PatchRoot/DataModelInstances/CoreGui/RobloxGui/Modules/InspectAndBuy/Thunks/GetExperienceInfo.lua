-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:30:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local PerformFetch = require(CorePackages.Workspace.Packages.Http).PerformFetch

local scriptParentParent = script.Parent.Parent
local Thunk = require(scriptParentParent.Thunk)
local Network = require(scriptParentParent.Services.Network)
local createInspectAndBuyKeyMapper = require(scriptParentParent.createInspectAndBuyKeyMapper)
local ExperienceInfo = require(scriptParentParent.Models.ExperienceInfo)
local SetExperienceInfo = require(scriptParentParent.Actions.SetExperienceInfo)
local SendCounter = require(scriptParentParent.Thunks.SendCounter)
local Constants = require(scriptParentParent.Constants)

local tbl1 = { Network }

local inspectAndBuyKeyMapper = createInspectAndBuyKeyMapper("getExperienceInfo")

local function GetExperienceInfo(str1: string)
    local str2 = tostring(str1)

    return Thunk.new(script.Name, tbl1, function(arg1, arg2)
        local var1 = arg2[Network]

        local var2 = inspectAndBuyKeyMapper(arg1:getState().storeId, str2)

        return PerformFetch.Single(var2, function()
            return var1.getExperienceInfo(str2):andThen(function(arg3)
                local var3 = arg3.data[1]
                local getExperienceInfo = ExperienceInfo.fromGetExperienceInfo(var3)

                arg1:dispatch(SetExperienceInfo(getExperienceInfo))
                arg1:dispatch(SendCounter(Constants.Counters.GetExperienceInfo .. Constants.CounterSuffix.RequestSucceeded))
            end, function(_)
                arg1:dispatch(SendCounter(Constants.Counters.GetExperienceInfo .. Constants.CounterSuffix.RequestRejected))
            end)
        end)(arg1):catch(function(_)
            arg1:dispatch(SendCounter(Constants.Counters.GetExperienceInfo .. Constants.CounterSuffix.RequestFailed))
        end)
    end)
end

return GetExperienceInfo
