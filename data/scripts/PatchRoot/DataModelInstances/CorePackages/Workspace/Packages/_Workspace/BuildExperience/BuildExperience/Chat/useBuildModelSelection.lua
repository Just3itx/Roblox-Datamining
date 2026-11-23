-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:01:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local React = require(BuildExperienceParent.React)
local Signals = require(BuildExperienceParent.Signals)
local SignalsReact = require(BuildExperienceParent.SignalsReact)
local GetBuildModelSelectionStore = require(BuildExperience.Stores.GetBuildModelSelectionStore)
local _createBuildModelSelectionStore = require(BuildExperience.Stores.GetBuildModelSelectionStore.createBuildModelSelectionStore)
local _CreatorAgentChat = require(BuildExperienceParent.DataHydration.CreatorAgentChat)
local _ModelPickerTypes = require(BuildExperience.Components.ModelPicker.ModelPickerTypes)

local function useBuildModelSelection(num1: number?, str1: string?, arg1, bool1: boolean?, bool2: boolean?, internalTesting)
    local buildModelSelectionStore = GetBuildModelSelectionStore(false)
    local var1 = React.useMemo(function()
        return Signals.createComputed(function(arg3)
            if arg1 ~= nil then
                return nil
            elseif num1 ~= nil and num1 > 0 then
                return buildModelSelectionStore.getUniverse(num1, arg3)
            elseif str1 ~= nil then
                return (buildModelSelectionStore.getDraft(str1, arg3))
            end

            return nil
        end)
    end, {
        buildModelSelectionStore,
        num1,
        str1,
        arg1
    })

    local var2 = SignalsReact.useSignalState(var1)
    local var3 = React.useMemo(function()
        return Signals.createComputed(function(arg3)
            if var2 ~= nil then
                return (var2.getSelection(arg3))
            end

            return nil
        end)
    end, { var2 })
    local var4 = SignalsReact.useSignalState(var3)
    local onSelect = React.useCallback(function(str2: string)
        if var2 ~= nil
            and (str2 == "default" or str2 == "advanced")
            and var2.selectTier(str2)
            and internalTesting ~= nil
            and internalTesting.onExit ~= nil
        then
            internalTesting.onExit()
        end
    end, { var2, internalTesting })

    local var6 = React.useMemo(function()
        local options = {}
        for _, id in { "default", "advanced" } do
            local tbl2 = {
                id = id,
                model = if id == "default" then "Default" else "Advanced",
                isAvailable = bool1 == nil and (id == "default" or bool2 ~= true),
                isAvailabilityConfirmed = bool1 ~= nil or bool2 == true
            }
            if bool1 ~= nil then
                for _, value2 in bool1.available do
                    if value2.id == id then
                        tbl2.isAvailable = true
                        tbl2.rateMultiplier = value2.rateMultiplier
                    end
                end
            end
            table.insert(options, tbl2)
        end
        return { options = options }
    end, { bool1, bool2 })

    return React.useMemo(function()
        if arg1 ~= nil then
            return arg1
        end

        if var4 == nil then
            return nil
        end

        return {
            internalTesting = internalTesting,
            data = var6,
            selectedId = var4.intendedTier,
            isDisabled = var4.isBusy,
            onSelect = onSelect
        }
    end, {
        arg1,
        var4,
        onSelect,
        var6,
        internalTesting
    })
end
return useBuildModelSelection
