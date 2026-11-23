-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T04:21:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VirtualEventsState = script:FindFirstAncestor("VirtualEventsState")

local Rodux = require(VirtualEventsState.Parent.Rodux)
local RoduxNetworking = require(VirtualEventsState.network).RoduxNetworking

local function installReducer()
    return Rodux.combineReducers({
        networkStatus = RoduxNetworking.installReducer(),
        events = require(VirtualEventsState.Reducers.events),
        media = require(VirtualEventsState.Reducers.media),
        experienceDetails = require(VirtualEventsState.Reducers.experienceDetails),
        rsvps = require(VirtualEventsState.Reducers.rsvps)
    })
end

return installReducer
