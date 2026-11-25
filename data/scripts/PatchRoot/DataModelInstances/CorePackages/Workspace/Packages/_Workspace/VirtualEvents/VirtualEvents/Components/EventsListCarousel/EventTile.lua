-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:10:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VirtualEvents = script:FindFirstAncestor("VirtualEvents")

local VirtualEventsParent = VirtualEvents.Parent
local React = require(VirtualEventsParent.React)
local GameTile = require(VirtualEventsParent.GameTile)
local _GraphQLServer = require(VirtualEventsParent.GraphQLServer)
local RoactNetworking = require(VirtualEventsParent.RoactServiceTags).RoactNetworking
local ImpressionsTagUtility = require(VirtualEventsParent.Impressions).ImpressionsTagUtility
local useRoactService = require(VirtualEventsParent.RobloxAppHooks).useRoactService
local useLocalization = require(VirtualEventsParent.Localization).Hooks.useLocalization
local GamePlayButton = require(VirtualEventsParent.GamePlayButton)
local NotificationModalsManager = require(VirtualEventsParent.NotificationModalsManager)
local Style = require(VirtualEventsParent.Style)
local useTextSizeOffset = require(VirtualEventsParent.UIBlox).Core.Style.useTextSizeOffset
local useDesignTokens = Style.useDesignTokens
local HoldDetector = require(VirtualEventsParent.HoldToPlay).HoldDetector
local FocusNavigationEventNameEnum = require(VirtualEventsParent.FocusNavigationUtils).FocusNavigationEventNameEnum

local GameTileView = GameTile.GameTileView
local GridTileTextFooter = GameTile.GridTileTextFooter
local GameTileThumbnailBadges = GameTile.GameTileThumbnailBadges
local FooterCornerButtonStyle = GameTile.FooterCornerButtonStyle

local usePlayButtonState = GamePlayButton.usePlayButtonState
local PlayButtonStates = GamePlayButton.PlayButtonStates

local formatDateLocalized = require(VirtualEvents.Common.formatDateLocalized)
local getVirtualEventDates = require(VirtualEvents.Common.getVirtualEventDates)
local fetchEventThumbnail = require(VirtualEvents.Common.fetchEventThumbnail)
local getEventCtaButtonState = require(VirtualEvents.Common.getEventCtaButtonState)
local EventWideFooterButton = require(VirtualEvents.Components.EventsListCarousel.EventWideFooterButton)

local useEffect = React.useEffect
local useState = React.useState
local useMemo = React.useMemo
local useCallback = React.useCallback

local GetFFlagIsSquadEnabled = require(VirtualEventsParent.SharedFlags).GetFFlagIsSquadEnabled
local FFlagLuaAppSduiEventDetailsEnabled = require(VirtualEventsParent.SharedFlags).FFlagLuaAppSduiEventDetailsEnabled

local FFlagLuaAppGameViewTileBackgroundColorOverride = require(VirtualEventsParent.SharedFlags).FFlagLuaAppGameViewTileBackgroundColorOverride

local function func1() end

