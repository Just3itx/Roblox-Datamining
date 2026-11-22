-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:11:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local Foundation = require(MomentsParent.Foundation)
local React = require(MomentsParent.React)
local ReactOtter = require(MomentsParent.ReactOtter)
local SharedFlags = require(MomentsParent.SharedFlags)
local Signals = require(MomentsParent.Signals)
local SignalsReact = require(MomentsParent.SignalsReact)
local MomentContext = require(script.Parent.MomentContext)
local playbackToggleIndicatorMachine = require(script.Parent.playbackToggleIndicatorMachine)
local useIsPlaying = require(Moments.Hooks.useIsPlaying)

local FFlagMomentsAutoplayAmpPolicy = SharedFlags.FFlagMomentsAutoplayAmpPolicy
local useSignalState = SignalsReact.useSignalState

local Icon = Foundation.Icon
local View = Foundation.View
local IconName = Foundation.Enums.IconName
local IconSize = Foundation.Enums.IconSize
local useTokens = Foundation.Hooks.useTokens
local usePreferences = Foundation.Hooks.usePreferences

local tbl1 = { frequency = 4, dampingRatio = 1 }
local tbl2 = {
    duration = 0.15,
    easingStyle = Enum.EasingStyle.Quad
}

local function defaultSchedule(num1: number, func1: (...any) -> (...any))
    local var1 = task.delay(num1 / 1000, func1)
    return function()
        task.cancel(var1)
    end
end

local function PlaybackToggleIndicator(tbl3)
    local controller = MomentContext.useMoment().controller
    local var1 = useTokens()
    local reducedMotion = usePreferences().reducedMotion

    local var2, setMounted = React.useState(false)
    local var4, var5 = ReactOtter.useAnimatedBinding(0)

    local var6 = useIsPlaying()

    local var7 = if FFlagMomentsAutoplayAmpPolicy then React.useMemo(function()
        return Signals.createComputed(function(arg1)
            if controller == nil then
                return "Idle"
            end

            return controller.getState(arg1).readiness
        end)
    end, { controller }) else nil

    local var8 = if FFlagMomentsAutoplayAmpPolicy then useSignalState(var7) else nil
    local var9 = React.useRef(nil)
    function var9.current(arg1)
        local var10 = if reducedMotion then ReactOtter.instant(if arg1 == "enter" then 1 else 0) elseif arg1 == "enter" then ReactOtter.spring(1, tbl1) else ReactOtter.ease(0, tbl2)
        var5(var10)
    end

    local var10 = React.useRef(nil)
    var10.current = tbl3.scheduleOverride or defaultSchedule

    local var11 = React.useMemo(function()
        return playbackToggleIndicatorMachine({ dwellMs = 800, exitDurationMs = 150 }, {
            schedule = function(num1: number, func1: (...any) -> (...any))
                return var10.current(num1, func1)
            end,
            setMounted = setMounted,
            animate = function(arg1)
                var9.current(arg1)
            end
        })
    end, {})

    React.useEffect(function()
        return function()
            var11.dispose()
        end
    end, { var11 })

    React.useEffect(function()
        if controller == nil then
            return
        end

        local var12 = nil
        return (Signals.createEffect(function(arg1)
            local userToggleNonce = controller.getUserToggleNonce(arg1)
            if var12 == nil then
                var12 = userToggleNonce
            elseif userToggleNonce ~= var12 then
                var12 = userToggleNonce
                var11.notifyUserToggle()
            end
        end))
    end, { controller, var11 })

    local var12 = if FFlagMomentsAutoplayAmpPolicy then var8 == "Ready" and not var6 else nil

    if not (var2 or FFlagMomentsAutoplayAmpPolicy and var12) then
        return nil
    end

    local scale = var4:map(function(num1: number): number
        return if FFlagMomentsAutoplayAmpPolicy and var12 then 1 else num1 * 0.25 + 0.75
    end)

    local groupTransparency = var4:map(function(num1: number): number
        return if FFlagMomentsAutoplayAmpPolicy and var12 then 0 else 1 - num1
    end)

    local createElement = React.createElement
    local var15 = View
    local tbl4 = {
        tag = "position-center-center anchor-center-center",
        Size = UDim2.fromOffset(64, 64),
        BackgroundTransparency = 1,
        scale = scale,
        ZIndex = 3
    }
    local tbl5 = { Circle = 0 }
    local createElement2 = React.createElement
    local var16 = View
    local tbl6 = {
        tag = "row align-x-center align-y-center size-full radius-circle clip bg-over-media-0",
        GroupTransparency = groupTransparency
    }
    local tbl7 = {
        Glyph = React.createElement(Icon, {
            name = if var6 then IconName.PauseLarge else IconName.PlayLarge,
            size = IconSize.Large,
            style = var1.Color.Content.Emphasis
        })
    }
    tbl5.Circle = createElement2(var16, tbl6, tbl7)
    return createElement(var15, tbl4, tbl5)
end

return PlaybackToggleIndicator
