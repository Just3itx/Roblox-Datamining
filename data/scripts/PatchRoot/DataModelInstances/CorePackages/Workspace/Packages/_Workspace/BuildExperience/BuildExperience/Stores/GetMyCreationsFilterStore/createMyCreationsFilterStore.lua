-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T21:01:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local Signals = require(BuildExperienceParent.Signals)
local SignalsReact = require(BuildExperienceParent.SignalsReact)

local function createMyCreationsFilterStore()
    local getFilter, setFilter = Signals.createSignal({ games = "MyGames" })

    return {
        getFilter = getFilter,
        useFilter = function()
            return SignalsReact.useSignalState(getFilter)
        end,
        setFilter = setFilter
    }
end

return createMyCreationsFilterStore