return function(tbl1)
    local var1 = useDesignTokens()
    local textSizeOffset = useTextSizeOffset()
    local event = tbl1.Event
    local virtualEventDates = getVirtualEventDates(event)

    local bool1 = DateTime.now().UnixTimestamp >= virtualEventDates.startDate.UnixTimestamp
    local bool2 = event.userRsvpStatus == "going"
    local buttonStyle = useMemo(function()
        return if bool1 then FooterCornerButtonStyle.Play elseif bool2 then FooterCornerButtonStyle.Following else FooterCornerButtonStyle.Follow
    end, { bool1, bool2 })

    local var4 = useRoactService(RoactNetworking)
    local var5 = usePlayButtonState(var4, tbl1.Event.universeId or "")
    local var6 = var5.playButtonState == PlayButtonStates.Playable
        or GetFFlagIsSquadEnabled() and var5.playButtonState == PlayButtonStates.PlayableWithParty

    local var7 = useLocalization({
        HappeningNow = "Feature.Home.Label.HappeningNow",
        DateAtTime = "Feature.VirtualEvents.Label.DateAtTime",
        ToastText = "Feature.VirtualEvents.Label.ReminderSetForEventTime"
    })

    local var8 = useCallback(function()
        if not var6 then
            return
        end

        if bool1 then
            tbl1.onJoinEvent(event)
        else
            local str1 = if event.userRsvpStatus == "going" then "notGoing" else "going"

            if tbl1.onRsvpChanged then
                tbl1.onRsvpChanged(event, str1)
            end
        end
    end, {
        bool1,
        tbl1.onJoinEvent,
        tbl1.onRsvpChanged,
        event.userRsvpStatus,
        event,
        var6
    })
    local var9 = React.useRef(event.userRsvpStatus)
    useEffect(function()
        if not (FFlagLuaAppSduiEventDetailsEnabled and tbl1.suppressRsvpReminderToastBecauseEventDetailsFocused)
            and var9.current
            and var9.current ~= "going"
            and event.userRsvpStatus == "going"
        then
            local eventTime = formatDateLocalized(var7.DateAtTime, virtualEventDates.startDate)
            local toastTitle = var7.ToastText:gsub("{(.-)}", { eventName = event.displayTitle, eventTime = eventTime })

            NotificationModalsManager.SetUIBloxToast({ toastTitle = toastTitle, sequenceNumber = DateTime.now().UnixTimestamp })
        end

        var9.current = event.userRsvpStatus
    end, {
        event.userRsvpStatus,
        event.displayTitle,
        virtualEventDates.startDate,
        var7.DateAtTime,
        var7.ToastText,
        if FFlagLuaAppSduiEventDetailsEnabled then tbl1.suppressRsvpReminderToastBecauseEventDetailsFocused else nil
    })

    local image, var11 = useState(nil)

    useEffect(function()
        local bool3 = true
        fetchEventThumbnail(var4, event.id, tbl1.DefaultThumbnail):andThen(function(arg1)
            if bool3 then
                var11(arg1)
            end
        end)
        return function()
            bool3 = false
        end
    end, { event.id, tbl1.DefaultThumbnail })

    local ref = React.useRef(nil)
    React.useEffect(function()
        ImpressionsTagUtility.AddTag(ref, tbl1.impressionsTag, tbl1.layoutOrder)
        return function()
            ImpressionsTagUtility.RemoveTag(ref, tbl1.impressionsTag, tbl1.layoutOrder)
        end
    end, { ref, tbl1.impressionsTag, tbl1.layoutOrder })

    local forwardRef = React.useRef(nil)
    local var14 = React.useRef(false)
    local setDisabledForHold = React.useCallback(function(current: boolean)
        var14.current = current
    end, {})

    local eventCtaButtonState = getEventCtaButtonState(var5)
    local isJoinEventDisabled = eventCtaButtonState.isJoinEventDisabled
    local isRsvpDisabled = eventCtaButtonState.isRsvpDisabled
    local var16

    if buttonStyle == FooterCornerButtonStyle.Follow then
        var16 = FocusNavigationEventNameEnum.HoldToNotifyMe
    elseif buttonStyle == FooterCornerButtonStyle.Following then
        var16 = FocusNavigationEventNameEnum.HoldToUnfollowEvent
    else
        var16 = FocusNavigationEventNameEnum.HoldToJoinEvent
        isRsvpDisabled = isJoinEventDisabled
    end

    if isRsvpDisabled then
        var8 = func1
    end
    local onActivated = useCallback(function()
        if var14.current then
            return
        end
        tbl1.onTileActivated(tbl1.Event)
    end, { tbl1.onTileActivated, tbl1.Event })

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        BackgroundTransparency = 1,
        LayoutOrder = tbl1.layoutOrder,
        Size = tbl1.size,
        ref = ref
    }
    local tbl3 = { GameTile = 0, HoldDetector = 0 }
    local createElement2 = React.createElement
    local var18 = GameTileView
    local tbl4 = {
        forwardRef = forwardRef,
        imageAspectRatio = 16 / 9,
        image = image,
        backgroundStyle = if FFlagLuaAppGameViewTileBackgroundColorOverride then tbl1.backgroundStyle else nil,
        isContained = true,
        Size = UDim2.fromScale(1, 1),
        title = event.displayTitle or "",
        onActivated = onActivated,
        footerMetadata = React.createElement(
            GridTileTextFooter,
            {
                text = event.displaySubtitle or event.displayDescription or "",
                useLargerFont = true
            }
        ),
        thumbnailOverlay = 0,
        hidePlayButton = true,
        isHovered = false,
        extraFooterSpace = 0,
        extraFooterContent = 0,
        textSizeOffset = 0
    }

    local createElement3 = React.createElement
    local var19 = GameTileThumbnailBadges
    local tbl5 = { tileBadgesByPosition = 0 }
    local tileBadgesByPosition = {
        ImageTopLeft = {{
            tileBadgeType = "Text",
            text = if bool1 then var7.HappeningNow else formatDateLocalized(var7.DateAtTime, virtualEventDates.startDate)
        }}
    }
    tbl5.tileBadgesByPosition = tileBadgesByPosition
    tbl4.thumbnailOverlay = createElement3(var19, tbl5)

    tbl4.extraFooterSpace = if tbl1.disableButtons then nil else var1.Size.Size_700 + var1.Size.Size_200

    tbl4.extraFooterContent = if tbl1.disableButtons then nil else React.createElement(
        EventWideFooterButton,
        {
            buttonStyle = buttonStyle,
            disabled = isRsvpDisabled,
            onActivated = var8,
            key = "WideFooterButton"
        }
    )

    tbl4.textSizeOffset = textSizeOffset
    tbl3.GameTile = createElement2(var18, tbl4)

    tbl3.HoldDetector = if forwardRef and forwardRef.current then React.createElement(HoldDetector, {
        guiObject = forwardRef.current,
        onHoldDetected = var8,
        setDisabledForHold = setDisabledForHold,
        keyCode = Enum.KeyCode.ButtonA,
        focusNavigationEventName = var16
    }) else nil
    return createElement(str1, tbl2, tbl3)
end
