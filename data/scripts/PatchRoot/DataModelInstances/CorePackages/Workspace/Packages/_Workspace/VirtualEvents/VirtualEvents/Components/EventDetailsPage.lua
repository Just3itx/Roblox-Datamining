-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:01:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VirtualEvents = script:FindFirstAncestor("VirtualEvents")

local ApolloClient = require(VirtualEvents.Parent.ApolloClient)
local _GraphQLServer = require(VirtualEvents.Parent.GraphQLServer)
local Cryo = require(VirtualEvents.Parent.Cryo)
local React = require(VirtualEvents.Parent.React)
local UIBlox = require(VirtualEvents.Parent.UIBlox)
local useDeviceType = require(VirtualEvents.Parent.RobloxAppHooks).useDeviceType
local _RobloxAppEnums = require(VirtualEvents.Parent.RobloxAppEnums)
local useRoactService = require(VirtualEvents.Parent.RobloxAppHooks).useRoactService
local RoactNetworking = require(VirtualEvents.Parent.RoactServiceTags).RoactNetworking
local Responsive = require(VirtualEvents.Parent.Responsive)
local ReactFocusNavigation = require(VirtualEvents.Parent.ReactFocusNavigation)
local useCloseWithBackButton = require(VirtualEvents.Parent.AppBlox).useCloseWithBackButton

local getEventTimerStatus = require(VirtualEvents.Common.getEventTimerStatus)
local getGalleryItems = require(VirtualEvents.Common.getGalleryItems)
local fetchEventThumbnailList = require(VirtualEvents.Common.fetchEventThumbnailList)
local fetchEventThumbnail = require(VirtualEvents.Common.fetchEventThumbnail)
local useActionBarProps = require(VirtualEvents.Hooks.useActionBarProps)
local EventTimer = require(VirtualEvents.Components.EventTimer)
local EventDescription = require(VirtualEvents.Components.EventDescription)
local EventHostedBy = require(VirtualEvents.Components.EventHostedBy)
local Attendance = require(VirtualEvents.Components.Attendance)
local requests = require(VirtualEvents.requests)
local _VirtualEventsState = require(VirtualEvents.Parent.VirtualEventsState)

local FFlagLuaAppLimitEventThumbnailToOne = require(VirtualEvents.Flags.FFlagLuaAppLimitEventThumbnailToOne)

local useMutation = ApolloClient.useMutation

local AppBlox = require(VirtualEvents.Parent.AppBlox)
local DetailsPageTemplate = AppBlox.DetailsPageTemplate
local ContentPosition = AppBlox.ContentPosition
local MediaGalleryPreview = AppBlox.MediaGalleryPreview
local calcMediaGallerySizesFromWidth = AppBlox.calcMediaGallerySizesFromWidth
local ListTable = UIBlox.App.Table.ListTable
local function func1() end

local tbl1 = { onClose = func1, onJoinEvent = func1, onShare = func1 }

