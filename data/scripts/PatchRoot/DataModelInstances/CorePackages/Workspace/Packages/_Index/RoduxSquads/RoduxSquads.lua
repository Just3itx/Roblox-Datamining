-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T15:10:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Reducers = require(script.Reducers)
local Actions = require(script.Actions)
local Models = require(script.Models)
local Enums = require(script.Enums)
local Hooks = require(script.Hooks)
local Logger = require(script.Logger)
local RoduxSquadsTypes = require(script.RoduxSquadsTypes)

local scriptParent = script.Parent
local Rodux = require(scriptParent.Rodux)
local Cryo = require(scriptParent.Cryo)
local RoduxNetworking = require(scriptParent.RoduxNetworking)
local NetworkingSquads = require(scriptParent.NetworkingSquads)

local FFlagUseSignalsForSquadExperienceInviteStatus = require(scriptParent.SharedFlags).FFlagUseSignalsForSquadExperienceInviteStatus
local FFlagUseSignalsForSquadExperienceInvite = require(scriptParent.SharedFlags).FFlagUseSignalsForSquadExperienceInvite

local module = {
    ["jest.config"] = script["jest.config"]
}

function module.config(arg1)
    local var1 = Cryo.Dictionary.join(arg1, { NetworkingSquads = NetworkingSquads.config({ roduxNetworking = RoduxNetworking.mock() }) })

    local currentSquad, currentSquadPersist, currentSquadPersistManager = Reducers.currentSquad(var1)
    return {
        installReducer = function()
            return Rodux.combineReducers({
                currentSquad = currentSquad,
                currentSquadPersist = currentSquadPersist,
                currentExperienceInvite = if FFlagUseSignalsForSquadExperienceInvite then nil else Reducers.currentExperienceInvite(var1),
                currentExperienceInviteStatus = if FFlagUseSignalsForSquadExperienceInviteStatus then nil else Reducers.currentExperienceInviteStatus()
            })
        end,
        PersistManagers = { currentSquadPersistManager = currentSquadPersistManager },
        Actions = Actions,
        Models = Models,
        Enums = Enums
    }
end
module.Hooks = Hooks
module.Logger = Logger
module.RoduxSquadsTypes = RoduxSquadsTypes
return module
