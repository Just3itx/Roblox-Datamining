-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T12:00:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsCalling = script:FindFirstAncestor("FriendsCalling")
local FriendsCallingParent = FriendsCalling.Parent

local CallingService = game:GetService("CallingService")
local FriendsCallingService = game:GetService("FriendsCallingService")

local FloatingWindow = require(FriendsCallingParent.FloatingWindow)
local Foundation = require(FriendsCallingParent.Foundation)
local React = require(FriendsCallingParent.React)
local RoactUtils = require(FriendsCallingParent.RoactUtils)
local Responsive = require(FriendsCallingParent.Responsive)
local RobloxAppEnums = require(FriendsCallingParent.RobloxAppEnums)
local RobloxAppHooks = require(FriendsCallingParent.RobloxAppHooks)
local FFlagFriendsCallingServiceLuaMigration = require(FriendsCallingParent.SharedFlags.FFlagFriendsCallingServiceLuaMigration)

local _CallParticipantCard = require(FriendsCalling.Components.CallParticipant.CallParticipantCard)
local CollapsedCallOverlay = require(script.Parent.CollapsedCallOverlay)
local ExpandedCallOverlay = require(script.Parent.ExpandedCallOverlay)
local resolveGeometry = require(script.Parent.resolveGeometry)
local useCallPipViewModel = require(script.Parent.useCallPipViewModel)

local ColorMode = Foundation.Enums.ColorMode
local DeviceOrientationMode = RobloxAppEnums.DeviceOrientationMode
local FoundationProvider = Foundation.FoundationProvider
local useSelectedTheme = RoactUtils.Hooks.useSelectedTheme
local useDeviceInsets = Responsive.useDeviceInsets
local useDeviceOrientation = RobloxAppHooks.useDeviceOrientation
local useTokens = Foundation.Hooks.useTokens

local uDim2 = UDim2.fromOffset(120, 160)

local function noop() end

local var1 = table.freeze({ Compact = "Compact", Expanded = "Expanded" })

local function CallPipSession(arg1)
    local host = arg1.host
    local var2 = useTokens()
    local deviceInsets = useDeviceInsets()
    local isPortrait = useDeviceOrientation() ~= DeviceOrientationMode.Landscape

    local var4, var5 = React.useState(arg1.initialPresentation or var1.Compact)
    local dragInputTarget, var7 = React.useState(nil)
    local onDragInputTarget = React.useCallback(function(arg2)
        var7(arg2)
    end, {})
    local var9 = React.useCallback(function()
        var5(var1.Expanded)
    end, {})
    local var10 = React.useRef(arg1.expandCount)
    React.useEffect(function()
        if arg1.expandCount > var10.current then
            var10.current = arg1.expandCount
            var9()
        end
    end, { arg1.expandCount, var9 })
    local onCollapse = React.useCallback(function()
        var5(var1.Compact)
    end, {})
    local onEndCall = React.useCallback(function()
        local callId = arg1.callId or ""
        if FFlagFriendsCallingServiceLuaMigration then
            FriendsCallingService:EndCall(callId, "LuaEndAction")
            return
        end
        CallingService:EndCall(callId, "LuaEndAction")
    end, { arg1.callId })

    local bool2 = var4 == var1.Expanded
    local var13 = resolveGeometry({
        deviceInsets = deviceInsets,
        exposesTopSafeArea = host.exposesTopSafeArea,
        isPortrait = isPortrait,
        margin = var2.Padding.Medium
    })
    local element

    if bool2 then
        element = React.createElement(ExpandedCallOverlay, {
            connectedAt = arg1.connectedAt,
            participant = arg1.participant,
            hasRoundedCorners = var13.expanded.hasRoundedCorners,
            isMicrophoneMuted = arg1.isMicrophoneMuted,
            onCollapse = onCollapse,
            onDragInputTarget = onDragInputTarget,
            onEndCall = onEndCall,
            onOpenChat = noop,
            onToggleConversationAudio = noop,
            onToggleMicrophone = noop,
            topPadding = var13.expanded.topPadding
        })
    else
        element = React.createElement(CollapsedCallOverlay, {
            participant = arg1.participant,
            isMicrophoneMuted = arg1.isMicrophoneMuted,
            onDragInputTarget = onDragInputTarget,
            onToggleConversationAudio = noop,
            onToggleMicrophone = noop
        })
    end
    return React.createElement(FloatingWindow.Window, {
        behavior = FloatingWindow.Behaviors.Contained,
        boundsInsets = if bool2 then var13.expanded.boundsInsets else var13.collapsed.boundsInsets,
        children = element,
        displayOrder = host.displayOrder,
        dragInputTarget = dragInputTarget,
        enabled = arg1.enabled,
        draggable = not (bool2 and isPortrait),
        initialCenter = UDim2.fromScale(0.85, 0.2),
        onActivated = if bool2 then nil else var9,
        screenInsets = host.screenInsets,
        size = if bool2 then var13.expanded.size else uDim2,
        testId = "friends-calling-pip"
    })
end

local function CallPipWindow(tbl1)
    local var2 = useCallPipViewModel()

    return React.createElement(CallPipSession, {
        key = tostring(var2.session),
        callId = var2.callId,
        connectedAt = var2.connectedAt,
        enabled = var2.enabled,
        expandCount = var2.expandCount,
        host = tbl1.host,
        participant = var2.participant,
        isMicrophoneMuted = tbl1.isMicrophoneMuted,
        initialPresentation = tbl1.initialPresentation
    })
end

local function CallPip(tbl1)
    local var2 = useSelectedTheme()
    local colorMode = if tbl1.host.followsAppColorMode and var2 == "light" then ColorMode.Light else ColorMode.Dark
    return React.createElement(
        FoundationProvider,
        { colorMode = colorMode },
        {
            Window = React.createElement(CallPipWindow, tbl1)
        }
    )
end
return CallPip
