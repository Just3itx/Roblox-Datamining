-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T20:00:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameJoinCardParent = script:FindFirstAncestor("GameJoinCard").Parent

local TimeToInteractiveTracker = require(GameJoinCardParent.TimeToInteractiveTracker).TimeToInteractiveTracker
local FFlagMobileGameJoinCardTTITracking = require(GameJoinCardParent.SharedFlags).FFlagMobileGameJoinCardTTITracking

local EventName = {
    MobileCardMounted = "MobileGameJoinCardOpened_Mounted",
    MobileBannerMounted = "MobileGameJoinCardOpened_BannerLoaded",
    PeopleListMounted = "PeopleListContextualMenuOpen_Mounted"
}

local Surface = {
    MobileGameJoinCard = "mobile_game_join_card",
    PeopleListContextualMenu = "people_list_contextual_menu"
}

local module = { EventName = EventName, Surface = Surface }

local var1 = nil

function module.trackMobileCardClickStart()
    var1 = tick() * 1000

    if not FFlagMobileGameJoinCardTTITracking then
        return
    end

    TimeToInteractiveTracker.trackStart(EventName.MobileCardMounted, true)
    TimeToInteractiveTracker.updateMetadata(
        EventName.MobileCardMounted,
        {
            category = "social_game_join_card",
            page = Surface.MobileGameJoinCard
        }
    )
    TimeToInteractiveTracker.trackStart(EventName.MobileBannerMounted, true)
    TimeToInteractiveTracker.updateMetadata(
        EventName.MobileBannerMounted,
        {
            category = "social_game_join_card",
            page = Surface.MobileGameJoinCard
        }
    )
end

function module.consumeMobileCardClickStartMs()
    local var2 = var1
    var1 = nil
    return var2
end

function module.trackCardMounted()
    if not FFlagMobileGameJoinCardTTITracking then
        return
    end

    TimeToInteractiveTracker.trackEnd(EventName.MobileCardMounted)
end

function module.trackBannerLoaded()
    if not FFlagMobileGameJoinCardTTITracking then
        return
    end

    TimeToInteractiveTracker.trackEnd(EventName.MobileBannerMounted)
end

function module.trackPeopleListClickStart()
    if not FFlagMobileGameJoinCardTTITracking then
        return
    end

    TimeToInteractiveTracker.trackStart(EventName.PeopleListMounted, true)
    TimeToInteractiveTracker.updateMetadata(
        EventName.PeopleListMounted,
        {
            category = "social_game_join_card",
            page = Surface.PeopleListContextualMenu
        }
    )
end

function module.trackPeopleListMounted()
    if not FFlagMobileGameJoinCardTTITracking then
        return
    end

    TimeToInteractiveTracker.trackEnd(EventName.PeopleListMounted)
end

return module
