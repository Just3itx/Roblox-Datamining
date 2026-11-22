-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T23:30:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local StreamNotifications = script:FindFirstAncestor("StreamNotifications")
local StreamNotificationsParent = StreamNotifications.Parent
local React = require(StreamNotificationsParent.React)
local StreamNotifications2 = require(StreamNotifications.StreamNotifications)
local StreamNotificationStore = require(StreamNotifications.StreamNotificationStore)
local SharedFlags = require(StreamNotificationsParent.SharedFlags)
local ThirdPartyUserService = game:GetService("ThirdPartyUserService")
local HttpService = game:GetService("HttpService")

local UIBlox = require(StreamNotificationsParent.UIBlox)
local Badge = UIBlox.App.Indicator.Badge
local IconButton = UIBlox.App.Button.IconButton
local IconSize = UIBlox.App.Constant.IconSize
local Images = UIBlox.App.ImageSet.Images
local BadgeVariant = UIBlox.App.Indicator.Enum.BadgeVariant
local UtilityActionIcon = UIBlox.App.Button.UtilityActionIcon
local Foundation = require(StreamNotificationsParent.Foundation)
local Popover = Foundation.Popover
local PopoverSide = Foundation.Enums.PopoverSide
local PopoverAlign = Foundation.Enums.PopoverAlign
local useTokens = Foundation.Hooks.useTokens

local EventStream = require(StreamNotifications.analytics.analyticsService).EventStream
local NotificationHelper = require(StreamNotificationsParent.NotificationsCommon).NotificationHelper
local ixpHelper = require(StreamNotificationsParent.NotificationsCommon).ixpHelper
local constants = require(StreamNotifications.constants)
local analyticsConstants = require(StreamNotifications.analytics.analyticsConstants)

local GetFStringNotificationsStreamNotificationUXLayer = require(StreamNotificationsParent.SharedFlags).GetFStringNotificationsStreamNotificationUXLayer
local isAppNavEnabled = require(StreamNotificationsParent.SharedFlags).isAppNavEnabled
local useSignalState = require(StreamNotificationsParent.SignalsReact).useSignalState

local StreamNotificationDropdownExperimentation = require(StreamNotifications.StreamNotificationDropdownExperimentation)

local RoactAppPolicy = require(StreamNotificationsParent.UniversalAppPolicy).RoactAppPolicy

local GetFFlagNotificationsComplianceShouldRestrictStream = SharedFlags.GetFFlagNotificationsComplianceShouldRestrictStream
local FFlagEnableNotificationsDeeplink = SharedFlags.FFlagEnableNotificationsDeeplink
local FFlagStreamNotificationBellEntryPoint = SharedFlags.FFlagStreamNotificationBellEntryPoint
local FFlagSignalsNavP3bTopBar = SharedFlags.FFlagSignalsNavP3bTopBar
local FFlagEnableHeaderBarButtonsUpdate = SharedFlags.FFlagEnableHeaderBarButtonsUpdate
local FFlagStreamNotificationDropdownSingleOwner = SharedFlags.FFlagStreamNotificationDropdownSingleOwner
local FFlagStreamNotificationDropdownFocusedOwner = SharedFlags.FFlagStreamNotificationDropdownFocusedOwner
local iconsCommonNotificationOff = Images["icons/common/notificationOff"]

local function GetIsFriendCommunicationRestricted(): boolean | ThirdPartyUserService -- Luacid: Inlined by compiler; 3 call sites recovered
    return ThirdPartyUserService
        and ThirdPartyUserService:IsChatRestrictionSupported()
        and ThirdPartyUserService.FriendCommunicationRestrictionStatus ~= Enum.ChatRestrictionStatus.NotRestricted
end

