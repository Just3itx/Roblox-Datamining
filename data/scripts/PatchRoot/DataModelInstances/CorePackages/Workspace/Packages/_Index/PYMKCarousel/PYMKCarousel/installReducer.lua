-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T13:31:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PYMKCarousel = script:FindFirstAncestor("PYMKCarousel")
local dependencies = require(PYMKCarousel.dependencies)

local Rodux = dependencies.Rodux
local RoduxNetworking = dependencies.RoduxNetworking
local RoduxAnalytics = require(script.RoduxAnalytics)
local Users = require(script.Users)
local Friends = require(script.Friends)
local RoduxPresence = require(script.RoduxPresence)

local _OmniTypes = require(PYMKCarousel.Common.OmniTypes)

local FFlagPymkCarouselPresenceStoreMigration = require(PYMKCarousel.Flags.FFlagPymkCarouselPresenceStoreMigration)

return function(arg1)
    if not (arg1.contentType and arg1.treatmentType) then
        return nil
    end

    return (Rodux.combineReducers({
        Users = Users(arg1),
        Friends = Friends(arg1),
        NetworkStatus = RoduxNetworking.installReducer(),
        Analytics = RoduxAnalytics(arg1),
        Presence = if FFlagPymkCarouselPresenceStoreMigration then nil else RoduxPresence.installReducer()
    }))
end
