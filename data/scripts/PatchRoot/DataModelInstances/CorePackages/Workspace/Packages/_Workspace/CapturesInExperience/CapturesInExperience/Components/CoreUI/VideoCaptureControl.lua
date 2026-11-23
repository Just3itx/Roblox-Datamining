-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T23:41:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local React = require(scriptParentParentParentParent.React)
local ReactOtter = require(scriptParentParentParentParent.ReactOtter)
local RoactUtils = require(scriptParentParentParentParent.RoactUtils)
local Foundation = require(scriptParentParentParentParent.Foundation)
local Localization = require(scriptParentParentParentParent.Localization)

local Icon = Foundation.Icon
local IconName = Foundation.Enums.IconName
local IconSize = Foundation.Enums.IconSize
local PopoverAlign = Foundation.Enums.PopoverAlign
local Tooltip = Foundation.Tooltip
local View = Foundation.View

local RadialProgressBar = require(scriptParentParentParent.Components.CoreUI.RadialProgressBar)

local Constants = require(scriptParentParentParent.Constants)
local EventNames = require(scriptParentParentParent.Analytics.EventNames)
local StartVideoCapture = require(scriptParentParentParent.Thunks.StartVideoCapture)
local StopVideoCapture = require(scriptParentParentParent.Thunks.StopVideoCapture)
local isEligibleForMoments = require(scriptParentParentParent.Utils.isEligibleForMoments)
local logCaptureEndLayerExposure = require(scriptParentParentParent.Utils.logCaptureEndLayerExposure)

local useAnalytics = require(scriptParentParentParent.Analytics.useAnalytics)
local useCallback = React.useCallback
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local useEffect = React.useEffect
local useLocalization = Localization.Hooks.useLocalization
local useRef = React.useRef
local useSelector = RoactUtils.Hooks.RoactRodux.useSelector
local useTokens = Foundation.Hooks.useTokens

local CaptureTriggerType = require(scriptParentParentParent.Enums.CaptureTriggerType)

local duration = game:DefineFastInt("MaxVideoCaptureDurationSeconds", 30)
local FFlagCapturesControlsUseBuilderIcons = require(scriptParentParentParent.Flags.FFlagCapturesControlsUseBuilderIcons)
local FFlagMomentsCaptureEndIxpEnabled = require(scriptParentParentParent.Flags.FFlagMomentsCaptureEndIxpEnabled)

local FIntMomentsInExperienceMinCaptureSeconds = require(scriptParentParentParent.Flags.FIntMomentsInExperienceMinCaptureSeconds)

local name = if FFlagCapturesControlsUseBuilderIcons then IconName.FrameVideoCamera else "icons/controls/screenRecord_alt"
local Large = if FFlagCapturesControlsUseBuilderIcons then IconSize.Large else nil

