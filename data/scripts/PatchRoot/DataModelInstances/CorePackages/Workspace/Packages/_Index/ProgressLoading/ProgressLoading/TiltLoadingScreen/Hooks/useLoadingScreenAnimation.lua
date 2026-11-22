-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T12:40:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TiltLoadingScreen = script:FindFirstAncestor("TiltLoadingScreen")
local TiltLoadingScreenParent = TiltLoadingScreen.Parent
local TiltLoadingScreenParentParent = TiltLoadingScreenParent.Parent

local React = require(TiltLoadingScreenParentParent.React)
local Motion = require(TiltLoadingScreenParentParent.Motion)
local _Types = require(TiltLoadingScreenParent.LoadingScreenMilestones.Types)
local ContentId = require(TiltLoadingScreenParent.LoadingScreenMilestones.Constants).ContentId

local RunService = game:GetService("RunService")

local FFlagLoadingScreenMilestones = require(TiltLoadingScreenParentParent.SharedFlags).FFlagLoadingScreenMilestones
local FFlagTiltLoadingScreenEnterExitHold = require(TiltLoadingScreenParentParent.SharedFlags).FFlagTiltLoadingScreenEnterExitHold

local Constants = require(TiltLoadingScreen.Constants)
local ANIMATION = Constants.ANIMATION
local LOCKUP = Constants.LOCKUP
local TILT_DEGREES = Constants.KEYART.TILT_DEGREES

local state = Motion.createState({ keyart = 0, frame = 0, title = 0, creator = 0, verified = 0 })

local function revealed(arg1, duration: number)
    return Motion.createState(arg1, { default = Motion.transition({ duration = duration }) })
end

local var1 = revealed({ keyart = 1 }, ANIMATION.artDur)
local var2 = revealed({ frame = 1 }, ANIMATION.artDur)
local var3 = revealed({ title = 1 }, ANIMATION.textDur)
local var4 = revealed({ creator = 1, verified = 1 }, ANIMATION.textDur)

local state2 = Motion.createState(
    { keyart = 0, frame = 0, title = 0, creator = 0, verified = 0 },
    {
        default = Motion.transition({ duration = ANIMATION.closeDur })
    }
)
local state3 = Motion.createState(
    { keyart = 1, frame = 1, title = 1, creator = 1, verified = 1 },
    {
        default = Motion.transition({ duration = 0 })
    }
)
local function clamp01(num1: number): number -- Luacid: Inlined by compiler; 5 call sites recovered
    return math.clamp(num1, 0, 1)
end

local function scaleFromReveal(num1: number): number
    return math.min(1, clamp01(num1) * 0.5 + 0.5)
end

local function slideFromReveal(num1: number, num2: number): UDim
    return UDim.new(0, (1 - clamp01(num1)) * num2)
end

local _Types2 = require(TiltLoadingScreen.Types)