local function EventDetailsPage(arg1)
    local var1 = Cryo.Dictionary.join(tbl1, arg1)

    local media = arg1.virtualEvent.media
    local experienceDetails = arg1.virtualEvent.experienceDetails

    local yOffset, var2 = React.useState(0)

    local deviceType = useDeviceType()

    local items, var5 = React.useState({})
    local imageId = if items[1] then items[1].imageId else nil
    local var6 = useRoactService(RoactNetworking)

    React.useEffect(function()
        if FFlagLuaAppLimitEventThumbnailToOne then
            fetchEventThumbnail(var6, arg1.virtualEvent.id):andThen(function(imageId2)
                local tbl2 = {}
                if imageId2 then
                    table.insert(tbl2, { imageId = imageId2, isYouTubeVideo = false })
                end

                if #tbl2 > 0 then
                    var5(tbl2)
                    return
                end

                var5(getGalleryItems(media))
            end, function()
                var5(getGalleryItems(media))
            end)

            return
        end

        fetchEventThumbnailList(var6, arg1.virtualEvent.id):andThen(function(arg2)
            local tbl2 = {}
            if arg2 then
                for _, value in arg2 do
                    if value.mediaId then
                        table.insert(tbl2, { imageId = "rbxassetid://" .. value.mediaId, isYouTubeVideo = false })
                    end
                end
            end

            if #tbl2 > 0 then
                var5(tbl2)
                return
            end

            var5(getGalleryItems(media))
        end, function()
            var5(getGalleryItems(media))
        end)
    end, { arg1.virtualEvent.id, media })

    local var7 = useMutation(requests.UPDATE_RSVP_STATUS, {
        variables = {
            virtualEventId = arg1.virtualEvent.id
        },
        update = function(_, arg2, arg3)
            local virtualEvent = arg3.data.virtualEventRsvp.virtualEvent

            arg2:modify({
                id = arg2:identify(virtualEvent),
                fields = {
                    rsvpCounters = function(_, tbl2)
                        local num1 = if virtualEvent.userRsvpStatus == "going" then 1 else -1
                        return Cryo.Dictionary.join(tbl2, { going = tbl2.going + num1 })
                    end
                }
            })
        end
    })

    local var8 = React.useMemo(function()
        return getEventTimerStatus(var1.virtualEvent, var1.currentTime)
    end, { var1.virtualEvent, var1.currentTime })

    local var9 = React.useCallback(function(arg2)
        local absoluteSizeX = arg2.AbsoluteSize.X
        local offset = calcMediaGallerySizesFromWidth(absoluteSizeX, 5).contentSize.Y.Offset
        if offset ~= yOffset then
            var2(offset)
        end
    end, { yOffset })

    local onRsvpChanged = React.useCallback(function()
        local rsvpStatus = if var1.virtualEvent.userRsvpStatus == "going" then "notGoing" else "going"

        var7[1]({ variables = { rsvpStatus = rsvpStatus } }):andThen(function(arg2)
            if var1.onRsvpChanged then
                var1.onRsvpChanged(
                    arg2.data.virtualEventRsvp.virtualEvent.userRsvpStatus,
                    arg2.data.virtualEventRsvp.shouldSeeNotificationsUpsellModal
                )
            end
        end)
    end, { var1.virtualEvent })

    local var11 = React.useRef(nil)
    var11.current = Responsive.usePreferredInput()

    local disableStickyActionBar = var11.current == Responsive.Input.Directional

    local var12, var13 = ReactFocusNavigation.useMostRecentOrDefaultFocusBehavior()
    local containerRef = useCloseWithBackButton(var13, arg1.onClose)

    local var15 = ReactFocusNavigation.useFocusGuiObject()

    local var16, var17 = React.useState(nil)

    local var18 = React.useCallback(function(arg2)
        var17(arg2)

        if typeof(var12) == "function" then
            var12(arg2)
        end
    end, { var12 })

    React.useEffect(function()
        if var16 and var11.current == Responsive.Input.Directional then
            var15(var16)
        end
    end, { var16, var15 })

    local var19 = useActionBarProps(
        var1.virtualEvent,
        var8,
        {
            onClose = var1.onClose,
            onJoinEvent = var1.onJoinEvent,
            onShare = var1.onShare,
            onRsvpChanged = onRsvpChanged
        },
        var18
    )

    local var20 = React.useMemo(function()
        return var19.button or #var19.icons > 0
    end, { var19 })

    local tbl2 = {
        Attendance = var8 ~= "Elapsed"
            and {
                portraitLayoutOrder = 1,
                landscapePosition = ContentPosition.Left,
                landscapeLayoutOrder = 1,
                renderComponent = function()
                    return React.createElement(Attendance, { virtualEvent = var1.virtualEvent, eventStatus = var8 })
                end
            }
            or nil,
        MediaGallery = {
            portraitLayoutOrder = 2,
            landscapePosition = ContentPosition.Right,
            landscapeLayoutOrder = 1,
            renderComponent = function()
                return React.createElement(
                    "Frame",
                    {
                        Size = UDim2.new(1, 0, 0, yOffset),
                        BackgroundTransparency = 1,
                        [React.Change.AbsoluteSize] = var9
                    },
                    {
                        Gallery = React.createElement(MediaGalleryPreview, { items = items, numberOfThumbnails = 5 })
                    }
                )
            end
        },
        Description = {
            portraitLayoutOrder = 3,
            landscapePosition = ContentPosition.Left,
            landscapeLayoutOrder = 2,
            renderComponent = function()
                return React.createElement(EventDescription, {
                    description = var1.virtualEvent.description,
                    experienceName = if experienceDetails then experienceDetails.name else nil,
                    experienceThumbnail = ("rbxthumb://type=GameIcon&id=%s&w=150&h=150"):format(var1.virtualEvent.universeId),
                    onExperienceTileActivated = var1.onExperienceTileActivated
                })
            end
        },
        EventInfo = var1.virtualEvent.host
            and {
                portraitLayoutOrder = 4,
                landscapePosition = ContentPosition.Right,
                landscapeLayoutOrder = 2,
                renderComponent = function()
                    return React.createElement(ListTable, {
                        cells = { React.createElement(EventHostedBy, { host = var1.virtualEvent.host, onActivated = var1.onHostActivated }) }
                    })
                end
            }
            or nil
    }

    return React.createElement(DetailsPageTemplate, {
        deviceType = deviceType,
        titleText = if arg1.virtualEvent.eventStatus == "moderated" then "[CONTENT MODERATED]" else var1.virtualEvent.title,
        thumbnailImageUrl = imageId,
        thumbnailAspectRatio = Vector2.new(16, 9),
        renderInfoContent = function()
            return React.createElement(EventTimer, { virtualEvent = var1.virtualEvent, status = var8, currentTime = var1.currentTime })
        end,
        actionBarProps = if var20 then var19 else nil,
        componentList = arg1.virtualEvent.eventStatus == "cancelled" and {} or arg1.virtualEvent.eventStatus == "moderated" and {} or tbl2,
        onClose = var1.onClose,
        disableStickyActionBar = disableStickyActionBar,
        containerRef = containerRef
    })
end

return EventDetailsPage