return function(tbl1)
    local var2 = useAnalytics()
    local var3 = useDispatch()
    local var4 = useLocalization({
        captureVideo = "Feature.Captures.Title.CaptureVideoTooltip",
        videoCaptureInProgressTitle = "Feature.Captures.Title.VideoCaptureInProgressTooltip"
    })

    local var5 = useTokens()

    local var6 = useSelector(function(arg1)
        return arg1[Constants.RoduxKey].IsVideoCaptureActive.status
    end)

    local var7 = useSelector(function(arg1)
        return arg1[Constants.RoduxKey].IsVideoCaptureActive.triggerType
    end)

    local var8 = if FFlagMomentsCaptureEndIxpEnabled then useSelector(function(arg1)
        return arg1[Constants.RoduxKey].MomentsEligibility
    end) else nil

    local var9 = if FFlagMomentsCaptureEndIxpEnabled then useRef(nil) else nil

    if FFlagMomentsCaptureEndIxpEnabled then
        useEffect(function()
            local var10 = var9
            var10.current = if var6 then os.clock() else nil
        end, { var6 })
    end

    local function shouldLogCaptureEndExposure() -- Luacid: Inlined by compiler; 2 call sites recovered
        local current = var9.current

        local bool1 = isEligibleForMoments(var8)

        if bool1 then
            if current == nil then
                bool1 = false
            else
                local var10 = os.clock() - current
                bool1 = FIntMomentsInExperienceMinCaptureSeconds <= var10
            end
        end

        return bool1
    end

    local var10 = useCallback(function()
        if not var6 then
            return
        end

        var2.fireEvent(EventNames.CapturesEntrypointVideoDeactivatedAutomatically)

        var3(StopVideoCapture())

        if FFlagMomentsCaptureEndIxpEnabled and var7 == CaptureTriggerType.UserCapture and shouldLogCaptureEndExposure() then
            logCaptureEndLayerExposure()
        end
    end, FFlagMomentsCaptureEndIxpEnabled and { var6, var7, var8 } or { var6 })

    local progress, var12 = ReactOtter.useAnimatedBinding(0, var10)

    useEffect(function()
        if not var6 then
            var12(ReactOtter.instant(0))

            return
        end

        var12(ReactOtter.ease(1, { duration = duration, easingStyle = Enum.EasingStyle.Linear }))
    end, { var12, var6 })

    local onActivated = useCallback(function()
        if var6 then
            return
        end

        var2.fireEvent(EventNames.CapturesEntrypointVideoActivated)

        var3(StartVideoCapture())
    end, { var6 })

    local var1 = useCallback(function()
        if not var6 then
            return
        end

        var2.fireEvent(EventNames.CapturesEntrypointVideoDeactivated)

        var3(StopVideoCapture())

        if FFlagMomentsCaptureEndIxpEnabled and shouldLogCaptureEndExposure() then
            logCaptureEndLayerExposure()
        end
    end, FFlagMomentsCaptureEndIxpEnabled and { var6, var8 } or { var6 })

    local createElement = React.createElement
    local fragment = React.Fragment
    local var15 = nil
    local tbl2 = {
        VideoCaptureStartCTA = 0,
        VideoCaptureDisabledStartCTA = 0,
        VideoCaptureActiveView = 0
    }
    local element

    if var6 then
        element = nil
    else
        element = React.createElement(View, {
            LayoutOrder = tbl1.layoutOrder,
            onActivated = onActivated,
            tag = {
                ["size-1200-1200"] = true,
                ["anchor-center-center auto-xy clip position-center-center radius-circle"] = true
            }
        }, {
            StartIconWithTooltip = React.createElement(
                Tooltip,
                {
                    align = PopoverAlign.Center,
                    side = tbl1.popoverSide,
                    title = var4.captureVideo
                },
                React.createElement(View, { tag = "size-1200-1200" }, {
                    Icon = React.createElement(Icon, {
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        Position = UDim2.fromScale(0.5, 0.5),
                        name = name,
                        size = Large,
                        style = var5.Color.Content.Emphasis
                    })
                })
            )
        })
    end

    tbl2.VideoCaptureStartCTA = element
    local element2

    if var6 and var7 == CaptureTriggerType.LegacyCapture then
        element2 = React.createElement(
            View,
            {
                LayoutOrder = tbl1.layoutOrder,
                tag = "anchor-center-center auto-xy clip position-center-center radius-circle"
            },
            {
                StartIconWithTooltip = React.createElement(
                    Tooltip,
                    {
                        align = PopoverAlign.Center,
                        side = tbl1.popoverSide,
                        title = var4.videoCaptureInProgressTitle
                    },
                    React.createElement(Icon, { name = name, size = Large, style = var5.Color.Content.Muted })
                )
            }
        )
    else
        element2 = nil
    end

    tbl2.VideoCaptureDisabledStartCTA = element2
    local var16

    if var6 and (var7 == CaptureTriggerType.UserCapture or var7 == CaptureTriggerType.DeveloperCapture) then
        local createElement2 = React.createElement
        local var17 = View
        local tbl3 = {
            LayoutOrder = tbl1.layoutOrder,
            tag = "anchor-center-center clip position-center-center radius-circle size-900-900 padding-xxsmall"
        }
        local tbl4 = { VideoCaptureStopCTA = 0, VideoCaptureActiveIndicator = 0, ProgressBar = 0 }
        local element3

        if var7 == CaptureTriggerType.UserCapture then
            element3 = React.createElement(View, {
                tag = "anchor-center-center bg-over-media-300 col flex-evenly position-center-center size-700-700 radius-circle",
                onActivated = var1
            }, {
                VideoCaptureStopIcon = React.createElement(
                    Icon,
                    {
                        name = "icons/controls/mediaStop_small",
                        size = Foundation.Enums.IconSize.Small,
                        style = var5.Color.System.Alert
                    }
                )
            })
        else
            element3 = nil
        end

        tbl4.VideoCaptureStopCTA = element3

        tbl4.VideoCaptureActiveIndicator = if var7 == CaptureTriggerType.DeveloperCapture then React.createElement(
            View,
            {
                tag = "anchor-center-center col flex-evenly position-center-center size-700-700 radius-circle"
            },
            {
                VideoCaptureIndicatorIcon = React.createElement(View, { tag = "anchor-center-center bg-alert position-center-center size-300-300 radius-circle" })
            }
        ) else nil

        tbl4.ProgressBar = React.createElement(RadialProgressBar, { progress = progress })
        var16 = createElement2(var17, tbl3, tbl4)
    else
        var16 = nil
    end

    tbl2.VideoCaptureActiveView = var16
    return createElement(fragment, var15, tbl2)
end
