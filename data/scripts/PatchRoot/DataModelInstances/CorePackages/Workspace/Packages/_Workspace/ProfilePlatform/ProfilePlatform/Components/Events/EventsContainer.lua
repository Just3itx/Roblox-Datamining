-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:00:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent
local VirtualEvents = require(ProfilePlatformParent.VirtualEvents)
local EventsListCarousel = VirtualEvents.EventsListCarousel
local Enums = require(ProfilePlatform.Common.Enums)
local EventNames = require(ProfilePlatform.Analytics.EventNames)
local Cryo = require(ProfilePlatformParent.Cryo)
local _Signals = require(ProfilePlatformParent.Signals)

local useProfileWrapperContext = require(ProfilePlatform.Contexts.useProfileWrapperContext)
local useProfileJsonComponent = require(ProfilePlatform.Hooks.useProfileJsonComponent)
local useProfileAnalyticsContext = require(ProfilePlatform.Contexts.useProfileAnalyticsContext)

local LaunchGame = require(ProfilePlatform.Parent.GameLaunch).LaunchGame
local useNavigation = require(ProfilePlatform.Parent.Navigation).useNavigation

local _GraphQLServer = require(ProfilePlatform.Parent.GraphQLServer)

local useRoactService = require(ProfilePlatformParent.RobloxAppHooks).useRoactService
local AppGame = require(ProfilePlatformParent.RoactServiceTags).AppGame

local React = require(ProfilePlatformParent.React)
local HorizontalPageMargin = require(ProfilePlatformParent.UIBlox).App.Container.HorizontalPageMargin

local createGroupEventsStore = require(ProfilePlatform.Stores.createGroupEventsStore)

local useSignalState = require(ProfilePlatformParent.SignalsReact).useSignalState

local AppPage = require(ProfilePlatformParent.RobloxAppEnums).AppPage

local FFlagLuaAppSduiEventDetailsEnabled = require(ProfilePlatformParent.SharedFlags).FFlagLuaAppSduiEventDetailsEnabled
local navigateToEventDetails = require(ProfilePlatformParent.VirtualEvents).navigateToEventDetails

local useApolloClient = require(ProfilePlatformParent.ApolloClient).useApolloClient
local RoactNavigation = require(ProfilePlatformParent.RoactNavigation)

local EventsSkeleton = require(ProfilePlatform.Components.Events.EventsSkeleton)

local FFlagEnableCommunityProfileLoadingSkeletons = require(ProfilePlatform.Flags.FFlagEnableCommunityProfileLoadingSkeletons)

local function EventsContainer(tbl1)
    local var1 = useProfileJsonComponent(Enums.Components.Events)
    local var2 = tonumber(useProfileWrapperContext().profileId)

    local var3 = useRoactService(AppGame)
    local var4 = useNavigation()
    local var5 = useApolloClient()
    local var6 = useProfileAnalyticsContext()

    local var7 = React.useMemo(function()
        return createGroupEventsStore(var2)
    end, { var2 })

    local var8 = useSignalState(var7.getEvents)

    local virtualEvents = React.useMemo(function()
        local result = {}

        if var8 == nil then
            return result
        end

        local tbl2 = {}
        for _, value in ipairs(var8) do
            tbl2[value.id] = value
        end

        for _, value in ipairs(not var1 and {} or var1.events) do
            local var9 = tbl2[value.id]
            if var9 ~= nil then
                table.insert(result, var9)
            end
        end

        return result
    end, { var8, var1 })

    local var10 = if #virtualEvents > 0 then tonumber(virtualEvents[1].universeId) or 0 else 0

    local onRsvpChanged = React.useCallback(function(arg1, status)
        var6.fireAnalyticsEvent(EventNames.EventRSVP, { virtualEventId = arg1.id, status = status })

        VirtualEvents.fireVirtualEventRSVP(
            {
                virtualEventId = arg1.id,
                universeId = tostring(arg1.universeId),
                channel = "communityPeekView",
                status = status
            }
        )
        var7.updateRsvpStatus(arg1, status)

        var5.cache:modify({
            id = "VirtualEvent:" .. arg1.id,
            fields = {
                userRsvpStatus = function(_, _, _)
                    return status
                end,
                rsvpCounters = function(_, tbl2, _)
                    return Cryo.Dictionary.join(tbl2, { going = tbl2.going + (if status == "going" then 1 else -1) })
                end
            }
        })
    end, { var7 })

    local onTileActivated = React.useCallback(function(arg1)
        var6.fireAnalyticsEvent(EventNames.EventOpened, { virtualEventId = arg1.id })

        if FFlagLuaAppSduiEventDetailsEnabled then
            navigateToEventDetails(var4, arg1.id, tostring(arg1.universeId))
            return
        end
        var4.navigate(AppPage.EventDetails, { extraProps = { currentTime = DateTime.now(), virtualEventId = arg1.id } })
    end, { var4 })

    local onJoinEvent = React.useCallback(function(arg1)
        var6.fireAnalyticsEvent(EventNames.EventJoined, { virtualEventId = arg1.id })

        VirtualEvents.fireVirtualEventJoined(
            {
                virtualEventId = arg1.id,
                universeId = tostring(arg1.universeId),
                channel = "communityPeekView"
            }
        )
        LaunchGame(arg1.placeId, nil, { eventId = arg1.id }, var3)
    end, {})

    local onEventImpression = React.useCallback(function(arg1)
        VirtualEvents.fireVirtualEventImpression(
            {
                virtualEventId = arg1.id,
                universeId = arg1.universeId,
                channel = "communityPeekView"
            }
        )
    end, {})

    local var15 = if FFlagEnableCommunityProfileLoadingSkeletons then useSignalState(var7.isLoading) else false

    return React.createElement(
        HorizontalPageMargin,
        {
            size = UDim2.new(1, 0, 0, 0),
            backgroundTransparency = 1,
            layoutOrder = tbl1.layoutOrder,
            useAutomaticSizing = true
        },
        {
            NavEvents = React.createElement(RoactNavigation.NavigationEvents, {
                onDidFocus = function()
                    var7.refetch()
                end
            }),
            EventsCarousel = if FFlagEnableCommunityProfileLoadingSkeletons and var15 then React.createElement(EventsSkeleton, { numSkeletons = #var1.events }) else React.createElement(
                EventsListCarousel,
                {
                    virtualEvents = virtualEvents,
                    onTileActivated = onTileActivated,
                    onRsvpChanged = onRsvpChanged,
                    onJoinEvent = onJoinEvent,
                    onEventImpression = onEventImpression,
                    peekViewFormat = true,
                    referralSource = "communityPeekView",
                    universeId = var10
                }
            )
        }
    )
end

return EventsContainer