local function func1(tbl1)
    local var1, var2 = React.useState(false)

    local current = nil
    if FFlagStreamNotificationDropdownSingleOwner then
        local var3 = React.useRef(nil)
        if var3.current == nil then
            var3.current = if FFlagStreamNotificationDropdownFocusedOwner then HttpService:GenerateGUID(false) elseif tbl1.isPrimary then StreamNotificationStore.PrimaryBellId else HttpService:GenerateGUID(false)
        end

        current = var3.current
    end

    local var3 = var1
    local var4 = nil
    local bool1 = tbl1.isFocused ~= false
    local bool2 = var1
    if FFlagEnableNotificationsDeeplink then
        var3 = useSignalState(StreamNotificationStore.getStreamPresented)
        if FFlagStreamNotificationDropdownSingleOwner then
            var4 = useSignalState(StreamNotificationStore.getActiveBellId)
            if FFlagStreamNotificationDropdownFocusedOwner then
                bool2 = StreamNotificationStore.isBellActive(var3, var4, current, tbl1.isPrimary, bool1)
            else
                bool2 = StreamNotificationStore.isBellActive(var3, var4, current, tbl1.isPrimary)
            end
        else
            bool2 = var3
        end
    end
    if FFlagStreamNotificationDropdownFocusedOwner and not bool1 then
        bool2 = false
    end

    local dropdownEnabled = StreamNotificationDropdownExperimentation.getDropdownEnabled()
    local var5 = useTokens()
    local var6 = if tbl1.notificationCount then tonumber(tbl1.notificationCount) or 0 else 0
    local layoutOrder = tbl1.layoutOrder

    local xOffset = if tbl1.compactWidth then 34 else 44

    if FFlagStreamNotificationDropdownFocusedOwner then
        React.useEffect(function()
            if bool1 then
                return
            end

            if FFlagEnableNotificationsDeeplink and var4 == current then
                if var3 then
                    StreamNotificationStore.setActiveBellId(nil)
                    StreamNotificationStore.setStreamPresented(false)
                    return
                end

                StreamNotificationStore.setActiveBellId(StreamNotificationStore.PrimaryBellId)
            elseif not FFlagEnableNotificationsDeeplink and var1 then
                var2(false)
            end
        end, {
            var4,
            current,
            bool1,
            var3,
            var1
        })
    end
    local function readEntryPoint() -- Luacid: Inlined by compiler; 3 call sites recovered
        if not FFlagStreamNotificationBellEntryPoint then
            return nil
        elseif FFlagSignalsNavP3bTopBar and tbl1.getEntryPoint then
            return (tbl1.getEntryPoint())
        end

        return tbl1.entryPoint
    end

    React.useEffect(function()
        if not (var6 > 0) then
            return
        end

        NotificationHelper.fireEvent(
            EventStream,
            analyticsConstants.Context.seen,
            analyticsConstants.EventNames.openCTAShown,
            {
                count = var6,
                sendrVersion = constants.SENDRVersion,
                entryPoint = readEntryPoint()
            }
        )
    end, { var6 })

    local displayStreamNotifications = React.useMemo(function()
        if not bool2 then
            return nil
        end

        return React.createElement(
            StreamNotifications2,
            {
                displayStream = if FFlagEnableNotificationsDeeplink then StreamNotificationStore.setStreamPresented else var2
            }
        )
    end, { bool2 })

    if GetFFlagNotificationsComplianceShouldRestrictStream() and tbl1.shouldRestrictStream then
        return nil
    end

    local badgeValue = if GetIsFriendCommunicationRestricted() then nil elseif var6 > 0 then var6 else nil

    local function onBellActivated()
        StreamNotificationDropdownExperimentation.logExposure()
        ixpHelper.logUserLayerExposure(GetFStringNotificationsStreamNotificationUXLayer())

        if dropdownEnabled then
            if FFlagEnableNotificationsDeeplink then
                if FFlagStreamNotificationDropdownSingleOwner then
                    StreamNotificationStore.setActiveBellId(if bool2 then nil else current)
                end
                StreamNotificationStore.setStreamPresented(not bool2)
            else
                var2(not bool2)
            end

            if bool2 then
                NotificationHelper.fireEvent(
                    EventStream,
                    analyticsConstants.Context.click,
                    analyticsConstants.EventNames.closeContent,
                    {
                        closeMethod = analyticsConstants.CloseMethod.bellIcon
                    }
                )
            else
                NotificationHelper.fireEvent(
                    EventStream,
                    analyticsConstants.Context.click,
                    analyticsConstants.EventNames.openContent,
                    {
                        countOfUnreadNotification = var6,
                        sendrVersion = constants.SENDRVersion,
                        entryPoint = readEntryPoint()
                    }
                )
            end
        else
            if FFlagEnableNotificationsDeeplink then
                if FFlagStreamNotificationDropdownSingleOwner then
                    StreamNotificationStore.setActiveBellId(current)
                end
                StreamNotificationStore.setStreamPresented(true)
            else
                var2(true)
            end

            NotificationHelper.fireEvent(
                EventStream,
                analyticsConstants.Context.click,
                analyticsConstants.EventNames.openContent,
                {
                    countOfUnreadNotification = var6,
                    sendrVersion = constants.SENDRVersion,
                    entryPoint = readEntryPoint()
                }
            )
        end

        if tbl1.onActivated then
            tbl1.onActivated()
        end
    end

    local function onPopoverDismiss()
        if FFlagEnableNotificationsDeeplink then
            if FFlagStreamNotificationDropdownSingleOwner then
                StreamNotificationStore.setActiveBellId(nil)
            end
            StreamNotificationStore.setStreamPresented(false)
        else
            var2(false)
        end
        NotificationHelper.fireEvent(
            EventStream,
            analyticsConstants.Context.click,
            analyticsConstants.EventNames.closeContent,
            {
                closeMethod = analyticsConstants.CloseMethod.backgroundOverlay
            }
        )
    end

    if FFlagEnableHeaderBarButtonsUpdate then
        local bellIcon = React.createElement(
            Foundation.View,
            {
                tag = "auto-xy radius-circle",
                LayoutOrder = layoutOrder or 3,
                ref = tbl1.buttonRef,
                testId = tbl1.testId
            },
            {
                IconButton = React.createElement(
                    Foundation.IconButton,
                    {
                        ZIndex = 1,
                        isCircular = true,
                        icon = Foundation.Enums.IconName.Bell,
                        onActivated = onBellActivated
                    }
                ),
                Badge = if GetIsFriendCommunicationRestricted() or not (var6 > 0) then nil else React.createElement(
                    Foundation.StatusIndicator,
                    {
                        AnchorPoint = Vector2.new(0, 1),
                        Position = UDim2.fromScale(0.5, 0.5),
                        ZIndex = 2,
                        variant = Foundation.Enums.StatusIndicatorVariant.Emphasis,
                        value = var6,
                        max = 99
                    }
                ),
                DisplayStreamNotifications = if dropdownEnabled then nil else displayStreamNotifications
            }
        )
        if isAppNavEnabled() and dropdownEnabled then
            return (React.createElement(Popover.Root, { isOpen = bool2 }, {
                Anchor = React.createElement(Popover.Anchor, nil, { BellIcon = bellIcon }),
                Content = React.createElement(Popover.Content, {
                    side = PopoverSide.Bottom,
                    align = PopoverAlign.End,
                    hasArrow = true,
                    onPressedOutside = onPopoverDismiss,
                    backgroundStyle = var5.Color.Surface.Surface_200
                }, { DisplayStreamNotifications = displayStreamNotifications })
            }))
        end

        return bellIcon
    elseif isAppNavEnabled() then
        local icon = if dropdownEnabled and bool2 then constants.Dropdown.BellIconOpen else iconsCommonNotificationOff

        if dropdownEnabled then
            return (React.createElement(Popover.Root, { isOpen = bool2 }, {
                Anchor = React.createElement(Popover.Anchor, nil, {
                    BellIcon = React.createElement(
                        UtilityActionIcon,
                        {
                            icon = icon,
                            onActivated = onBellActivated,
                            badgeValue = badgeValue,
                            buttonRef = tbl1.buttonRef
                        }
                    )
                }),
                Content = React.createElement(Popover.Content, {
                    side = PopoverSide.Bottom,
                    align = PopoverAlign.End,
                    hasArrow = true,
                    onPressedOutside = onPopoverDismiss,
                    backgroundStyle = var5.Color.Surface.Surface_200
                }, { DisplayStreamNotifications = displayStreamNotifications })
            }))
        end

        return (React.createElement(
            UtilityActionIcon,
            {
                icon = icon,
                onActivated = onBellActivated,
                badgeValue = badgeValue,
                buttonRef = tbl1.buttonRef
            },
            { DisplayStreamNotifications = displayStreamNotifications }
        ))
    else
        return (React.createElement(IconButton, {
            size = UDim2.new(0, xOffset, 1, 0),
            icon = iconsCommonNotificationOff,
            iconSize = IconSize.Medium,
            layoutOrder = layoutOrder or 3,
            onActivated = onBellActivated,
            buttonRef = tbl1.buttonRef
        }, {
            notificationBadge = if GetIsFriendCommunicationRestricted() or not (var6 > 0) then nil else React.createElement(
                Badge,
                {
                    position = UDim2.new(0.5, 0, 0.5, 0),
                    anchorPoint = Vector2.new(0, 1),
                    value = var6,
                    badgeVariant = BadgeVariant.Alert
                }
            )
        }, { displayStreamNotifications }))
    end
end
if GetFFlagNotificationsComplianceShouldRestrictStream() then
    func1 = RoactAppPolicy.connect(function(arg1, _)
        return {
            shouldRestrictStream = arg1.getNotificationsCanReceiveStream() or false
        }
    end)(func1)
end

return func1
