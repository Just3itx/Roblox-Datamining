-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T01:21:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PeopleReactView = script:FindFirstAncestor("PeopleReactView")
local PeopleReactViewParent = PeopleReactView.Parent

local Foundation = require(PeopleReactViewParent.Foundation)
local React = require(PeopleReactViewParent.React)
local SignalsReact = require(PeopleReactViewParent.SignalsReact)
local Signals = require(PeopleReactViewParent.Signals)
local PeopleService = require(PeopleReactViewParent.PeopleService)

local FFlagVoiceVolumeControlsEnablePerUserVolumeInteractionTelemetry = PeopleService.getService("Flags").FFlagVoiceVolumeControlsEnablePerUserVolumeInteractionTelemetry
local ENTRY_POINT = PeopleService.getService("Constants").ANALYTICS.ENTRY_POINT

local View = Foundation.View
local IconName = Foundation.Enums.IconName
local IconSize = Foundation.Enums.IconSize
local ControlState = Foundation.Enums.ControlState
local StateLayerAffordance = Foundation.Enums.StateLayerAffordance
local useTokens = Foundation.Hooks.useTokens
local useCursor = Foundation.Hooks.useCursor
local useSignalState = SignalsReact.useSignalState

local VoiceVolumePopover = require(PeopleReactView.Components.Buttons.VoiceVolumePopover)

local signal = Signals.createSignal("")
local signal2 = Signals.createSignal(false)

local var1 = React.memo(function(tbl1)
    local var1 = useTokens()
    local name = useSignalState(tbl1.animatedIcon or signal)
    local var3 = useSignalState(tbl1.isGrayedOut or signal2)

    if name == "" then
        return nil
    end

    return (React.createElement(Foundation.Icon, {
        name = name,
        size = IconSize.Medium,
        style = {
            Transparency = if var3 then var1.Color.Common.Shadow.Transparency else nil
        }
    }))
end)

