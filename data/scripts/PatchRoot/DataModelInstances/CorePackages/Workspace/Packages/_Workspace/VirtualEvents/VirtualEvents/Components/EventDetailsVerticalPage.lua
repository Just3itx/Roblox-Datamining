-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:01:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VirtualEvents = script:FindFirstAncestor("VirtualEvents")

local ApolloClient = require(VirtualEvents.Parent.ApolloClient)
local _GraphQLServer = require(VirtualEvents.Parent.GraphQLServer)
local Cryo = require(VirtualEvents.Parent.Cryo)
local React = require(VirtualEvents.Parent.React)
local UIBlox = require(VirtualEvents.Parent.UIBlox)
local FocusNavigationUtils = require(VirtualEvents.Parent.FocusNavigationUtils)
local useRoactService = require(VirtualEvents.Parent.RobloxAppHooks).useRoactService
local RoactNetworking = require(VirtualEvents.Parent.RoactServiceTags).RoactNetworking
local FormFactor = require(VirtualEvents.Parent.FormFactor).Enums.FormFactor
local useSelector = require(VirtualEvents.Parent.RoactUtils).Hooks.RoactRodux.useSelector

local getEventTimerStatus = require(VirtualEvents.Common.getEventTimerStatus)
local findFirstImageInMedia = require(VirtualEvents.Common.findFirstImageInMedia)
local fetchEventThumbnail = require(VirtualEvents.Common.fetchEventThumbnail)
local EventDetailsContainer = require(VirtualEvents.Components.EventDetailsContainer)
local useCTAProps = require(VirtualEvents.Hooks.useCTAProps)
local useAnimation = require(VirtualEvents.Hooks.useAnimation)

local requests = require(VirtualEvents.requests)
local _VirtualEventsState = require(VirtualEvents.Parent.VirtualEventsState)
local constants = require(VirtualEvents.constants)

local useMutation = ApolloClient.useMutation

local Images = UIBlox.App.ImageSet.Images
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local UtilityActionIcon = UIBlox.App.Button.UtilityActionIcon
local LoadableImage = UIBlox.App.Loading.LoadableImage
local withStyle = UIBlox.Core.Style.withStyle

local FocusNavigableSurfaceWrapper = FocusNavigationUtils.FocusNavigableSurfaceWrapper
local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum

local iconsNavigationClose_small = Images["icons/navigation/close_small"]

local function func1() end

local tbl1 = { onClose = func1, onJoinEvent = func1, onShare = func1 }

