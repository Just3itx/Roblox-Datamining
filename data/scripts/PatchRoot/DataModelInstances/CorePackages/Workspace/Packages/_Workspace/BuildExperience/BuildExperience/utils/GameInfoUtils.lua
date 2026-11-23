-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T21:11:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local DataHydration = require(BuildExperienceParent.DataHydration)
local React = require(BuildExperienceParent.React)
local Signals = require(BuildExperienceParent.Signals)
local SignalsReact = require(BuildExperienceParent.SignalsReact)

local function getGameInfoName(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    return if arg1 == nil or arg1.isUnavailable or typeof(arg1.name) ~= "string" or arg1.name == "" then nil else arg1.name
end

return {
    useGameInfo = function(num1: number?)
        local var1 = if num1 == nil then nil else tostring(num1)

        local var2 = React.useMemo(function()
            return Signals.createComputed(function(arg1)
                if var1 == nil then
                    return nil
                end

                return DataHydration.Game.getGameInfoStore(arg1).getAndFetchGameInfo(var1).data(arg1)
            end)
        end, { var1 })

        return SignalsReact.useSignalState(var2)
    end,
    isGameInfoReady = function(arg1): boolean
        return not (arg1 == nil) and not arg1.isUnavailable
    end,
    getGameInfoName = getGameInfoName,
    isTitleDescriptionReady = function(arg1): boolean
        return getGameInfoName(arg1) ~= nil
    end
}
