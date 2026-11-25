-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:10:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local VirtualEvents = script:FindFirstAncestor("VirtualEvents")

local _GraphQLServer = require(VirtualEvents.Parent.GraphQLServer)
local React = require(VirtualEvents.Parent.React)
local Responsive = require(VirtualEvents.Parent.Responsive)
local CollectionViews = require(VirtualEvents.Parent.CollectionViews)
local sortEventsByStartDate = require(VirtualEvents.Common.sortEventsByStartDate)
local useGetGameTileHeight = require(VirtualEvents.Parent.GameCollections).useGetGameTileHeight
local useLocalization = require(VirtualEvents.Parent.Localization).Hooks.useLocalization
local Style = require(VirtualEvents.Parent.Style)
local useTextSizeOffset = require(VirtualEvents.Parent.UIBlox).Core.Style.useTextSizeOffset
local useDesignTokens = Style.useDesignTokens

local FrameBoundsImpressionsTracker = require(VirtualEvents.Parent.Impressions).FrameBoundsImpressionsTracker

local CollectionCarousel = CollectionViews.CollectionCarousel
local useCollectionImpressionsSignal = CollectionViews.useCollectionImpressionsSignal
local DiscoveryEventErrorLogger = require(VirtualEvents.Parent.DiscoveryUtils).DiscoveryEventErrorLogger

local EventTile = require(script.Parent.EventTile)

local useCallback = React.useCallback
local useEffect = React.useEffect

local FFlagLuaAppSduiEventDetailsEnabled = require(VirtualEvents.Parent.SharedFlags).FFlagLuaAppSduiEventDetailsEnabled

local FFlagLuaAppGameViewTileBackgroundColorOverride = require(VirtualEvents.Parent.SharedFlags).FFlagLuaAppGameViewTileBackgroundColorOverride

return function(tbl1)
    local var1 = useTextSizeOffset()
    local var2 = useDesignTokens()
    local disableButtons = Responsive.usePreferredInput() == Responsive.Input.Directional

    local impressionsTag = React.useMemo(function(): string
        return `EventsListCarousel_{tbl1.universeId}{HttpService:GenerateGUID()}`
    end, { tbl1.universeId })

    local surface200 = if FFlagLuaAppGameViewTileBackgroundColorOverride and tbl1.peekViewFormat then var2.Color.Surface.Surface_200 else nil
    local var4 = useCallback
    local function func1(event, layoutOrder: number, uDim2: UDim2, _: number?)
        return React.createElement(EventTile, {
            Event = event,
            DefaultThumbnail = tbl1.defaultThumbnail,
            backgroundStyle = surface200,
            onJoinEvent = tbl1.onJoinEvent,
            onRsvpChanged = tbl1.onRsvpChanged,
            onTileActivated = tbl1.onTileActivated,
            impressionsTag = impressionsTag,
            layoutOrder = layoutOrder,
            size = uDim2,
            disableButtons = disableButtons,
            suppressRsvpReminderToastBecauseEventDetailsFocused = if FFlagLuaAppSduiEventDetailsEnabled then tbl1.suppressRsvpReminderToastBecauseEventDetailsFocused else nil
        }), event.id
    end

    local defaultThumbnail = tbl1.defaultThumbnail
    local onJoinEvent = tbl1.onJoinEvent
    local onRsvpChanged = tbl1.onRsvpChanged
    local onTileActivated = tbl1.onTileActivated
    local suppressRsvpReminderToastBecauseEventDetailsFocused = if FFlagLuaAppSduiEventDetailsEnabled then tbl1.suppressRsvpReminderToastBecauseEventDetailsFocused else nil
    local var5 = if FFlagLuaAppGameViewTileBackgroundColorOverride then surface200 else nil
    local renderItem = var4(func1, {
        defaultThumbnail,
        onJoinEvent,
        onRsvpChanged,
        onTileActivated,
        suppressRsvpReminderToastBecauseEventDetailsFocused,
        impressionsTag,
        disableButtons,
        var5
    })

    local getItemHeight = useGetGameTileHeight(
        false,
        "Event",
        true,
        false,
        false,
        var1,
        if disableButtons then 0 else var2.Size.Size_700 + var2.Size.Size_200
    )

    local var8 = useLocalization({ title = "Feature.VirtualEvents.EventsListTitle" })

    local items = sortEventsByStartDate(tbl1.virtualEvents)
    local var10 = React.useRef({})
    local sendImpressions = useCallback(function(arg1)
        for _, index in arg1 do
            local var11 = items[index]

            if var11 == nil then
                DiscoveryEventErrorLogger.reportError(
                    "EventsListCarouselNilViewedEvent",
                    `Viewed event at index {index} was nil when sending Event Tile impressions with referral source {tbl1.referralSource}`,
                    {
                        index = index,
                        referralSource = tbl1.referralSource
                    }
                )
            elseif not var10.current[var11.id] then
                var10.current[var11.id] = true
                tbl1.onEventImpression(var11)
            end
        end
    end, { tbl1.onEventImpression, items, tbl1.referralSource })

    local var12 = React.useRef(nil)
    local scrollViewPositionChangedSignal, var14 = useCollectionImpressionsSignal()
    local dataUpdatedTimestamp, var16 = React.useState(os.clock())
    useEffect(function()
        var16(os.clock())
    end, { tbl1.virtualEvents })

    if #tbl1.virtualEvents == 0 then
        return nil
    end

    return React.createElement("Frame", {
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        ClipsDescendants = not tbl1.peekViewFormat,
        LayoutOrder = tbl1.layoutOrder
    }, {
        EventsCarousel = React.createElement(CollectionCarousel, {
            scrollingFrameRef = var12,
            title = var8.title,
            hideHeaderButton = true,
            items = items,
            renderItem = renderItem,
            getItemHeight = getItemHeight,
            onViewableItemsChanged = var14,
            onChangeCanvasPosition = var14,
            numColumns = if tbl1.peekViewFormat then 1 else 2,
            columnGap = var2.Size.Size_300,
            fractionalItemAmount = 0.33,
            sideMargin = 0
        }),
        FrameBoundsImpressionsTracker = React.createElement(FrameBoundsImpressionsTracker, {
            pageContext = tbl1.referralSource,
            parentRef = var12,
            impressionsTag = impressionsTag,
            scrollViewPositionChangedSignal = scrollViewPositionChangedSignal,
            sendImpressions = sendImpressions,
            dataUpdatedTimestamp = dataUpdatedTimestamp
        })
    })
end