local function MuteVolumeButton(tbl1)
    local var2 = useTokens()
    local xxSmall = var2.Gap.XXSmall
    local config = tbl1.config

    local var3, var4 = React.useState(false)
    local var5 = if FFlagVoiceVolumeControlsEnablePerUserVolumeInteractionTelemetry then React.useRef(false) else nil

    local var6, var7 = React.useState(ControlState.Initialize)
    local var8, var9 = React.useState(ControlState.Initialize)

    local selectionImageObject = useCursor({ radius = UDim.new(0, var2.Radius.Medium), offset = var2.Size.Size_150, borderWidth = var2.Stroke.Thicker })

    local onActivated = React.useCallback(function()
        config.onActivated(tbl1.entryPoint)
    end, { config.onActivated, tbl1.entryPoint })

    local var10 = if FFlagVoiceVolumeControlsEnablePerUserVolumeInteractionTelemetry then React.useCallback(function()
        if tbl1.userId == nil or not var5 then
            return
        end

        local current = not var5.current
        var5.current = current
        if current then
            PeopleService.getService("PeopleAnalyticsManager"):recordPerUserVoiceVolumeUiOpened(
                tbl1.entryPoint or ENTRY_POINT.PEOPLE_LIST
            )
        end

        var4(current)
    end, { tbl1.entryPoint, tbl1.userId }) else React.useCallback(function()
        var4(function(arg1): boolean
            return not arg1
        end)
    end, {})

    local onClose = React.useCallback(function()
        if FFlagVoiceVolumeControlsEnablePerUserVolumeInteractionTelemetry and var5 then
            var5.current = false
        end
        var4(false)
    end, {})

    local ref = React.useCallback(function(arg1)
        if tbl1.onButtonMount then
            tbl1.onButtonMount(arg1, tbl1.muteButtonName)
        end
    end, { tbl1.onButtonMount, tbl1.muteButtonName })

    local var11 = React.useCallback(function(arg1)
        if tbl1.onButtonMount then
            tbl1.onButtonMount(arg1, tbl1.volumeButtonName)
        end
    end, { tbl1.onButtonMount, tbl1.volumeButtonName })

    local onStateChanged = React.useCallback(function(arg1)
        var7(arg1)
    end, {})

    local var12 = React.useCallback(function(arg1)
        var9(arg1)
    end, {})

    local isOpen = var3 and tbl1.userId ~= nil

    local size1000 = var2.Size.Size_1000
    local size1000_2 = var2.Size.Size_1000
    local var19 = tbl1.LayoutOrder or config.layoutOrder

    local function getInteractionOverlayStyle(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
        if arg1 == ControlState.Pressed then
            return var2.Color.State.Press
        end

        if arg1 == ControlState.Hover then
            return var2.Color.State.Hover
        end

        return nil
    end

    local backgroundStyle = getInteractionOverlayStyle(var6)
    local interactionOverlayStyle = getInteractionOverlayStyle(var8)
    local createElement = React.createElement
    local var20 = View
    local tbl2 = {
        tag = "size-1000-1000",
        onActivated = onActivated,
        onStateChanged = onStateChanged,
        selection = { SelectionImageObject = selectionImageObject },
        LayoutOrder = var19,
        ref = ref,
        stateLayer = {
            affordance = StateLayerAffordance.None
        }
    }
    local tbl3 = {
        Background = React.createElement(View, {
            tag = "radius-left-medium size-1000-1000 bg-action-standard"
        }, {
            StateOverlay = if backgroundStyle then React.createElement(View, { backgroundStyle = backgroundStyle, tag = "radius-left-medium size-full" }) else nil
        }),
        IconOverlay = React.createElement(
            View,
            { tag = "row align-x-center align-y-center size-full", ZIndex = 2, Active = false },
            {
                Icon = React.createElement(var1, { animatedIcon = config.animatedIcon, isGrayedOut = config.isGrayedOut })
            }
        )
    }
    local muteHalf = createElement(var20, tbl2, tbl3)

    local createElement2 = React.createElement
    local var21 = View
    local tbl4 = {
        tag = "size-1000-1000",
        onActivated = var10,
        onStateChanged = var12,
        selection = { SelectionImageObject = selectionImageObject },
        LayoutOrder = var19 + 1,
        ref = var11,
        stateLayer = {
            affordance = StateLayerAffordance.None
        }
    }
    local tbl5 = {
        Background = React.createElement(View, {
            tag = "radius-right-medium size-1000-1000 bg-action-standard"
        }, {
            StateOverlay = if interactionOverlayStyle then React.createElement(View, { backgroundStyle = interactionOverlayStyle, tag = "radius-right-medium size-full" }) else nil
        }),
        IconOverlay = 0
    }

    local createElement3 = React.createElement
    local var22 = View
    local tbl6 = {
        tag = "row align-x-center align-y-center size-full padding-right-xxsmall",
        ZIndex = 2,
        Active = false
    }

    local tbl7 = {
        ChevronIcon = React.createElement(
            Foundation.Icon,
            {
                name = if isOpen then IconName.ChevronSmallUp else IconName.ChevronSmallDown,
                size = IconSize.Large
            }
        )
    }
    tbl5.IconOverlay = createElement3(var22, tbl6, tbl7)
    local chevronHalf = createElement2(var21, tbl4, tbl5)

    return React.createElement(VoiceVolumePopover, {
        userId = tbl1.userId,
        isOpen = isOpen,
        onClose = onClose,
        layoutOrder = var19,
        muteHalf = muteHalf,
        chevronHalf = chevronHalf,
        pillWidth = size1000 * 2 + xxSmall,
        pillHeight = size1000_2,
        alignOffset = size1000 + xxSmall,
        isMutedByLocalUser = config.isGrayedOut,
        entryPoint = if FFlagVoiceVolumeControlsEnablePerUserVolumeInteractionTelemetry then tbl1.entryPoint else nil
    })
end

return MuteVolumeButton
