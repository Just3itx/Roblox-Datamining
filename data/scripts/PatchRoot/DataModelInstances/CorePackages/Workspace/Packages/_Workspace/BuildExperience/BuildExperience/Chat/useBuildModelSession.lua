-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:01:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local React = require(BuildExperienceParent.React)
local Signals = require(BuildExperienceParent.Signals)
local SignalsReact = require(BuildExperienceParent.SignalsReact)
local _CreatorAgentChat = require(BuildExperienceParent.DataHydration.CreatorAgentChat)
local GetBuildModelSelectionStore = require(BuildExperience.Stores.GetBuildModelSelectionStore)
local _createBuildModelSelectionStore = require(BuildExperience.Stores.GetBuildModelSelectionStore.createBuildModelSelectionStore)

local function useBuildModelSession(num1: number?, str1: string?, arg1)
    local buildModelSelectionStore = GetBuildModelSelectionStore(false)
    local var1 = React.useMemo(function()
        return Signals.createComputed(function(arg2)
            if num1 ~= nil and num1 > 0 then
                return buildModelSelectionStore.getUniverse(num1, arg2)
            elseif str1 ~= nil then
                return (buildModelSelectionStore.getDraft(str1, arg2))
            end

            return nil
        end)
    end, { buildModelSelectionStore, num1, str1 })
    local entry = SignalsReact.useSignalState(var1)
    local var3 = React.useMemo(function()
        return Signals.createComputed(function(arg2)
            if entry ~= nil and entry.getSelection(arg2) ~= nil and arg1 ~= nil then
                return (arg1.getModels(arg2))
            end

            return nil
        end)
    end, { entry, arg1 })
    local models = SignalsReact.useSignalState(var3)
    local var5 = React.useMemo(function()
        return Signals.createComputed(function(arg2)
            local selection = if entry == nil then nil else entry.getSelection(arg2)
            return not (selection == nil) and selection.isBusy
        end)
    end, { entry })
    local isBusy = SignalsReact.useSignalState(var5)
    local var7 = React.useMemo(function()
        return Signals.createComputed(function(arg2)
            return not (arg1 == nil) and arg1.hasObservedModels(arg2)
        end)
    end, { arg1 })
    local hasObservedModels = SignalsReact.useSignalState(var7)
    React.useEffect(function()
        if entry ~= nil and models ~= nil then
            entry.restoreTier(models.current)
        end
    end, { entry, models })
    return React.useMemo(function()
        return {
            entry = entry,
            models = models,
            isBusy = isBusy,
            hasObservedModels = hasObservedModels
        }
    end, {
        entry,
        models,
        isBusy,
        hasObservedModels
    })
end
return useBuildModelSession
