-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:31:08Z
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
local GetExperiencePlayability = require(scriptParentParent.Thunks.GetExperiencePlayability)
local GetExperienceInfo = require(scriptParentParent.Thunks.GetExperienceInfo)
local SendCounter = require(scriptParentParent.Thunks.SendCounter)
local Constants = require(scriptParentParent.Constants)

local tbl1 = { Network }

local inspectAndBuyKeyMapper = createInspectAndBuyKeyMapper("getVersionInfo")

local function GetVersionInfo(arg1)
    return Thunk.new(script.Name, tbl1, function(arg2, arg3)
        local var1 = arg3[Network]

        local var2 = inspectAndBuyKeyMapper(arg2:getState().storeId, arg1)

        return PerformFetch.Single(var2, function()
            return var1.getVersionInfo(arg1):andThen(function(arg4)
                local var3 = arg4.data[1]
                local creatingUniverseId = if var3 then var3.creatingUniverseId else nil

                if creatingUniverseId then
                    local str1 = tostring(creatingUniverseId)

                    local getVersionInfo = AssetInfo.fromGetVersionInfo(arg1, var3)

                    arg2:dispatch(SetAssets({ getVersionInfo }))

                    arg2:dispatch(GetExperiencePlayability(str1))

                    arg2:dispatch(GetExperienceInfo(str1))
                end
                arg2:dispatch(SendCounter(Constants.Counters.GetVersionInfo .. Constants.CounterSuffix.RequestSucceeded))
            end, function(_)
                arg2:dispatch(SendCounter(Constants.Counters.GetVersionInfo .. Constants.CounterSuffix.RequestRejected))
            end)
        end)(arg2):catch(function(_)
            arg2:dispatch(SendCounter(Constants.Counters.GetVersionInfo .. Constants.CounterSuffix.RequestFailed))
        end)
    end)
end

return GetVersionInfo