local function EventDetailsVerticalPage(arg1)
    local var1 = Cryo.Dictionary.join(tbl1, arg1)

    local var2 = useRoactService(RoactNetworking)

    local isWideMode = useSelector(function(arg2)
        return arg2.FormFactor
    end) == FormFactor.WIDE

    local media = arg1.virtualEvent.media

    local yOffset, var3 = React.useState(0)
    local bottomHeight, var5 = React.useState(0)
    local image, var7 = React.useState(nil)
    local firstImageInMedia = if media then findFirstImageInMedia(media) else nil

    React.useEffect(function()
        local bool2 = true
        fetchEventThumbnail(var2, arg1.virtualEvent.id, firstImageInMedia):andThen(function(arg2)
            if bool2 then
                var7(arg2)
            end
        end)
        return function()
            bool2 = false
        end
    end, { arg1.virtualEvent.id, firstImageInMedia })

    local var8 = React.useCallback(function(arg2)
        local num1 = math.min(constants.HORIZONTAL_ASPECT_RATIO * arg2.AbsoluteSize.X, arg2.AbsoluteSize.Y)
        if num1 ~= yOffset then
            var3(num1)
        end
        local var8 = arg2.AbsoluteSize.Y - num1 + 40
        if var8 ~= bottomHeight then
            var5(var8)
        end
    end, { yOffset, bottomHeight })

    local var9 = useMutation(requests.UPDATE_RSVP_STATUS, {
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

    local eventStatus = React.useMemo(function()
        return getEventTimerStatus(var1.virtualEvent, var1.currentTime)
    end, { var1.virtualEvent, var1.currentTime })

    local onRsvpChanged = React.useCallback(function()
        local rsvpStatus = if var1.virtualEvent.userRsvpStatus == "going" then "notGoing" else "going"

        var9[1]({ variables = { rsvpStatus = rsvpStatus } }):andThen(function(arg2)
            if var1.onRsvpChanged then
                var1.onRsvpChanged(
                    arg2.data.virtualEventRsvp.virtualEvent.userRsvpStatus,
                    arg2.data.virtualEventRsvp.shouldSeeNotificationsUpsellModal
                )
            end
        end)
    end, { var1.virtualEvent })

    local ctaProps = useCTAProps(
        var1.virtualEvent,
        eventStatus,
        arg1.notifyMeUseEmphasisVariant,
        {
            onClose = var1.onClose,
            onJoinEvent = var1.onJoinEvent,
            onRsvpChanged = onRsvpChanged,
            onShare = var1.onShare
        }
    )

    local startOffset, setAnimationOffset = React.useState(constants.CONTAINER_WIDTH)
    useAnimation({
        startOffset = startOffset,
        endOffset = 0,
        duration = 0.1,
        easingStyle = "linear",
        setAnimationOffset = setAnimationOffset
    })

    return withStyle(function(arg2)
        local createElement = React.createElement
        local str1 = "Frame"
        local tbl2 = {
            Size = UDim2.fromScale(1, 1),
            BackgroundTransparency = 1
        }
        local tbl3 = {
            CloseButtonContainer = React.createElement("Frame", {
                ZIndex = 3,
                BackgroundTransparency = 1,
                Size = UDim2.fromOffset(48, 48),
                Position = if isWideMode then UDim2.new(1, -64, 0, 16) else UDim2.fromOffset(16, 16)
            }, {
                CloseButton = React.createElement(UtilityActionIcon, { ZIndex = 1, onActivated = arg1.onClose, onMedia = true }),
                CloseIcon = React.createElement(ImageSetLabel, {
                    ZIndex = 2,
                    Size = UDim2.fromOffset(24, 24),
                    Image = iconsNavigationClose_small,
                    ImageColor3 = arg2.Theme.IconEmphasis.Color,
                    BackgroundTransparency = 1,
                    Position = UDim2.fromOffset(12, 12)
                })
            }),
            MediaContainer = React.createElement(
                "Frame",
                {
                    BackgroundTransparency = 1,
                    Size = UDim2.fromScale(1, 1),
                    [React.Change.AbsoluteSize] = var8,
                    ZIndex = 1
                },
                {
                    Thumbnail = React.createElement(LoadableImage, {
                        Position = UDim2.fromScale(0, 0),
                        Size = UDim2.new(1, 0, 0, yOffset),
                        BackgroundTransparency = 1,
                        ScaleType = Enum.ScaleType.Crop,
                        Image = image,
                        useShimmerAnimationWhileLoading = true,
                        showFailedStateWhenLoadingFailed = true
                    })
                }
            ),
            EventContainer = React.createElement(
                "Frame",
                {
                    Size = UDim2.fromScale(1, 1),
                    BackgroundTransparency = 1,
                    ZIndex = 2
                },
                {
                    EventDetailsContainer = React.createElement(EventDetailsContainer, {
                        virtualEvent = arg1.virtualEvent,
                        eventStatus = eventStatus,
                        isWideMode = isWideMode,
                        ctaProps = ctaProps,
                        bottomHeight = bottomHeight,
                        onExperienceTileActivated = arg1.onExperienceTileActivated
                    })
                }
            )
        }
        local eventDetailsVerticalPage = createElement(str1, tbl2, tbl3)

        local createElement2 = React.createElement
        local str2 = "ImageButton"
        local tbl4 = {
            ZIndex = 4,
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            BackgroundColor3 = Color3.fromRGB(0, 0, 0),
            Active = true,
            AutoButtonColor = false,
            [React.Event.Activated] = arg1.onClose
        }
        local tbl5 = {
            EventDetailsWindow = React.createElement(FocusNavigableSurfaceWrapper, {
                surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.PopUp,
                isIsolated = true,
                frameProps = {
                    AnchorPoint = Vector2.new(1, 0),
                    Position = UDim2.new(1, startOffset, 0, 0),
                    Size = if isWideMode then UDim2.new(0, constants.CONTAINER_WIDTH, 1, 0) else UDim2.fromScale(1, 1),
                    BackgroundTransparency = arg2.Theme.BackgroundDefault.Transparency,
                    BackgroundColor3 = arg2.Theme.BackgroundDefault.Color,
                    BorderSizePixel = 0
                }
            }, {
                EventDetailsWrapper = React.createElement("ScrollingFrame", {
                    ScrollingDirection = Enum.ScrollingDirection.Y,
                    BackgroundTransparency = 1,
                    Size = UDim2.fromScale(1, 1),
                    Position = UDim2.fromScale(0, 0),
                    ScrollBarThickness = 0,
                    CanvasSize = UDim2.new(1, 0, 0, 0),
                    AutomaticCanvasSize = Enum.AutomaticSize.Y,
                    Selectable = false
                }, { EventDetailsVerticalPage = eventDetailsVerticalPage })
            })
        }
        return createElement2(str2, tbl4, tbl5)
    end)
end

return EventDetailsVerticalPage
