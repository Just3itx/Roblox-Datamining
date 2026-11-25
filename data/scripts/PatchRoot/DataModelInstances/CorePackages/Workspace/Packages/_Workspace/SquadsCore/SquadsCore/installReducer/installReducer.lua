-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T18:01:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SquadsCore = script:FindFirstAncestor("SquadsCore")
local SquadsCoreParent = SquadsCore.Parent

local SquadPromptReducer = require(script.Parent.SquadPromptReducer)

local RoduxNetworking = require(SquadsCore.Http.RoduxNetworking)
local RoduxPresence = require(SquadsCore.Http.RoduxPresence)
local RoduxSquads = require(SquadsCore.RoduxSquads)
local SquadLocation = require(SquadsCore.Enums.SquadLocation)
local UserBlockingRodux = require(SquadsCore.Http.UserBlockingRodux)

local FFlagSquadsPresenceStoreMigration = require(SquadsCore.Flags.FFlagSquadsPresenceStoreMigration)

local CrossExperience = require(SquadsCoreParent.CrossExperience)
local CrossExperienceVoice = require(SquadsCoreParent.CrossExperienceVoice)
local Rodux = require(SquadsCoreParent.Rodux)
local SharedFlags = require(SquadsCoreParent.SharedFlags)

local createPersistenceMiddleware = CrossExperience.Middlewares.createPersistenceMiddleware

local GetFFlagEnableCrossExpVoice = SharedFlags.GetFFlagEnableCrossExpVoice

local tbl1 = {
    NetworkStatus = RoduxNetworking.installReducer(),
    Presence = if FFlagSquadsPresenceStoreMigration then nil else RoduxPresence.installReducer(),
    Squad = RoduxSquads.installReducer(),
    SquadPrompt = SquadPromptReducer,
    UserBlocking = UserBlockingRodux.installReducer()
}

if GetFFlagEnableCrossExpVoice() then
    local var1 = createPersistenceMiddleware({ storeKey = CrossExperience.Constants.STORAGE_CEV_STORE_KEY }).restore()
    local crossExperienceVoice = if var1 and var1.Squad and var1.Squad.CrossExperienceVoice then var1.Squad.CrossExperienceVoice else nil
    tbl1.CrossExperienceVoice = CrossExperienceVoice.installReducer(crossExperienceVoice)
end

return function(inExperience)
    local tbl2 = tbl1
    tbl2.SquadPrompt = if inExperience == SquadLocation.InExperience then SquadPromptReducer else nil
    return Rodux.combineReducers(tbl1)
end
