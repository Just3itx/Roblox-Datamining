-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:01:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")
local CorePackages = game:GetService("CorePackages")
local CoreGui = game:GetService("CoreGui")

local SharedFlags = require(CorePackages.Workspace.Packages.SharedFlags)
local FStringLuaAppPlayButtonAgeCheckAmpFeatureName = SharedFlags.FStringLuaAppPlayButtonAgeCheckAmpFeatureName
local FStringLuaAppPlayButtonAgeCheckAmpNameSpace = SharedFlags.FStringLuaAppPlayButtonAgeCheckAmpNameSpace
local FFlagPioneerLeaveOnInExpFaeDownAge = SharedFlags.FFlagPioneerLeaveOnInExpFaeDownAge

local Logging = require(CorePackages.Workspace.Packages.AppCommonLib).Logging

local maybeLeavePioneerOnFaeDownAge = require(CorePackages.Workspace.Packages.PioneerUtils.maybeLeavePioneerOnFaeDownAge)

local module = {}

local function onPromptAgeCheckRequested(player: Player)
    local localPlayer = Players.LocalPlayer
    if player ~= localPlayer then
        return
    end

    local success, result = pcall(require, CorePackages.Workspace.Packages.AmpUpsell)
    if not (success and result and result.InExpAmpWizardController) then
        return
    end

    local success2, result2 = pcall(require, CoreGui.RobloxGui.Modules.ApolloClient)
    if not (success2 and result2) then
        return
    end

    result.InExpAmpWizardController.OpenAmpWizardContainerInExp(
        FStringLuaAppPlayButtonAgeCheckAmpFeatureName,
        function(arg1, arg2)
            local function notifyIfGranted() -- Luacid: Inlined by compiler; 1 call site recovered
                if arg1 ~= "Granted" then
                    return
                end

                local success3, result3 = pcall(function()
                    localPlayer:NotifyAgeCheckPassed()
                end)
                if not success3 then
                    Logging.warn("PromptAgeCheckRequested: NotifyAgeCheckPassed failed: " .. tostring(result3))
                end
            end

            if FFlagPioneerLeaveOnInExpFaeDownAge then
                local ampEnums = result.AmpEnums
                local bool1 = not (arg2 == nil) and arg2[ampEnums.ActionTypeEnum.AgeEstimation] == ampEnums.ActionStatusEnum.Success
                maybeLeavePioneerOnFaeDownAge(bool1, notifyIfGranted)
                return
            end

            notifyIfGranted()
        end,
        nil,
        "PromptAgeCheckRequested",
        nil,
        FStringLuaAppPlayButtonAgeCheckAmpNameSpace,
        result2
    )
end

function module.init()
    Players.PromptAgeCheckRequested:Connect(onPromptAgeCheckRequested)
end

return module
