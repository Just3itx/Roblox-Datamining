-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:10:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VirtualEvents = script:FindFirstAncestor("VirtualEvents")
local VirtualEventsParent = VirtualEvents.Parent

local IXPService = game:GetService("IXPService")
local fireEventDetailsPageVisit = require(VirtualEvents.Analytics.fireEventDetailsPageVisit)
local fetchEventDetailsPage = require(script.Parent.fetchEventDetailsPage)
local getEventDetailsPageKey = require(script.Parent.getEventDetailsPageKey)
local EventDetailsFeedSkeleton = require(script.Parent.EventDetailsFeedSkeleton)
local EventDetailsFullBleedSkeleton = require(script.Parent.EventDetailsFullBleedSkeleton)
local EventDetailsActionBarSkeleton = require(script.Parent.EventDetailsActionBarSkeleton)
local _Navigation = require(VirtualEventsParent.Navigation)
local Foundation = require(VirtualEventsParent.Foundation)
local useTokens = Foundation.Hooks.useTokens
local React = require(VirtualEventsParent.React)
local useNavigation = require(VirtualEventsParent.Navigation).useNavigation
local useRouteName = require(VirtualEventsParent.Navigation).useRouteName
local useNavigationFocus = require(VirtualEventsParent.Navigation).useNavigationFocus
local useDeviceType = require(VirtualEventsParent.RobloxAppHooks).useDeviceType
local SduiSharedUtilities = require(VirtualEventsParent.SduiSharedUtilities)
local SduiPageEntryPoint = SduiSharedUtilities.SduiPageEntryPoint
local SduiFeatureEntryPoint = SduiSharedUtilities.SduiFeatureEntryPoint
local SduiLoadTimer = SduiSharedUtilities.SduiLoadTimer
local RobloxAppEnums = require(VirtualEventsParent.RobloxAppEnums)
local AppPage = RobloxAppEnums.AppPage
local DeviceType = RobloxAppEnums.DeviceType
local FFlagLuaAppSduiEventDetailsLogExposure = require(VirtualEventsParent.SharedFlags).FFlagLuaAppSduiEventDetailsLogExposure
local FFlagLuaAppSduiEventDetailsCenterSheet = require(VirtualEventsParent.SharedFlags).FFlagLuaAppSduiEventDetailsCenterSheet

local FFlagLuaAppSduiEventDetailsActionBarInFeed = require(VirtualEventsParent.SharedFlags).FFlagLuaAppSduiEventDetailsActionBarInFeed
local FStringLuaAppSduiEventDetailsIxpLayer = require(VirtualEventsParent.SharedFlags).FStringLuaAppSduiEventDetailsIxpLayer
local FFlagSduiPageEntryUseSharedHooks = require(VirtualEventsParent.SharedFlags).FFlagSduiPageEntryUseSharedHooks

local function getFromPropsOrNavigationParams(tbl1, str1: string) -- Luacid: Inlined by compiler; 4 call sites recovered
    local param = tbl1.navigation and tbl1.navigation.getParam("extraProps")
    return tbl1[str1] or param and param[str1]
end

local function _(str1: string, str2: string): string -- Luacid: unused: defined but never referenced
    return str1 .. "_" .. str2
end

return React.memo(function(tbl1) -- name: SduiEventDetailsPage
    local var1 = useTokens()
    local virtualEventId = getFromPropsOrNavigationParams(tbl1, "eventId") or tbl1.navigation and tbl1.navigation.getParam("detail")
    local fromPropsOrNavigationParams = getFromPropsOrNavigationParams(tbl1, "universeId")
    local channel = getFromPropsOrNavigationParams(tbl1, "referralSource")
    local configKey = getEventDetailsPageKey(virtualEventId)

    local pageTimer = React.useMemo(function()
        return getFromPropsOrNavigationParams(tbl1, "pageTimer") or SduiLoadTimer.createLoadTimer(AppPage.EventDetails)
    end, {})

    local var4 = useNavigation()
    local var5 = useRouteName()
    local isOpen = useNavigationFocus()
    local bool1

    if FFlagLuaAppSduiEventDetailsCenterSheet then
        local var7 = useDeviceType()
        bool1 = var7 == DeviceType.Desktop or var7 == DeviceType.Tablet
    else
        bool1 = nil
    end

    local onClose = React.useCallback(function()
        if var5 == AppPage.EventDetails and isOpen then
            var4.goBack()
        end
    end, { var4, var5, isOpen })

    React.useEffect(function()
        if virtualEventId then
            fetchEventDetailsPage(virtualEventId, pageTimer)
        end
    end, { virtualEventId, pageTimer })

    React.useEffect(function()
        if virtualEventId and FFlagLuaAppSduiEventDetailsLogExposure then
            IXPService:LogFlagLinkedUserLayerExposure(FStringLuaAppSduiEventDetailsIxpLayer)
        end
    end, { virtualEventId })

    React.useEffect(function()
        if not virtualEventId then
            return
        end

        fireEventDetailsPageVisit({
            virtualEventId = virtualEventId,
            universeId = tostring(fromPropsOrNavigationParams or ""),
            channel = channel or "link"
        })
    end, { virtualEventId })

    local scrollingFrameRef = React.useRef(nil)

    if virtualEventId == nil then
        return nil
    end

    return React.createElement(Foundation.Sheet.Root, {
        isOpen = isOpen,
        snapPoints = { 1 },
        displaySize = Foundation.Enums.DialogSize.Large,
        preferCenterSheet = bool1,
        centerSheetHeight = if FFlagLuaAppSduiEventDetailsCenterSheet then 1 else nil,
        onClose = onClose
    }, {
        FullBleed = React.createElement(Foundation.Sheet.FullBleed, {
            aspectRatio = 16 / 9
        }, {
            FullBleedContent = React.createElement(SduiFeatureEntryPoint, {
                appPage = AppPage.EventDetails,
                configKey = configKey,
                identifier = "event_details_sheet_full_bleed",
                loadingSlot = React.createElement(EventDetailsFullBleedSkeleton),
                shouldDisplayError = false,
                Size = UDim2.fromScale(1, 1),
                AutomaticSize = Enum.AutomaticSize.None
            })
        }),
        Content = React.createElement(
            Foundation.Sheet.Content,
            { scrollingFrameRef = scrollingFrameRef },
            React.createElement(SduiPageEntryPoint, {
                appPage = AppPage.EventDetails,
                configKey = configKey,
                identifier = if FFlagSduiPageEntryUseSharedHooks then "event_details_feed" else configKey .. "_event_details_feed",
                pageTimer = pageTimer,
                includeNavigationHeaderBar = false,
                backgroundStyle = var1.Color.None,
                disableRootPadding = true,
                scrollingFrameRef = scrollingFrameRef,
                snackbarPortalLayoutOrder = 2147483647,
                loadingSlot = React.createElement(EventDetailsFeedSkeleton)
            })
        ),
        Actions = if FFlagLuaAppSduiEventDetailsActionBarInFeed then nil else React.createElement(
            Foundation.Sheet.Actions,
            nil,
            React.createElement(SduiFeatureEntryPoint, {
                appPage = AppPage.EventDetails,
                configKey = configKey,
                identifier = "event_details_action_bar",
                loadingSlot = React.createElement(EventDetailsActionBarSkeleton),
                shouldDisplayError = false
            })
        )
    })
end)