local function useLoadingScreenAnimation(current)
    local var5, var6 = Motion.useMotion(state)
    local var7 = React.useRef(var6)
    var7.current = var6
    local var8 = if FFlagLoadingScreenMilestones then React.useRef({}) else nil
    local var9 = if FFlagLoadingScreenMilestones then React.useRef(current.onContentRevealComplete) else nil

    if FFlagLoadingScreenMilestones then
        React.useLayoutEffect(function()
            if var9 then
                var9.current = current.onContentRevealComplete
            end
            return function()
                if var9 then
                    var9.current = nil
                end
            end
        end, { current.onContentRevealComplete })
    end
    local var10 = React.useRef(current)
    var10.current = current

    local var11 = React.useRef(current.onEnterComplete)
    var11.current = current.onEnterComplete

    local var12 = React.useRef({})

    local var13 = React.useRef({ timeline = false, cascade = false, title = false, creator = false, enterComplete = false })
    local elapsed, var15 = React.useBinding(0)
    local shouldReduceMotion, var17 = React.useBinding(current.reducedMotion)

    React.useEffect(function()
        var17(current.reducedMotion)
    end, { current.reducedMotion })

    local function cancelScheduled()
        for _, value in var12.current do
            pcall(task.cancel, value)
        end
        var12.current = {}
    end

    local function schedule(num1: number, func1: (...any) -> (...any)) -- Luacid: Inlined by compiler; 5 call sites recovered
        local var18 = task.delay(num1, func1)
        table.insert(var12.current, var18)
    end

    local function canAnimate(): boolean -- Luacid: Inlined by compiler; 4 call sites recovered
        local current2 = var10.current
        return not (current2.reducedMotion or current2.isDismissing)
    end

    local function fireEnterComplete() -- Luacid: Inlined by compiler; 2 call sites recovered
        if var13.current.enterComplete then
            return
        end
        var13.current.enterComplete = true
        if var11.current then
            var11.current()
        end
    end

    local function animateContentReveal(arg1, tbl1)
        local var18 = var8
        local tbl2 = {}
        for _, value in tbl1 do
            var18.current[value] = tbl2
        end
        var7.current(arg1, {
            onAnimationComplete = function(arg2)
                if arg2 ~= true or var10.current.isDismissing then
                    return
                end

                local current2 = if var9 then var9.current else nil

                if not current2 then
                    return
                end

                for _, value in tbl1 do
                    if var18.current[value] == tbl2 then
                        current2(value)
                    end
                end
            end
        })
    end

    local function startCreator()
        if var13.current.creator or not canAnimate() then
            return
        end
        var13.current.creator = true
        if FFlagLoadingScreenMilestones then
            animateContentReveal(var4, { ContentId.Creator })
        else
            var7.current(var4)
        end
        if FFlagTiltLoadingScreenEnterExitHold then
            schedule(ANIMATION.textDur, fireEnterComplete)
        end
    end

    local function startTitle()
        if var13.current.title or not (var10.current.contentReady and canAnimate()) then
            return
        end
        var13.current.title = true
        if FFlagLoadingScreenMilestones then
            animateContentReveal(var3, { ContentId.Title })
        else
            var7.current(var3)
        end
        schedule(ANIMATION.titleDelay, startCreator)
    end

    local function startTimeline()
        if var13.current.timeline or not canAnimate() then
            return
        end
        var13.current.timeline = true
        if FFlagLoadingScreenMilestones then
            animateContentReveal(var1, { ContentId.Thumbnail })
        else
            var7.current(var1)
        end
        schedule(ANIMATION.artDelay, function()
            if canAnimate() then
                var7.current(var2)
            end
        end)
        schedule(ANIMATION.cascade, function()
            var13.current.cascade = true
            startTitle()
        end)
        if not FFlagTiltLoadingScreenEnterExitHold then
            return
        end

        schedule(ANIMATION.artDur, function()
            if not var13.current.title then
                fireEnterComplete()
            end
        end)
    end

    local function startExitTimeline() -- Luacid: Inlined by compiler; 1 call site recovered
        var7.current(state2)
    end

    local function freeze()
        var7.current(
            Motion.createState({
                keyart = var5.keyart:getValue(),
                frame = var5.frame:getValue(),
                title = var5.title:getValue(),
                creator = var5.creator:getValue(),
                verified = var5.verified:getValue()
            }, {
                default = Motion.transition({ duration = 0 })
            })
        )
    end
    React.useEffect(function()
        if FFlagLoadingScreenMilestones and var8 and (current.isDismissing or current.reducedMotion) then
            var8.current = {}
        end
        if current.isDismissing then
            cancelScheduled()
            if current.reducedMotion then
                var7.current(state)
                return
            end

            startExitTimeline()
            return
        end

        if not current.reducedMotion then
            startTimeline()
            if current.contentReady and var13.current.cascade then
                startTitle()
            end

            return
        end

        cancelScheduled()
        var13.current = {
            timeline = true,
            cascade = true,
            title = true,
            creator = true,
            enterComplete = false
        }

        if FFlagLoadingScreenMilestones then
            animateContentReveal(state3, { ContentId.Title, ContentId.Creator, ContentId.Thumbnail })
        else
            var7.current(state3)
        end
        if FFlagTiltLoadingScreenEnterExitHold then
            fireEnterComplete()
        end
    end, { current.contentReady, current.isDismissing, current.reducedMotion })

    React.useEffect(function()
        if current.reducedMotion or current.isDismissing then
            return
        end

        local startTime = os.clock()
        local connection = RunService.Heartbeat:Connect(function()
            var15(os.clock() - startTime)
        end)

        return function()
            connection:Disconnect()
        end
    end, { current.isDismissing, current.reducedMotion })

    React.useEffect(function()
        return function()
            if FFlagLoadingScreenMilestones and var8 then
                var8.current = {}
            end
            cancelScheduled()
            freeze()
        end
    end, {})

    local var18 = React.useRef(nil)
    if var18.current == nil then
        var18.current = {
            keyart = {
                rotation = var5.keyart:map(function(num1: number)
                    return TILT_DEGREES * clamp01(num1)
                end),
                sizeScale = var5.keyart:map(scaleFromReveal),
                coverTransparency = var5.keyart:map(clamp01)
            },
            frame = {
                rotation = React.joinBindings({ reveal = var5.frame, elapsed = elapsed, shouldReduceMotion = shouldReduceMotion }):map(function(arg1)
                    local reveal = arg1.reveal
                    local elapsed = arg1.elapsed
                    local var19 = if arg1.shouldReduceMotion then 0 else math.sin(elapsed * ANIMATION.wobbleSpeed * 2 * math.pi * 0.28 + 0.9) * ANIMATION.wobbleAngle * 1.4 * clamp01(reveal)
                    return -TILT_DEGREES * reveal + var19
                end),
                sizeScale = var5.frame:map(scaleFromReveal),
                groupTransparency = var5.frame:map(function(num1: number): number
                    return math.min(1, (1 - clamp01(num1)) * 2)
                end)
            },
            title = {
                reveal = var5.title,
                slide = var5.title:map(function(num1: number): UDim
                    return slideFromReveal(num1, LOCKUP.TITLE_SLIDE)
                end)
            },
            creator = {
                reveal = var5.creator,
                slide = var5.creator:map(function(num1: number): UDim
                    return slideFromReveal(num1, LOCKUP.SUB_SLIDE)
                end)
            },
            verified = {
                reveal = var5.verified
            }
        }
    end

    return var18.current
end

return useLoadingScreenAnimation
